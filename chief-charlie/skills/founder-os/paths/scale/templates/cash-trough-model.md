---
deliverable_type: cash-trough-model
status: empty_template
team_required: true
source: matrix_partners_zero_to_100
last_updated: null
version: v1-draft
---

# Cash-Trough Model

> **Status:** empty_template — drafted at start of Step 3.1, refreshed quarterly
> **Team-required:** yes (CFO/finance-lead + CEO)
> **Source:** Skok SaaS Cash-Trough + Bookings-Math mit Ramp-Curves

> **STRICT TROUGH-DEPTH-RULE.** Doppelte Growth-Rate ≈ doppeltes Trough.
> Runway = tiefster Punkt + 6 Monate Polster. Fundraise-Milestones
> werden 3 Monate VOR dem Cash-Floor gesetzt, nicht beim Floor. Modellen
> ohne explizite Ramp-Curves (Rep@m3 = 0.4) sind unbrauchbar — produzieren
> Plans, die 2 Quartale früher als erwartet ausfallen.

## How to use this file

Das Trough vertieft sich, weil CAC up-front bezahlt wird und LTV über
Jahre eintrudelt. Jeder neue Customer macht das Trough zuerst tiefer,
bevor er es shallower macht. Ohne Modell tappt der Founder in die
3-Quartale-Lücke zwischen "Plan ist ok" und "Runway weg".

Das File modelliert: Bookings-Plan (mit Ramp-Curves), kumulativer
Cash-Burn pro Monat, tiefster Punkt, Recovery-Timeline, Fundraise-Trigger.
Refresht quarterly (im Quarterly Rebuild) oder nach materiellem Plan-Shift.

## Rules (from the substance rubric)

- **runway_covers_trough_plus_6 (non-negotiable):** Cash deckt den
  tiefsten projected Punkt + 6 Monate Polster. Wenn < 6 Mo Polster:
  Fundraise jetzt oder Hiring drosseln, nicht später.
- **ramp_curves_explicit:** Bookings-Modell zeigt Reps zu m3 = 0.4,
  m6 = 0.7, m9 = 1.0. Ein Modell ohne Ramp-Curves ist Wunschdenken.
- **growth_rate_doubles_trough:** Beim Stress-Test der Annahmen wird
  explizit gerechnet: was passiert bei +50% growth, +100% growth?
- **fundraise_3mo_before_floor:** Fundraise-Milestones (TS signed,
  closing date) liegen ≥ 3 Mo VOR dem projected Cash-Floor. Notfall-
  Fundraise auf bad terms ist der Failure-Mode dieses Steps.
- **segment_view_in_model:** Cash-Forecast nutzt Segment-LTV:CAC, nicht
  Aggregat. Sonst überschätzt Modell die LTV-Recovery der schlechten
  Segmente und unterschätzt das Trough.
- **board_briefing_quarterly:** Modell wird im Quarterly Rebuild ans
  Board kommuniziert — Trough-Tiefe, Recovery-Point, Fundraise-Window.

---

## Eingaben

<!-- INSTRUCTION: Die Variablen, aus denen das Trough-Modell rechnet. -->

- **starting_cash:** <!-- e.g. "$12M" — heutiger Cash-Stand -->
- **monthly_burn_baseline:** <!-- e.g. "$800K/Mo" — current burn ohne Scale-Investment -->
- **planned_growth_rate:** <!-- e.g. "60% YoY" — anvisierte Growth -->
- **scale_investment_per_quarter:** <!-- e.g. "$1.5M Q1, $2M Q2, ..." — additional Spend für Pods + Channels -->
- **ltv_cac_per_segment:** <!-- top 3 Segmente: LTV, CAC, Payback je Segment -->

## Bookings-Math (Skok)

```
Bookings = #Reps (ramped) × PPR × Capacity-Utilization

Wo:
- #Reps (ramped) = Σ Reps × Ramp-Curve-Faktor
  - Month 0-3: 0.4× headcount
  - Month 4-6: 0.7× headcount  
  - Month 6+: 1.0× headcount (fully ramped)
- PPR (Productivity per Rep, annual) = 4-6× OTE (Skok benchmark)
- Capacity-Util = qualified opps actually worked / capacity at full lead-flow
```

<!-- INSTRUCTION: Trage die rep-by-rep Hiring-Sequenz ein, dann Tabelle pro Monat. -->

