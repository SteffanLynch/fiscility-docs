Here’s a clean, professional **Markdown guide** you can use or share as internal documentation for preparing **bulk letters** from Apollo leads.

---

# 📄 Bulk Letter Preparation Guide

This document outlines the exact steps to prepare **clean, verified address data** for bulk letter campaigns using **Google Sheets** and **Apollo exports**.

---

## 🧩 Step 1 — Export Leads from Apollo

1. Go to your **Apollo dashboard**.
2. Export your leads as a **CSV file**.
3. Open the CSV in **Google Sheets**.

---

## 🧹 Step 2 — Keep Only the Required Columns

Delete all unnecessary columns and keep only the following:

| Keep These Columns             | Description                                                                 |
| ------------------------------ | --------------------------------------------------------------------------- |
| `first_name`                   | Recipient’s first name                                                      |
| `company_name`                 | Company name                                                                |
| `job_title`                    | Job title or role                                                           |
| `email`                        | Email address                                                               |
| `phone`                        | Phone number                                                                |
| All **address-related fields** | Such as `address`, `city`, `state`, `country`, `postal_code` (if available) |

> 💡 Tip: If the address is split across multiple columns (street, city, state, etc.), create a new column and **combine** them into one **Full Address** column using `=TEXTJOIN(", ", TRUE, A2:F2)`.

---

## 🧽 Step 3 — Remove Rows Without Valid Addresses

You only want rows with **valid physical addresses** (i.e., containing a street number).

1. In a **new column**, enter this formula (assuming full address is in column `S`):

   ```excel
   =REGEXMATCH(S2, "\d")
   ```

2. This returns:

   * `TRUE` → Address contains a number ✅
   * `FALSE` → Address likely invalid ❌

3. **Filter** or **sort** by this column and **delete all rows** with `FALSE`.

---

## 🏠 Step 4 — Extract Street Address and Postcode

Now we’ll separate the street and postcode into their own fields.

### ➤ Street Address

In a new column:

```excel
=TRIM(LEFT(S2, FIND(",", S2)-1))
```

✅ Extracts everything **before the first comma** (the street part).

### ➤ Postcode

In another new column:

```excel
=TRIM(REGEXEXTRACT(S2, ",\s*([^,]+)$"))
```

✅ Extracts everything **after the last comma**, ignoring the first space.

---

## 🔍 Step 5 — Verify Addresses

Double-check your extracted addresses.

You can re-use the same formula to validate:

```excel
=REGEXMATCH(T2, "\d")
```

Apply this to:

* The **Street Address** column — ensures it contains a number.
* The **Postcode** column — ensures it contains a number.

If either returns `FALSE`, manually review those rows.

---

## 💬 Step 6 — Add Personalised Fields

To make your letters more personal, create the following extra fields:

### ➤ Greeting

```excel
=CONCATENATE("Hey ", B2, ",")
```

✅ Output: `Hey John,`

### ➤ Full Name

```excel
=CONCATENATE(B2, " ", C2)
```

✅ Combines first and last name (if both exist).

---

## 🧾 Step 7 — Final Review and Export

Before saving:

1. Verify there are **no empty cells** in street, postcode, or greeting fields.
2. Check **sample rows manually** for formatting consistency.
3. Export the cleaned data:

   * Go to **File → Download → Comma Separated Values (.csv)**

This CSV is now **ready for mail merge or printing** bulk letters.

---

## ✅ Example Column Layout (Final CSV)

| first_name | company_name | job_title | email                                 | phone    | full_address                                                    | street_address  | postcode   | greeting  | full_name  |
| ---------- | ------------ | --------- | ------------------------------------- | -------- | --------------------------------------------------------------- | --------------- | ---------- | --------- | ---------- |
| John       | Acme Inc     | CFO       | [john@acme.com](mailto:john@acme.com) | 555-1234 | 1014 Center Ave, Oostburg, Wisconsin, United States, 53070-1355 | 1014 Center Ave | 53070-1355 | Hey John, | John Smith |

---

Would you like me to make this version downloadable as a `.md` file with proper formatting (so you can upload to Notion or GitHub)?
