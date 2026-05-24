---
deliverable_type: three-gate-dashboard
status: empty_template
team_required: false
source: matrix_partners_zero_to_100
last_updated: null
version: v1-draft
---

# Three-Gate Dashboard

> **Status:** empty_template — drafted at start of Step 3.1, locked when all three gates green for ≥6 consecutive months
> **Team-required:** no (founder/CFO-driven, monthly refresh)
> **Source:** Skok Phase 9 — drei Gates für den Gas-Pedal

> **STRICT GATE-DISCIPLINE.** Alle drei Gates müssen seit ≥2 Monaten
> grün sein, bevor aggressiv skaliert wird; alle drei seit ≥6 Monaten,
> bevor 3.1 als done markiert wird. Single-Month-Readings sind Noise —
> nicht Gate-Pass. Bypass mit einem roten Gate ist der teuerste Class
> of Mistake im ganzen 11-Phasen-Roadmap.

## How to use this file

Drei Gates licensen Phase 9 (Hit the Gas): LTV:CAC > 3, CAC-Payback
< 18 Monate, NDR > 100%. Jeder Monat: trage `current` ein, rechne
Status (red/amber/green), markiere ob das Gate die 2-Monats- und
6-Monats-Schwelle gehalten hat.

Die Datei wird vom Monthly Review (Phase D) refresht. Bei Step-Wechsel
3.1 → 3.2 werden die `current`-Werte preserved und im 3.2-Dashboard
als persistent Cross-Step-KPIs weiter getrackt.

## Rules (from the substance rubric)

- **three_gates_sustained (non-negotiable):** Alle drei Gates seit ≥6
  konsekutiven Monaten grün, bevor Step 3.1 als done markiert wird.
- **two_month_minimum:** Aggressive Skalierung (neue Pods, neue Channels)
  startet erst, wenn alle drei Gates seit ≥2 Monaten grün sind.
- **monthly_refresh_only:** Werte werden nur monatlich aktualisiert (im
  Monthly Review), nicht wöchentlich. Wöchentliche Schwankungen sind Noise.
- **payback_under_6_is_signal:** CAC-Payback < 6-7 Monate bedeutet
  *under-investment*, nicht Triumph. Headroom für aggressivere Spend.
- **ndr_below_100_blocks_phase11:** NDR < 100% blockiert 3.4 (Product-Line)
  — fix Retention bevor weitere Vektoren geöffnet werden.
- **gate_red_no_gas:** Hitting the gas mit einem oder mehreren Gates rot
  ist der teuerste Class of Mistake. Documented decision required.

---

## Gate 1 — LTV:CAC > 3

<!-- INSTRUCTION: LTV auf 12-Monats-Cohorts (validated, not extrapolated). LTGP (Lifetime Gross Profit) ist preciser als LTV — falls verfügbar, nutze LTGP:CAC. -->

- **current_value:** <!-- e.g. "3.2" -->
- **target:** > 3 (3-5 healthy, > 5 unter-investiert)
- **status:** <!-- red / amber / green -->
- **months_sustained_green:** <!-- 0, 1, 2... 6+ -->
- **cohort_basis:** <!-- e.g. "12-month cohorts, validated against 2024 Q1-Q3 acquisition" -->
- **ltv_or_ltgp:** <!-- LTV (revenue-based) or LTGP (gross-profit-based — preferred) -->

## Gate 2 — CAC-Payback < 18 Monate

<!-- INSTRUCTION: Months until cumulative gross profit from a new customer recovers CAC. < 12 Mo for SMB, < 18 for B2B. < 6-7 = under-investment signal. -->

- **current_value:** <!-- e.g. "14 Monate" -->
- **target:** < 18 Monate (B2B) / < 12 Monate (SMB) / < 6-7 = under-invested
- **status:** <!-- red / amber / green -->
- **months_sustained_green:**
- **payback_under_invested_flag:** <!-- yes/no — true wenn < 7 Monate (= mehr Spend möglich) -->

## Gate 3 — NDR > 100%

<!-- INSTRUCTION: Net Dollar Retention = (Start ARR + Expansion - Churn - Contraction) / Start ARR. Monthly oder Quarterly basis. -->

- **current_value:** <!-- e.g. "108%" -->
- **target:** > 100% (expansion) / > 110% strong / > 120% best-in-class
- **status:**
- **months_sustained_green:**
- **negative_dollar_churn_active:** <!-- yes/no — NDR > 100% means yes -->
- **expansion_axes_in_place:** <!-- yes/no — Seats / Usage / Editions / Add-ons designed? -->

---

## Cross-Step KPI Tracker (persisted across Scale)

<!-- INSTRUCTION: Diese 3 KPIs überleben Step-Wechsel via path_state.cross_kpis. Hier ist das Heimatdashboard für 3.1. -->

| KPI | Current | Target | Status | Sustained (Q) |
|---|---|---|---|---|
| **Rule of 40** (Growth% + FCF Margin%) |   | ≥ 40 (healthy), ≥ 60 (best-in-class) |   |   |
| **NDR** (Net Dollar Retention) |   | > 110% sustained |   |   |
| **Leadership-Health-Score** (Org-Checkup™) |   | ≥ 80 (≥ 70 in 3.1, ≥ 80 in 3.2+) |   |   |

---

## Gate-Status-Verlauf (last 6 months)

<!-- INSTRUCTION: Ein Eintrag pro Monat, nach Monthly Review. Auf 6+ green months in row warten, bevor 3.1 als done markiert wird. -->

| Monat | LTV:CAC | Payback | NDR | All-Green? |
|---|---|---|---|---|
|   |   |   |   |   |
|   |   |   |   |   |

## Gas-Pedal-Decision

<!-- INSTRUCTION: Wenn alle drei Gates seit ≥2 Monaten grün: aggressives Hiring/Channel-Layering freigegeben. Documented decision unten. -->

- **gas_pedal_pressed_at:** <!-- date when decision made -->
- **conditions_at_press:** <!-- LTV:CAC X, Payback Y, NDR Z — all sustained ≥2mo? -->
- **gas_pedal_decision_rationale:** <!-- one paragraph — why now, what gets scaled, expected trough depth -->

---

## Contamination Check

<!-- INSTRUCTION: Self-audit before locking. Any "no" means draft, not locked. -->

- Alle drei Gates seit ≥ 6 konsekutiven Monaten grün: <!-- yes/no -->
- LTV/LTGP basiert auf realen 12-Mo Cohorts (nicht extrapoliert): <!-- yes/no -->
- CAC-Payback berücksichtigt voll-allocated Sales-Effort + Marketing-Spend: <!-- yes/no -->
- NDR-Berechnung benutzt korrekte Formel (Start + Expansion - Churn - Contraction) ÷ Start: <!-- yes/no -->
- Cross-Step-KPIs (Rule of 40, NDR, LH-Score) gepflegt seit ≥ 6 Monaten: <!-- yes/no -->
- Gas-Pedal-Decision dokumentiert mit Rationale: <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Initial baseline at start of Step 3.1 |
| v1-locked | locked | | All three gates green ≥6 months |
| | | | |

## Related files

- `knowledge/scale/hit-the-gas.md` — Step 3.1 doctrine
- `knowledge/gtm/matrix/skok-saas-cash-trough.md` — Gates origin
- `knowledge/gtm/matrix/skok-rule-of-40.md` — Rule of 40 doctrine
- `cash-trough-model.md` — Runway implications of Gates + growth rate
- `channel-portfolio.md` — Channel-Level Unit Economics
