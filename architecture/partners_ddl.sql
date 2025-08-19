-- ==========================================
-- PARTNERS TABLE
-- ==========================================

CREATE TABLE partners (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    partner_type TEXT NOT NULL CHECK (partner_type IN ('affiliate', 'service_provider')),
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'active', 'suspended', 'rejected')),
    referral_code TEXT NOT NULL UNIQUE,
    commission_type TEXT NOT NULL CHECK (commission_type IN ('lump_sum', 'recurring')),
    commission_rate DECIMAL(5,4) CHECK (commission_rate >= 0 AND commission_rate <= 1),
    lump_sum_amount DECIMAL(10,2) CHECK (lump_sum_amount >= 0),
    lump_sum_months INTEGER CHECK (lump_sum_months > 0),
    payout_method TEXT CHECK (payout_method IN ('stripe', 'paypal', 'bank_transfer', 'check')),
    payout_account_ref TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- Ensure each user can only be one type of partner
    CONSTRAINT unique_user_partner UNIQUE (user_id),
    
    -- Business logic constraints (simplified - no OLD/NEW references)
    CONSTRAINT valid_recurring_commission CHECK (
        (commission_type = 'recurring' AND commission_rate IS NOT NULL)
        OR
        (commission_type = 'lump_sum' AND lump_sum_amount IS NOT NULL AND lump_sum_months IS NOT NULL)
    )
);

-- ==========================================
-- SERVICE_PROVIDER_CLIENTS TABLE  
-- ==========================================

CREATE TABLE service_provider_clients (
    service_provider_id UUID NOT NULL REFERENCES partners(id) ON DELETE CASCADE,
    consumer_user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    transactions_access BOOLEAN NOT NULL DEFAULT true,
    account_balance_access BOOLEAN NOT NULL DEFAULT false,
    assigned_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    
    -- Composite primary key
    PRIMARY KEY (service_provider_id, consumer_user_id)
);

-- ==========================================
-- INDEXES FOR PERFORMANCE
-- ==========================================

-- Index for referral code lookups (frequent for affiliate tracking)
CREATE INDEX idx_partners_referral_code ON partners(referral_code);

-- Index for partner type filtering
CREATE INDEX idx_partners_type_status ON partners(partner_type, status);

-- Index for service provider client lookups
CREATE INDEX idx_service_provider_clients_provider ON service_provider_clients(service_provider_id);
CREATE INDEX idx_service_provider_clients_consumer ON service_provider_clients(consumer_user_id);

-- ==========================================
-- UPDATED_AT TRIGGERS
-- ==========================================

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Trigger for partners table
CREATE TRIGGER update_partners_updated_at
    BEFORE UPDATE ON partners
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- ==========================================
-- BUSINESS LOGIC VALIDATION TRIGGERS
-- ==========================================

-- Function to validate commission structure
CREATE OR REPLACE FUNCTION validate_commission_structure()
RETURNS TRIGGER AS $$
BEGIN
    -- For recurring commissions
    IF NEW.commission_type = 'recurring' THEN
        IF NEW.commission_rate IS NULL THEN
            RAISE EXCEPTION 'commission_rate is required for recurring commission type';
        END IF;
        IF NEW.lump_sum_amount IS NOT NULL OR NEW.lump_sum_months IS NOT NULL THEN
            RAISE EXCEPTION 'lump_sum fields must be NULL for recurring commission type';
        END IF;
    END IF;
    
    -- For lump sum commissions
    IF NEW.commission_type = 'lump_sum' THEN
        IF NEW.lump_sum_amount IS NULL OR NEW.lump_sum_months IS NULL THEN
            RAISE EXCEPTION 'lump_sum_amount and lump_sum_months are required for lump_sum commission type';
        END IF;
        IF NEW.commission_rate IS NOT NULL THEN
            RAISE EXCEPTION 'commission_rate must be NULL for lump_sum commission type';
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to validate commission structure
CREATE TRIGGER validate_commission_structure_trigger
    BEFORE INSERT OR UPDATE ON partners
    FOR EACH ROW
    EXECUTE FUNCTION validate_commission_structure();

-- Function to validate service provider type
CREATE OR REPLACE FUNCTION validate_service_provider_type()
RETURNS TRIGGER AS $$
BEGIN
    -- Check if the partner is actually a service provider
    IF NOT EXISTS (
        SELECT 1 FROM partners 
        WHERE id = NEW.service_provider_id 
        AND partner_type = 'service_provider'
    ) THEN
        RAISE EXCEPTION 'Partner must be of type service_provider to have clients assigned';
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger to enforce service provider type constraint
CREATE TRIGGER validate_service_provider_type_trigger
    BEFORE INSERT OR UPDATE ON service_provider_clients
    FOR EACH ROW
    EXECUTE FUNCTION validate_service_provider_type();

