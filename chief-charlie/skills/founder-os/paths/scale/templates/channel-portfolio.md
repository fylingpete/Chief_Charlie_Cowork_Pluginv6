---
deliverable_type: channel-portfolio
status: empty_template
team_required: false
source: matrix_partners_hormozi
last_updated: null
version: v1-draft
---

# Channel Portfolio

> **Status:** empty_template — drafted at start of Step 3.1, locked when ≥2 channels je >20% Pipeline-Anteil sustained
> **Team-required:** no (VP Marketing / Demand-Gen-Lead-driven)
> **Source:** Hormozi Core Four (Channel-Layering) + Skok Phase 9 (S-Curve-Overlap)

> **STRICT LAYERING-OVER-SWITCHING.** Channel #2 startet bei 70%
> Auslastung von Channel #1 — nicht bei 100% (saturated). Kein Channel
> wird gekillt, wenn er die Cash-Flow liefert, die das nächste
> Experiment finanziert. Hormozi 3-Phasen-Logik je Channel: track →
> lose money → print money. Quitting während Phase 2 (lose money) ist
> der typische Kill — die Daten reichen nicht für Phase-3-Entscheidung.

## How to use this file

Phase 3.1 wechselt nicht den Channel — sie LAYERED. Hormozi Core Four
(Warm / Cold / Content / Paid) ist das Inventar; ein typischer
Layering-Pfad ist Paid Search → Paid Social → Content/SEO → Outbound
oder Events, mit jedem neuen Layer 2-4 Quartale BEVOR der vorherige
saturiert.

Das Portfolio trackt: aktive Channels, deren Saturation-Status, deren
Channel-CAC + Channel-LTV, und die nächsten experimentellen Channels.
Pro Channel: pipeline-share, monthly spend, CAC, LTV, payback,
LTV:CAC, kill-threshold.

## Rules (from the substance rubric)

- **two_channels_min_at_20 (non-negotiable):** Zum Locken müssen ≥ 2
  Channels je > 20% des qualified Pipeline-Volumens beitragen. Single-
  Channel-Dependence blockt Phase 3.1 Exit.
- **layer_at_70_not_100:** Channel #N+1 wird gestartet, wenn Channel #N
  bei 70% Auslastung ist — nicht erst bei Saturation. S-Curves
  überlappen.
- **channel_cac_separately:** CAC, LTV, Payback, LTV:CAC werden je
  Channel berechnet — NIE aggregiert. Aggregat-CAC versteckt den
  Killer-Channel UND den Champion-Channel.
- **kill_criteria_pre_test:** Bevor ein neuer Channel gestartet wird,
  werden Kill-Criteria geschrieben (Cost-per-Lead, Conversion-Rate,
  Test-Spend-Cap). Channel der Kill-Criteria hittet wird geclosed,
  nicht nursed.
- **three_phases_per_channel:** Hormozi: track → lose → print. Phase-2
  Quitting (zu früh aufgeben) ist der typische Failure. Test-Budget
  + Test-Window vorab committen.
- **next_layer_planned_quarterly:** Im Quarterly Rebuild wird der
  nächste experimentelle Channel-Layer benannt — die Demand-Gen-Job
  ist ständige Experimentation am Layer N+1.

---

## Aktive Channels

<!-- INSTRUCTION: Pro Channel die Werte unten. Pro Mo refresht im Monthly Review. -->

| Channel | % Pipeline | Monthly Spend | Channel-CAC | Channel-LTV | LTV:CAC | Payback (Mo) | Phase (track/lose/print) | Status |
|---|---|---|---|---|---|---|---|---|
|   |   |   |   |   |   |   |   | red/amber/green |
|   |   |   |   |   |   |   |   |   |
|   |   |   |   |   |   |   |   |   |

### Saturation-Status pro Channel

<!-- INSTRUCTION: Saturated = adding more Spend liefert NICHT proportional mehr Leads. Marker = CPL steigt > 20% trotz gleicher Targeting. -->

- **channel_1:**
  - utilization_estimate: <!-- % of estimated saturation -->
  - signs_of_saturation: <!-- CPL trend, Frequency-Cap-Hits, audience-shrinking -->
- **channel_2:**
  - utilization_estimate:
  - signs_of_saturation:

## Next-Layer-Plan

<!-- INSTRUCTION: Quartal-für-Quartal die geplante Layering-Sequenz. -->

| Quarter | Channel zu starten | Test-Spend | Kill-Criteria | Owner |
|---|---|---|---|---|
| Q1 |   |   |   |   |
| Q2 |   |   |   |   |
| Q3 |   |   |   |   |
| Q4 |   |   |   |   |

## Active Channel-Experiments

<!-- INSTRUCTION: Pro laufendem Experiment: was getestet wird, in welcher Hormozi-Phase, Kill-Criteria, Test-Spend-Cap. -->

| Experiment | Started | Phase | Test-Spend bisher | Cost/Lead | Kill-Threshold | Status |
|---|---|---|---|---|---|---|
|   |   |   |   |   |   |   |

## Marketing-Sales Contract (Cohort-Basis)

<!-- INSTRUCTION: Reverse-engineered von Closes → SQLs → MQLs → Leads. Marketing committet zu Leads, Sales zu Conversion-Rates. Skok pattern. -->

```
Target Bookings (quarter): _______ closes
÷ Close-Rate from SQL: _______ %
= SQLs needed: _______
÷ Qualification-Rate from MQL: _______ %
= MQLs needed: _______
÷ Conversion from raw lead: _______ %
= Total qualified leads needed: _______
```

- **last_contract_review_date:**
- **gap_on_marketing_side_this_quarter:**
- **gap_on_sales_side_this_quarter:**

---

## Contamination Check

- ≥ 2 Channels tragen je > 20% qualified Pipeline bei: <!-- yes/no -->
- CAC + LTV pro Channel separately berechnet (kein Aggregat): <!-- yes/no -->
- Kill-Criteria pre-test für aktive Experimente geschrieben: <!-- yes/no -->
- Layering-Plan für nächste 2-3 Quartale vorhanden: <!-- yes/no -->
- Marketing-Sales-Contract dokumentiert mit Cohort-Math: <!-- yes/no -->
- Saturation-Status pro Channel beobachtet (CPL-Trend, Audience-Schwund): <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Initial draft, ≤ 1 Channel material |
| v1-locked | locked | | ≥ 2 Channels je > 20% sustained |
| | | | |

## Related files

- `knowledge/scale/hit-the-gas.md` — Step 3.1 doctrine
- `knowledge/gtm/hormozi/hormozi-core-four.md` — Core Four framework
- `knowledge/gtm/hormozi/hormozi-ad-spend-phases.md` — 3 Phasen je Channel
- `three-gate-dashboard.md` — Gates licensen Channel-Investment
- `pod-charter.md` — Pod-Lead-Mix verweist auf Channels hier
