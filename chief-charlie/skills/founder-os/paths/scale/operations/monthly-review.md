# Scale Monthly Review

60 minutes. Run when `next_monthly_due <= today` OR user requests.
Step-aware substance — refresh KPIs, persist Cross-Step KPIs, check
event triggers, draft next-month focus.

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.cadences.last_monthly_at` (last run)
- `path_state.roadmap.currentSubphase` (3.1 / 3.2 / 3.3 / 3.4)
- `path_state.cross_kpis` (Rule of 40, NDR, LH-Score — preserved monthly)
- `path_state.events_pending` (signals flagged since last review)
- `path_state.kpis.rows` (current step-specific KPIs)

Read from logs:
- Last 4 entries from `weekly_checkin_log.template.jsonl`
- Last entry from `monthly_review_log.template.jsonl` (prior month state)
- For step ≥ 3.2: last 4 entries from `scorecard_history.template.jsonl`
- For step 3.3/3.4: relevant `country` or `vector` state

Greet:

> "Monthly Review — Step {{currentSubphase}}. Letzter Review:
> {{last_monthly_at}}. Wir refreshen die KPIs, persisten Cross-Step
> KPIs, und checken Event-Trigger."

---

## Section 1 — Cross-Step KPI Refresh (every step, always)

Diese 3 KPIs werden monatlich gerechnet und in `path_state.cross_kpis`
persisted. Sie überleben jeden Step-Wechsel.

### Rule of 40 (Skok)

```
Rule of 40 = (YoY Revenue Growth %) + (FCF Margin %)
```

- **Current YoY Growth %:** ___
- **Current FCF Margin %:** ___
- **Rule of 40 Score:** ___
- **Status:** red (< 40) / amber (40-49) / green (≥ 50)

### Net Dollar Retention (NDR)

```
NDR = (Start ARR + Expansion - Churn - Contraction) / Start ARR
```

- **Start ARR (this month):** ___
- **Expansion:** ___
- **Churn:** ___
- **Contraction:** ___
- **NDR:** ___%
- **Status:** red (< 100) / amber (100-109) / green (≥ 110)

### Leadership-Health-Score (Wickman Organizational Checkup™)

Annual deep-dive in Annual Planning; monatlich nur Update wenn neuere
Reading verfügbar (z.B. nach jüngstem Org-Checkup-Run).

- **Last Org-Checkup™ Score:** ___ / 100
- **Date of last Checkup:** ___
- **Component below 80:** ___ (welche der 6: Vision/People/Data/Issues/Process/Traction?)
- **Status:** red (< 60) / amber (60-79) / green (≥ 80)

**Persist:** Write all three values + as_of date into
`path_state.cross_kpis` AND append `cross_kpi_log.template.jsonl`.

---

## Section 2 — Step-Specific Measurement

Pick the block matching `currentSubphase`.

### Step 3.1 — Hit the gas & scale

**Dominant metrics:** Three Gates + Cash-Trough + Lead-Source-Mix +
Pod-Health.

#### 2.1a — Three Gates Status

| Gate | Current | Target | Months Sustained | Status |
|---|---|---|---|---|
| LTV:CAC |   | > 3 |   |   |
| CAC-Payback (Mo) |   | < 18 |   |   |
| NDR |   | > 100% |   |   |

→ Update `three-gate-dashboard.md` directly.
→ If alle 3 grün for ≥ 2 Mo: gas-pedal-license active. If ≥ 6 Mo:
   3.1 exit-ready (siehe Section 5 + Phase-Change-Check).

#### 2.1b — Cash-Trough Position

- **Current Cash:** ___
- **Burn this month:** ___
- **Trough-Depth projected:** ___
- **Months until Trough-Floor:** ___
- **Polster (Runway - months-to-Floor):** ___ (≥ 6 required)

→ Update `cash-trough-model.md`. If polster < 6 Mo: fire
   `event-cac-payback-blowout.md` OR trigger Fundraise-Outreach.

#### 2.1c — Channel Portfolio

- **Active channels with > 20% pipeline-share:** ___ (target ≥ 2)
- **New channel-experiments diesen Monat:** ___
- **Channel-CAC > 2× target:** ___ (which?)

→ Update `channel-portfolio.md`.

#### 2.1d — Pod-Health

- **Pods aktiv:** ___
- **Pods bei Quota seit ≥ 2 Quartalen:** ___
- **Capacity-Util avg:** ___% (target 70-95%)
- **Win-rate avg:** ___ baseline-%

→ Update `pod-charter.md` per pod.

### Step 3.2 — Scale the organization & processes

**Dominant metrics:** Scorecard™ trends + Org-Checkup™ + L10™
health + Rocks™-completion.

#### 2.2a — Scorecard™ Trends

Read last 4 weeks `scorecard_history.template.jsonl`.

- **Avg red-cells per week:** ___
- **Rows mit 3+ konsekutive Misses (real trend, nicht Noise):** ___
- **Rows mit consistent green ≥ 8 Wochen (über-target setzbar?):** ___

→ For each Real-Trend-Miss: drop in next L10™ IDS™.

#### 2.2b — Rocks™ Completion (mid-quarter check)

- **Company Rocks on-track:** ___ / ___
- **Individual Rocks on-track:** ___ / ___
- **Wahrscheinlichkeit Quarter-End Completion:** ___%

→ Wenn < 70% projected: Quarterly Planning hat overcommitted.
   Flag for Quarterly Rebuild Section.

#### 2.2c — L10™ Discipline

- **Avg Meeting-Rating last 4 weeks:** ___ / 10
- **Meetings ≥ 8.0:** ___ / 4
- **Meetings über 90 Min:** ___ / 4 (target 0)
- **Meetings cancelled / rescheduled:** ___ / 4 (target 0)

→ If < 7.0 avg oder > 2 over-time: Process-IDS triggern.

#### 2.2d — Org-Checkup™ Progress

- **Last Checkup-Score:** ___ (date: ___)
- **Components < 80 (focus next quarter):** ___
- **Next Checkup-Date:** ___

#### 2.2e — Hiring + Exec-Plan Status

- **Open Acc-Chart-Seats > 30 Tage:** ___ (which?)
- **Exec-Hires im 90-Day-Plan Window:** ___
- **Day-90-Reviews this month:** ___

→ If Seat-Days-Open > 30: fire `event-leadership-vacancy.md`.

### Step 3.3 — Expand internationally

**Dominant metrics:** Country P&L + Kill-Criteria-Status + 3-Year-
Picture™ alignment.

#### 2.3a — Country-by-Country P&L

| Country | Months since launch | ARR (FX-adj) | % of New ARR | Country LTV:CAC | Country CAC-Payback | Status vs Plan |
|---|---|---|---|---|---|---|
|   |   |   |   |   |   |   |

→ If any country < 50% of Plan für 2 konsekutive Q: fire
   `event-country-stall.md`.

#### 2.3b — Kill-Criteria-Check (Month 12 + Month 18 windows)

For each country in window:
- **Country:** ___
- **Months since launch:** ___
- **Hard-Kill-Threshold hit?** yes/no
- **Decision needed by:** ___

→ If hit: trigger formal review via `kill-criteria.md` Month-12 oder
   Month-18 section.

#### 2.3c — Replikations-Playbook Updates

- **New countries in pipeline:** ___
- **Replikations-Playbook (`country-launch-playbook.md`) refreshed?**
  yes/no — date: ___

### Step 3.4 — Add additional product lines

**Dominant metrics:** Vector-ARR-Share + Combined NDR + Core-Focus™
discipline.

#### 2.4a — Vector P&L

- **Vector picked:** ___ (Second-Product / Geographic / M&A)
- **Months since launch:** ___
- **Vector ARR contribution:** ___ ($, % of Total ARR — target ≥ 20%)
- **Vector Unit Economics:** LTV:CAC ___ / Payback ___ / GM ___

→ If Vector hits Hard-Kill-Threshold: trigger `kill-criteria.md`
   formal review.

#### 2.4b — Combined NDR (Cross-Mix)

- **NDR (Core only):** ___
- **NDR (Vector only):** ___
- **NDR (Combined):** ___
- **Sustained ≥ 110% Quartale:** ___ (target ≥ 4 for Scale-Complete)

#### 2.4c — Core-Focus™ Audit

- **Off-cone Opportunities considered this month:** ___
- **Declined:** ___
- **Accepted (and on-cone):** ___

→ Append `vector_state.off_cone_declines_log` für jede declined.

#### 2.4d — Scale-Complete-Checklist Progress

Read `scale-complete-checklist.md`. Pro Condition: Status.

- **Condition 1 (Vector ≥ 20% ARR):** ___
- **Condition 2 (Core Focus™ held):** ___
- **Condition 3 (NDR ≥ 110% sustained ≥ 4 Q):** ___
- **Condition 4 (Rule of 40 ≥ 40 sustained ≥ 4 Q):** ___
- **Condition 5 (Org-Checkup™ ≥ 80 sustained):** ___
- **Condition 6 (Kill-Criteria applied ≥ 1×):** ___

→ Wenn alle 6 = yes für 4 Quartale → fire `event-3.4-milestone.md`.

---

## Section 3 — Events-Pending Triage

Read `path_state.events_pending` (from weekly check-ins since last
Monthly Review).

For each pending event:
1. Did it fire? (was the trigger condition real, not noise?)
2. If yes: run the corresponding `event-*.md` operation now.
3. If no: discard with rationale logged.

Empty `path_state.events_pending` after triage.

---

## Section 4 — Decisions & Learnings Log

Letzte 4 Wochen `weekly_checkin_log.template.jsonl` durchgehen.

- **Top 3 Entscheidungen dieses Monats:**
  1. ___
  2. ___
  3. ___
- **Top 3 Erkenntnisse dieses Monats:**
  1. ___
  2. ___
  3. ___

Pattern-Check: Wiederholen sich Bottlenecks aus mehreren Wochen?
Welche Category dominiert (GATES / TROUGH / ORG / VECTOR)?

---

## Section 5 — Next-Month Focus

Basierend auf Cross-KPI-Status + Step-spezifischen Findings:

- **#1 Priority next month (oneThing):** ___
- **2-3 Projects (with numeric targets):** ___
- **Top 5-7 Tasks der ersten Woche:** ___
- **doNotDo update (home + sprint):** ___

→ Auto-Fill-Recipe wird re-run mit diesen Inputs. Update
   `path_state.tasks` und `path_state.projects` entsprechend.

---

## Section 6 — Phase-Change-Check (if applicable)

Wenn alle Deliverables + readyWhen für `currentSubphase` erfüllt
sind: → trigger `phase-change.md`.

Wenn `currentSubphase == "3.4"` UND alle 6 Scale-Complete-Conditions
seit ≥ 4 Quartalen TRUE: → trigger `event-3.4-milestone.md`.

---

## Wrap

- Append `monthly_review_log.template.jsonl`:
  ```jsonl
  {"date":"YYYY-MM-DD","subphase":"...","cross_kpis":{...},"step_specific_kpis":{...},"rocks_status":{...},"decisions_made_this_month":[...],"issues_to_ids":[...],"flags":[...]}
  ```
- Update `dashboard_data.json`:
  - `path_state.cadences.last_monthly_at = today`
  - `path_state.cadences.next_monthly_due = today + 30 days`
  - `path_state.cross_kpis = {...refreshed values}`
  - `path_state.kpis.rows = {...refreshed}`
- Fire flagged events nun (`event-cac-payback-blowout` etc.).
- Confirm to user: "Monthly Review fertig. Bis zum nächsten Monat."

## Rules

- **Cross-Step KPIs werden ZUERST refreshed** (Section 1) — vor
  Step-specific. Sie sind das Backbone, das jeden Step überlebt.
- **Step-aware Substance.** Block 2 ist der wichtigste — Generic
  Monthly verfehlt den frontier.
- **Pending Events VOR Decisions/Learnings triage.** Events können
  next-month Focus ändern.
- **Phase-Change-Check zuletzt.** Erst Refresh + Triage + Findings,
  dann Decision.
