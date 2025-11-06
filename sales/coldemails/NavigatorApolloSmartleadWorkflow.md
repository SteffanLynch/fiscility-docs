## COMPLETE OUTREACH WORKFLOW: SALES NAVIGATOR $\rightarrow$ APOLLO $\rightarrow$ SMARTLEAD.AI

This workflow is optimized for precision targeting (Sales Nav), data enrichment (Apollo), and high-deliverability email sequencing (Smartlead.ai).

### PHASE 1: TARGETING (LINKEDIN SALES NAVIGATOR)

**Goal:** Identify and filter the highly specific audience (e.g., Fractional CFOs, Accountants).

1.  **Access Saved Searches:** Log in to LinkedIn Sales Navigator and navigate to your pre-filtered **Saved Searches** or **Lead Lists**.
2.  **Verify Targeting:** Ensure the search results page displays the current, most relevant list of individuals you wish to contact (e.g., "Accountants who post about Advisory Services").
3.  **Position Browser:** Keep the Sales Navigator search results page open and ready for the next step.

---

### PHASE 2: DATA ACQUISITION & ENRICHMENT (APOLLO.IO)

**Goal:** Extract lead data from Sales Navigator and enrich it with verified email addresses.

1.  **Launch Apollo Extension:** Click the **Apollo.io Chrome extension** icon while viewing the Sales Navigator search results page.
2.  **Bulk Scrape Leads:** Use the extension's features (e.g., "Select All" or "Bulk Select") to instruct Apollo to capture all the visible leads on the page.
3.  **Enrich & Verify:** Apollo will automatically pull the lead data (Name, Title, Company, LinkedIn URL) and run a real-time search and verification check for the best possible **email address**.
4.  **Save to Apollo List:** Save the newly enriched leads into a dedicated List within Apollo (e.g., `Apollo Export - CFO Partners Q4`). This list is now the source of your email data.

---

### PHASE 3: DATA TRANSFER & CLEANUP (APOLLO $\rightarrow$ CSV)

**Goal:** Prepare a clean, formatted CSV file tailored for import into Smartlead.ai.

1.  **Navigate to Apollo List:** In your Apollo dashboard, open the list created in Step 2 (e.g., `Apollo Export - CFO Partners Q4`).
2.  **Initiate CSV Export:** Select the leads and click the **"Export"** button.
3.  **Select Required Fields:** Crucially, ensure the following fields are included in the export (these become your template variables):
    * `first_name`
    * `last_name`
    * `email` (Primary, Verified Email)
    * `title` (or `job_title`)
    * `company` (or `company_name`)
    * *(Optional: `linkedin_url` for manual tracking)*
4.  **Open and Clean CSV:** Open the exported CSV file in a spreadsheet program (Excel/Google Sheets):
    * **Filter out leads** where the **`email`** field is blank or shows a non-verified status (to protect your Smartlead deliverability).
    * **Check Formatting:** Ensure column headers exactly match the variables you intend to use in Smartlead (e.g., `{{first_name}}`).

---

### PHASE 4: SEQUENCE LAUNCH (SMARTLEAD.AI)

**Goal:** Upload the clean data and launch the automated email campaign.

1.  **Prepare Smartlead Campaign:** Log in to Smartlead.ai and create a new campaign (e.g., `CFO Partnership - Recurring Commission`).
2.  **Set Up Templates:** Paste your strategic email outreach templates (including the recurring commission pitch) into the Smartlead sequence editor.
3.  **Map Variables:** Verify that the variables used in your email templates (e.g., `{{first_name}}`, `{{title}}`) perfectly match the **column headers** in your cleaned CSV file.
4.  **Import Leads:** Upload the cleaned CSV file into the new Smartlead campaign.
5.  **Review and Launch:** Finalize your schedule and sending settings (delay, mailbox warm-up), and set the campaign to **"Active."**

**Result:** Your highly targeted leads will now receive automated, personalized email sequences through Smartlead, while the LinkedIn URL data enables a separate, manual connection strategy via Sales Navigator.
