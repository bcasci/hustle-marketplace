# Knowledge-Heavy Skill Example: Medical Claims Validation

**Architecture compliance**: ✅ Demonstrates minimal SKILL.md + references/ pattern for Knowledge-heavy type

---

````markdown
---
name: validating-medical-claims
description: Validate medical claims against CMS regulations. Use when processing healthcare claims or ClaimML files.
allowed-tools: "Read, Write, Bash(validate:*)"
---

# Medical Claims Validation

## Purpose

Validate medical claims for regulatory compliance.

## Prerequisites

- Claims in ClaimML format
- Validation engine installed

## Workflow

### Step 1: Classify Claim Type

Read claim file. Determine:

- Inpatient (hospital admission)
- Outpatient (office visit)
- Pharmacy (medication)

### Step 2: Apply Validation Rules

Run validation with type-specific rules:

```bash
validate_claim --type={type} --rules={baseDir}/references/{TYPE}-RULES.md claim.xml
```
````

### Step 3: Process Results

- All pass: Approve for payment
- Soft failures: Flag for manual review
- Hard failures: Reject with specific violations

See {baseDir}/references/ERROR-CODES.md for error meanings.

## Output

Validation report with compliance status and any violations.

## Errors

**"Unknown claim type"**: Claim file missing or malformed type field
**"Validation engine not found"**: Install: `npm install @cms/claim-validator`

## Resources

- Inpatient rules: {baseDir}/references/INPATIENT-RULES.md
- Outpatient rules: {baseDir}/references/OUTPATIENT-RULES.md
- Pharmacy rules: {baseDir}/references/PHARMACY-RULES.md
- Error codes: {baseDir}/references/ERROR-CODES.md

````

**Supporting file example** (`references/INPATIENT-RULES.md`):

```markdown
# Inpatient Claim Validation Rules

## CMS Rule 42-CFR-412: DRG Assignment

All inpatient claims must have valid DRG (Diagnosis Related Group) code...

**Validation**: DRG code must exist in approved list...
**Soft Failure**: DRG from previous year within 90 days...
**Hard Failure**: Invalid DRG code or missing DRG

**Example**: [Valid/Invalid cases with specific codes]

## HIPAA Rule 164.501: PHI Protection

Claims cannot contain unencrypted patient identifiers...

**Validation**: SSN field must be encrypted (AES-256) or hashed (SHA-256)
**Hard Failure**: Plain-text SSN present

**Example**: [Valid encrypted vs invalid plain-text]

## CMS Rule 42-CFR-424.13: Physician Certification

Inpatient admissions require physician certification of medical necessity...

[Additional rules follow same pattern: Description → Validation → Failures → Example]
````

---

**Why this is well-architected:**

- ✅ Complete structure: Purpose → Prerequisites → Workflow → Output → Errors → Resources
- ✅ Knowledge-heavy type (72 lines): Minimal SKILL.md, domain knowledge in references/
- ✅ Justified references: CMS regulations are domain knowledge Claude can't infer
- ✅ Uses `{baseDir}` pattern: All paths relative
- ✅ Proper separation: Workflow in SKILL.md, regulations in references/
- ✅ No bloat: Router only, no inline regulatory content