-- ==========================================
-- ROW LEVEL SECURITY (RLS)
-- ==========================================

-- Enable RLS on both tables
ALTER TABLE partners ENABLE ROW LEVEL SECURITY;
ALTER TABLE service_provider_clients ENABLE ROW LEVEL SECURITY;

-- ==========================================
-- RLS POLICIES FOR PARTNERS TABLE
-- ==========================================

-- Partners can view their own record
CREATE POLICY "Partners can view own record" ON partners
    FOR SELECT USING (auth.uid() = user_id);

-- Partners can update their own non-critical fields
CREATE POLICY "Partners can update own record" ON partners
    FOR UPDATE USING (auth.uid() = user_id);

-- System can insert new partners
CREATE POLICY "System can insert partners" ON partners
    FOR INSERT WITH CHECK (true);

-- System can view all partners
CREATE POLICY "System can view all partners" ON partners
    FOR SELECT USING (
        current_setting('role') = 'service_role'
    );

-- System can update all partner fields
CREATE POLICY "System can update partners" ON partners
    FOR UPDATE USING (
        current_setting('role') = 'service_role'
    );

-- ==========================================
-- RLS POLICIES FOR SERVICE_PROVIDER_CLIENTS TABLE
-- ==========================================

-- Service providers can view their own client assignments
CREATE POLICY "Service providers can view own clients" ON service_provider_clients
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM partners 
            WHERE partners.id = service_provider_clients.service_provider_id 
            AND partners.user_id = auth.uid()
            AND partners.partner_type = 'service_provider'
        )
    );

-- Consumers can view service providers assigned to them
CREATE POLICY "Consumers can view assigned service providers" ON service_provider_clients
    FOR SELECT USING (auth.uid() = consumer_user_id);

-- Service providers can insert client assignments
CREATE POLICY "Service providers can assign clients" ON service_provider_clients
    FOR INSERT WITH CHECK (
        EXISTS (
            SELECT 1 FROM partners 
            WHERE partners.id = service_provider_clients.service_provider_id 
            AND partners.user_id = auth.uid()
            AND partners.partner_type = 'service_provider'
            AND partners.status = 'active'
        )
    );

-- Service providers can update client access permissions
CREATE POLICY "Service providers can update client access" ON service_provider_clients
    FOR UPDATE USING (
        EXISTS (
            SELECT 1 FROM partners 
            WHERE partners.id = service_provider_clients.service_provider_id 
            AND partners.user_id = auth.uid()
            AND partners.partner_type = 'service_provider'
        )
    );

-- Consumers can update their own access permissions
CREATE POLICY "Consumers can update own access permissions" ON service_provider_clients
    FOR UPDATE USING (auth.uid() = consumer_user_id);

-- Service providers and consumers can delete assignments
CREATE POLICY "Partners and consumers can delete assignments" ON service_provider_clients
    FOR DELETE USING (
        auth.uid() = consumer_user_id OR
        EXISTS (
            SELECT 1 FROM partners 
            WHERE partners.id = service_provider_clients.service_provider_id 
            AND partners.user_id = auth.uid()
        )
    );

-- System can manage all assignments
CREATE POLICY "System can manage all client assignments" ON service_provider_clients
    FOR ALL USING (
        current_setting('role') = 'service_role'
    );

-- ==========================================
-- HELPFUL VIEWS (OPTIONAL)
-- ==========================================

-- View for active service providers with client counts
CREATE VIEW service_providers_summary AS
SELECT 
    p.id,
    p.user_id,
    p.referral_code,
    p.status,
    p.created_at,
    COALESCE(client_counts.client_count, 0) as client_count
FROM partners p
LEFT JOIN (
    SELECT 
        service_provider_id, 
        COUNT(*) as client_count 
    FROM service_provider_clients 
    GROUP BY service_provider_id
) client_counts ON p.id = client_counts.service_provider_id
WHERE p.partner_type = 'service_provider';

-- View for affiliates
CREATE VIEW affiliates_summary AS
SELECT 
    p.id,
    p.user_id,
    p.referral_code,
    p.status,
    p.commission_type,
    p.commission_rate,
    p.lump_sum_amount,
    p.lump_sum_months,
    p.created_at
FROM partners p
WHERE p.partner_type = 'affiliate';