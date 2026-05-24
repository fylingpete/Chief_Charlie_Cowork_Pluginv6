# Scale Quarterly Rebuild (Quarterly Rocks™ Planning)

3-4 hours. Run when `next_quarterly_due <= today` OR user requests.
**At Step 3.2+, this operation IS Wickman's Quarterly Planning Session**
— Issues IDS™'d, new 3-7 Rocks set, Scorecard™ refreshed, prior
quarter Rocks scored binary done / not-done.

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.cadences.last_quarterly_at`
- `path_state.roadmap.currentSubphase`
- `path_state.cross_kpis` (trend over last 3 months)
- `path_state.warnings` (accumulated since last Quarterly)

Read from logs:
- Last 3 entries from `monthly_review_log.template.jsonl`
- Last 3 entries from `quarterly_rebuild_log.template.jsonl`
- `rocks_completion_log.template.jsonl` from last quarter
- `cross_kpi_log.template.jsonl` last 3 months
- `decisions_learnings.jsonl` last 3 months

Greet:

> "Quarterly Rebuild — Step {{currentSubphase}}. Letzter Rebuild:
> {{last_quarterly_at}}. {{If currentSubphase >= 3.2:}} L10™-Format —
> Issues IDS, neue Rocks setzen, Scorecard refreshen."

---

## Section Filter (which sections run by step)

| Section | 3.1 | 3.2 | 3.3 | 3.4 |
|---|---|---|---|---|
| 1. Quarter Recap | ✓ | ✓ | ✓ | ✓ |
| 2. Cross-KPI Trend Review | ✓ | ✓ | ✓ | ✓ |
| 3. Prior Rocks Scoring (Wickman) | • | ✓ | ✓ | ✓ |
| 4. Step-Specific Deep-Dive | ✓ | ✓ | ✓ | ✓ |
| 5. V/TO™ Refresh Check | — | ✓ | ✓ | ✓ |
| 6. Org-Checkup™ + GWC™ Review | — | ✓ | ✓ | ✓ |
| 7. Vector / Country Kill-Criteria Check | — | • | ✓ | ✓ |
| 8. Issues IDS™ — Top 3 | • | ✓ | ✓ | ✓ |
| 9. New Rocks Setting (3-7) | • | ✓ | ✓ | ✓ |
| 10. Next-Quarter Decisions | ✓ | ✓ | ✓ | ✓ |

✓ = primary, • = secondary, — = skip.

---

## Section 1 — Quarter Recap (all steps)

- **Headline:** ein Satz, was war dieser Quarter prägend?
- **Top 3 wins:**
- **Top 3 losses / misses:**
- **Cross-step KPI movement** (read from `cross_kpi_log.template.jsonl`):
  - Rule of 40 last Q vs this Q: ___
  - NDR last Q vs this Q: ___
  - LH-Score (wenn refresht): ___

## Section 2 — Cross-KPI Trend Review (all steps)

3-Monats-Trend pro Cross-KPI plus interpretation.

- **Rule of 40:** ___ (up / flat / down). Driver: Growth oder Margin?
- **NDR:** ___ (up / flat / down). Driver: Expansion oder Churn?
- **LH-Score:** ___ (Component der bewegt hat?)

→ Wenn ein Cross-KPI 2 Quartale in row roter Trend: priority topic for
   Section 8 (IDS).

## Section 3 — Prior Rocks Scoring (Wickman, binary)

(Skip for 3.1 wenn keine formal Rocks etabliert.)

Pro Rock from last quarter: **DONE / NOT DONE.** No partial credit.

| Rock | Owner | Due Date | Status |
|---|---|---|---|
|   |   |   | done / not-done |

→ Append `rocks_completion_log.template.jsonl` pro Rock.
→ Completion-Rate: ___ / ___ (___%). Erste 2-3 Quartale ~50% ist
   Wickman-Calibration, kein Failure.

## Section 4 — Step-Specific Deep-Dive

### 3.1 — Hit the gas

- **Three Gates trend (3 months):** sustained green? amber? red?
- **Cash-Trough refresh:** Trough-Tiefe noch valide? Polster?
- **Channel Portfolio:** ≥ 2 channels > 20%? Next layer planned?
- **Pod-Cloning-Decision:** add pod next quarter? signal hit?
- **Segment-LTV-Reallocation:** updated this quarter?

### 3.2 — Scale the org & processes

- **V/TO™ Cascade-Check:** 10-Year → 3-Year → 1-Year → Rocks
  ableitbar?
- **Accountability Chart™ Refresh:** seats current? V/I correct?
  Open Seats?
- **L10™ Discipline:** avg Rating over quarter? Over-time meetings?
- **Scorecard™ Stability:** rows changed? new owners? trends?
- **Core Processes™ Coverage:** % documented? Compile + Train durch?
- **GWC™ Bar:** Anyone newly below bar? Three-Strike-Cases?

### 3.3 — Expand internationally

- **Country P&L (each country):** vs Plan, FX-adjusted Unit Economics.
- **Replikations-Playbook:** version updated based on Country #1
  learnings?
- **Country-GM 90-Day-Plans:** all signed off, all reviewed at Day-90?
- **Kill-Criteria Status:** any country in Month-12 oder Month-18
  window?

### 3.4 — Add product lines

- **Vector P&L:** ARR-share trend, Unit Economics.
- **Core Focus™ Audit:** off-cone opportunities declined? documented?
- **10-Customer Pre-Sells:** progress / completion?
- **Vector-Owner GM:** Day-90-Plan + Day-90-Review done?
- **Scale-Complete-Checklist:** which Conditions are green this Q?

## Section 5 — V/TO™ Refresh Check (3.2+)

V/TO™ Page 1 (Vision) ist slow-changing. Quarterly: ist irgendwas
materiell verschoben? V/TO™ Page 2 (Traction) wird quartalsweise
refreshed (1-Year Plan check, neue Rocks in Section 9).

- **Core Values still behaviorally testable in this quarter?** yes/no
- **Core Focus™ (Purpose + Niche) still real?** yes/no
- **10-Year Target™ still aspirational + dated?** yes/no
- **3-Year Picture™ trajectory on-track?** yes/no — if no, full refresh
   in Annual Planning, not here.
- **1-Year Plan progress:** ___% through. Adjust 1-Year-Goals?

→ Update `vto.md` if changes confirmed.

## Section 6 — Org-Checkup™ + GWC™ Review (3.2+)

- **Last Org-Checkup™ Score:** ___ / 100. Date: ___.
- **Run new Org-Checkup™ this Quarter?** yes/no (Wickman: ≥ 2× im Jahr).
- **Components below 80 (any):** ___
- **People Analyzer™ — anyone below bar?** ___
- **Three-Strike cases this Q:**
- **Below-Bar after Strike 3:** ___ → Termination decisions

## Section 7 — Vector / Country Kill-Criteria Check (3.3+)

Read `kill-criteria.md` instances. Pro Vector in Month-12 oder
Month-18 window:

- **Vector:** ___
- **Pre-Written Hard-Kill Thresholds hit?** yes/no
- **Decision (per kill-criteria.md):** continue / re-scope / kill
- **Renegotiation attempts dokumentiert?** yes/no — discipline test

## Section 8 — Issues IDS™ — Top 3 (3.2+)

From V/TO™ Long-Term-Issues-List + accumulated `path_state.warnings`
+ Cross-KPI trends.

Pro Top-3 Issue:

1. **Identify:** root cause (frag „warum?" 3-5x)
2. **Discuss:** lang genug für Verständnis — nicht zerreden
3. **Solve:** single named Owner + single named To-Do + due date

→ Append `quarterly_rebuild_log.template.jsonl` mit
   `issues_idsd_this_quarter: [...]`.

## Section 9 — New Rocks Setting (3-7 company-level) (3.2+)

Wickman 8-Step Rock-Setting Process:

1. **Brainstorm:** typical 10-20 candidates from team.
2. **Keep / Kill / Combine** → 3-7 Company Rocks.
3. **Sharpen each** to unambiguous SMA (Specific, Measurable,
   Attainable).
4. **Assign exactly 1 Owner pro Rock.**
5. **Individual Rocks pro Leader:** Company-Rocks they own + their
   own — total 3-7 per Leader.
6. **Build the Rock Sheet:** single landscape document, Company-Rocks
   above + Individual-Rocks below.
7. **Share with org** in next State-of-the-Company-Meeting (45 Min cap).
8. **Cascade to departments** — each runs same Process — every
   employee 1-3 Rocks.

→ Update `vto.md` Page 2 with new Rocks.
→ Append `quarterly_rebuild_log.template.jsonl` mit `new_rocks_set`.

## Section 10 — Next-Quarter Decisions (all steps)

- **Next-Quarter #1 Priority (oneThing):** ___
- **Cross-KPI targets next quarter:**
  - Rule of 40: ___
  - NDR: ___
  - LH-Score: ___
- **Step-specific Priority:** ___
- **Hiring-Plan next quarter:**
- **Cash-burn next quarter:**

---

## Wrap

- Append `quarterly_rebuild_log.template.jsonl`:
  ```jsonl
  {"date":"YYYY-MM-DD","subphase":"...","new_rocks_set":[...],"prior_quarter_rocks_score":{...},"vto_refresh_done":...,"org_checkup_score":...,"issues_idsd_this_quarter":[...],"vector_decisions_log":[...]}
  ```
- For each Rock in Section 9: append `rocks_completion_log.template.jsonl`
   with `outcome: "set"` (will be re-scored at next Quarterly).
- Update `dashboard_data.json`:
  - `path_state.cadences.last_quarterly_at = today`
  - `path_state.cadences.next_quarterly_due = today + 90 days`
- Confirm to user: "Quarterly Rebuild fertig. Rocks für Q+1 gesetzt,
   Scorecard refreshed. Bis in 90 Tagen."

## Rules

- **Section Filter respektieren.** 3.1 hat noch keine V/TO™ — Skip
  Sections 5-7. 3.2+ ist full L10™-Mode.
- **Prior Rocks scored binary** — done oder not-done, kein "kind of done".
- **3-7 Rocks max pro Quarter.** Mehr ist Overcommit (Wickman:
  "everything is priority = nothing is").
- **Single named Owner pro Rock.** Co-Ownership ist Structural-Failure.
- **V/TO™ Refresh hier nur wenn material movement.** Full refresh ist
   Annual Planning.
- **Issues IDS™ Top 3 only.** Mehr ist Quarterly-Overwhelm.

## Related files

- `knowledge/scale/scale-org-and-processes.md` — 3.2 doctrine
- `knowledge/scale/wickman/wickman-rocks.md` — Rocks™ Mechanik
- `knowledge/scale/wickman/wickman-ninety-day-world.md` — Quarterly Cadence
- `knowledge/scale/wickman/wickman-ids-track.md` — IDS™ Methode
- `vto.md` — Vision artifact refreshed here
- `scorecard.md` — refreshed here
- `kill-criteria.md` — checked here for Vector Vectors
- `monthly-review.md` — feeds this Quarterly
- `annual-planning.md` — full V/TO™ + 3-Year-Picture™ rebuild