| Monat | Reps gehired (headcount) | Reps fully-ramped | PPR aktiv | Cap-Util | Bookings/Mo |
|---|---|---|---|---|---|
| 0 |   |   |   |   |   |
| 3 |   |   |   |   |   |
| 6 |   |   |   |   |   |
| 9 |   |   |   |   |   |
| 12 |   |   |   |   |   |
| 18 |   |   |   |   |   |
| 24 |   |   |   |   |   |

## Cumulative Cash Projection (24 Monate)

<!-- INSTRUCTION: Monat-für-Monat Cash-Bilanz. Tiefster Punkt markieren. -->

| Monat | Bookings | MRR (collected) | Burn | Net Cash Flow | Cumulative Cash |
|---|---|---|---|---|---|
| 0 |   |   |   |   |   |
| 3 |   |   |   |   |   |
| 6 |   |   |   |   |   |
| 12 |   |   |   |   |   |
| 18 |   |   |   |   |   |
| 24 |   |   |   |   |   |

- **trough_depth:** <!-- tiefster Cumulative Cash Wert -->
- **trough_month:** <!-- wann ist es am tiefsten -->
- **recovery_month:** <!-- wann kommt Cumulative Cash zurück über starting_cash -->

## Stress-Test — was wenn Growth schneller?

<!-- INSTRUCTION: Skok: doppelte Growth verdoppelt Trough. Modelliere +50% und +100% Growth-Szenarien. -->

| Szenario | Trough-Tiefe | Trough-Monat | Recovery-Monat | Polster ≥ 6 Mo? |
|---|---|---|---|---|
| Base (Plan) |   |   |   |   |
| +50% Growth |   |   |   |   |
| +100% Growth |   |   |   |   |

## Fundraise-Plan

<!-- INSTRUCTION: Wenn Runway nicht Trough + 6 Mo deckt: Fundraise-Milestones VOR dem Floor. -->

- **runway_at_current_burn:** <!-- z.B. "16 Monate ohne neuen Cash" -->
- **runway_to_trough_floor:** <!-- z.B. "12 Monate bis projected Trough-Tiefe" -->
- **polster_in_months:** <!-- runway − runway_to_trough_floor — muss ≥ 6 sein -->
- **fundraise_required:** <!-- yes/no -->
- **fundraise_milestones:**
  - **start_outreach_by:** <!-- ≥ 3 Mo vor Floor -->
  - **TS_target_by:**
  - **closing_target_by:**
  - **next_round_size:**

## Segment-Level Adjustment

<!-- INSTRUCTION: Aggregate-LTV überschätzt LTV bei Mixed-Segments. Segmente einzeln modellieren. -->

| Segment | LTV (12-Mo) | CAC | LTV:CAC | Payback | Current Allocation | Sollte sein |
|---|---|---|---|---|---|---|
|   |   |   |   |   |   |   |

- **reallocation_decision:** <!-- z.B. "Q2: 12 Reps → 2 auf Segment A, 4 → 25 auf Segment B" -->

---

## Contamination Check

<!-- INSTRUCTION: Self-audit before locking the quarter's plan. -->

- Cumulative-Cash-Projection zeigt explizit den tiefsten Punkt: <!-- yes/no -->
- Ramp-Curves (m3=0.4, m6=0.7) sind im Bookings-Modell eingebaut: <!-- yes/no -->
- Stress-Test (+50%, +100% Growth) gerechnet: <!-- yes/no -->
- Polster ≥ 6 Monate zwischen Trough-Floor und Cash-Out: <!-- yes/no -->
- Fundraise-Milestones (wenn nötig) ≥ 3 Mo vor Floor gesetzt: <!-- yes/no -->
- Segment-Level LTV:CAC im Modell statt Aggregat: <!-- yes/no -->
- Board hat das Modell im letzten QBR gesehen: <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Initial baseline at start of Step 3.1 |
| v1-locked | locked | | All Contamination Check items pass, board signed off |
| | | | |

## Related files

- `knowledge/scale/hit-the-gas.md` — Step 3.1 doctrine
- `knowledge/gtm/matrix/skok-saas-cash-trough.md` — Cash-Trough origin
- `knowledge/gtm/matrix/skok-conserve-cash-until-scaling.md` — Cash discipline pre-Phase-9
- `three-gate-dashboard.md` — Gates, die das Trough-Spend licensen
- `pod-charter.md` — Hiring-Sequenz, die in Bookings-Math eingeht
