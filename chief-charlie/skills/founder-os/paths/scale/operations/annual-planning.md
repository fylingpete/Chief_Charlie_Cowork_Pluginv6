# Scale Annual Planning (Wickman Annual Session)

**Scale-only operation.** Not in PMF, not in GTM. Activates from Step
3.2 onwards once V/TO™ exists.

2 days off-site. Run when `next_annual_due <= today` OR user requests.
Full V/TO™ refresh, 3-Year-Picture™ rebuild, Org-Checkup™, State-of-
Company communication, next-year Themes set.

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.cadences.last_annual_at`
- `path_state.cadences.next_annual_due`
- `path_state.roadmap.currentSubphase`
- `path_state.cross_kpis` (12-Monat-Trend)

Read from logs:
- Last 12 `monthly_review_log` entries (full year)
- Last 4 `quarterly_rebuild_log` entries (4 quarters)
- `cross_kpi_log` full year
- `rocks_completion_log` full year — completion rate
- `decisions_learnings.jsonl` full year

Read templates:
- `vto.md` (will be refresht)
- `accountability-chart.md` (potential rebuild)
- `scorecard.md` (recalibration)

Greet:

> "Annual Planning Session — Tag 1 von 2. Full Leadership-Team ist im
> Off-Site, devices off, 9:00-17:00 mit 90 Min Mittagspause. Wir
> refreshen V/TO™, rebuilden 3-Year-Picture™, runnen Org-Checkup™,
> setzen Annual Themes."

---

## Day 1 — Vision Refresh (V/TO™ + Long-Range)

### Section 1 — Year-in-Review (90 Min)

Walk the year via cross-KPI trend + key decisions:

- **Rule of 40 Trajektory:** start → end. Driver shifts (growth vs margin)?
- **NDR Trajektory:** sustained > 110%? Below 100% events?
- **LH-Score Trajektory:** Org-Checkup™-Scores im year.
- **Key Decisions (top 10):** from `decisions_learnings.jsonl`
- **Key Learnings (top 10):** patterns over 12 months
- **Wins:** top 5 — what really moved the needle
- **Losses / pivots:** top 5 — what we got wrong + what we learned

### Section 2 — Core Values Confirmation (45 Min)

Aus V/TO™ Page 1. Sind die 3-7 Core Values noch behaviorally testable?

- **Read-aloud-test:** Lead reads each aloud. Anyone cringes → flag.
- **Recession-test:** wenn Revenue 50% down — believen wir noch?
- **Industry-portability:** könnten sie in adjacent Industry tragen?
- **Hire/Fire-Test:** haben wir in den letzten 12 Monaten basierend
   auf Core Values hired oder fired?

→ Adjustments documented but rare. Core Values change every 5-10
   years, nicht jährlich.

### Section 3 — Core Focus™ Audit (90 Min)

#### Purpose / Cause / Passion

- Stated in very few words?
- Emotionally real (no embarrassment)?
- Survived this year's recession-tests?
- Industry-portable still?

#### Niche

- Still SINGLE, EXCEPTIONAL, TODAY?
- Evidence (happy customers, repeat business, inbound referrals)?
- Anyone in leadership able to state in one sentence without "and"?
- Off-Cone-Decline-Log this year reviewed:
  - How many off-cone-opportunities declined?
  - Any accepted that shouldn't have been? (Audit)

### Section 4 — 10-Year Target™ Roll-Forward (60 Min)

Check: are we within 3 years of the original 10-Year Target?
- If YES: time to roll forward — set a new 10-Year Target.
- If NO: confirm current Target still believable + dated.

### Section 5 — 3-Year-Picture™ Full Rebuild (3 Hours, span Day 1 evening + Day 2 morning)

Rebuild from scratch — this is the heaviest Annual exercise.

- **Future Date:** specific year-end 3 years out.
- **Revenue Target (single number after debate, not multiplied growth):**
- **Profit Target (matched to revenue level):**
- **Measurables (2-3 KPIs beyond revenue + profit):**
- **"Looks Like" Bullets (10-20):**
  - People: team size + quality + specific roles
  - Operational: footprint, locations, regions
  - Operational maturity: cadences, processes, automation
  - Product: which lines? which markets?
  - Brand / market position
  - Culture / rhythm
- **Anti-fluff check:** NO "world-class", NO "industry-leading", NO
   "amazing culture". Every bullet checkbar in 3 years.

→ Update `vto.md` Page 1 with rebuilt 3-Year-Picture™.

---

## Day 2 — Traction Reset (1-Year + Org + Themes)

### Section 6 — Org-Checkup™ Run (90 Min)

Run the full Wickman Organizational Checkup™ — 20 statements, 5-point
scale, alle Leadership-Members scoren independently, dann diskutieren.

- **Components below 80:** which?
- **Components moving backwards quarter-over-quarter:** which?
- **Year-over-Year delta:** improvement / decline?

→ Persist score in `path_state.cross_kpis.lh_score`.
→ Append `cross_kpi_log.template.jsonl` mit fresh LH-Score.
→ Components below 80 werden focus topics in Q1 next year.

### Section 7 — Marketing Strategy Refresh (V/TO™ Page 1 — 60 Min)

- **Target Market:** still right? (within Core Focus™?)
- **Three Uniques:** still differentiated vs. competitors?
- **Proven Process:** documented, still in use, still working?
- **Guarantee:** still credible? scalable?

### Section 8 — 1-Year Plan Build (3 Hours)

Rebuild aus 3-Year-Picture™ → reverse-engineer next 12 Monate.

- **Future Date:** +12 months.
- **Revenue Target:** ___
- **Profit Target:** ___
- **Measurables (2-3 KPIs):**
- **3-7 Annual Goals:**
  1.
  2.
  3.

→ Update `vto.md` Page 2 (1-Year Plan section).

### Section 9 — Annual Themes (60 Min)

Aus dem 1-Year Plan + Org-Checkup™-Findings:

- **Theme of the Year:** ein Wort oder Phrase, das den Jahresfokus capturet.
- **3 Strategic Themes:** key focus areas the team will rally around.
- **Cross-functional Themes:** initiatives that span functions.

→ State-of-Company prep: these themes get communicated org-wide.

### Section 10 — Q1 Rocks Setting (Wickman 8-Step Process — 90 Min)

Q1 Rocks aus 1-Year Plan ableiten:

1. Brainstorm 10-20 candidates.
2. Keep / Kill / Combine → 3-7 Company Rocks.
3. Sharpen to SMA.
4. Single Owner each.
5. Individual Rocks per Leader (incl. Company Rocks they own).
6. Build Rock Sheet (landscape, single doc).
7. Share at State-of-Company (45 Min cap).
8. Cascade to departments.

→ Update `vto.md` Page 2 (Quarterly Rocks section).

### Section 11 — Long-Term Issues List (30 Min)

V/TO™ Page 2 right column. Add strategic items that came up in Year-
in-Review + Org-Checkup™ but are not urgent for Q1. They live on the
list until they become urgent.

### Section 12 — State-of-Company Prep (60 Min)

Vorbereiten der State-of-Company Meeting (separate, broadcast to full
org):

- **Format:** 45 Min cap.
- **Headlines:** Year-Recap + 3-Year-Picture™ glimpse + 1-Year Plan
  Highlight + Annual Themes + Q1 Rocks share.
- **Logistics:** date, time, audience, recording for absent staff.

---

## Wrap

- Append `monthly_review_log.template.jsonl` with annual-flag:
  ```jsonl
  {"date":"YYYY-MM-DD","subphase":"...","annual_session":true,"vto_refreshed":true,"org_checkup_score":...,"annual_themes":[...]}
  ```
- For Q1 Rocks: append `rocks_completion_log.template.jsonl` mit
   `outcome: "set"`.
- Update `dashboard_data.json`:
  - `path_state.cadences.last_annual_at = today`
  - `path_state.cadences.next_annual_due = today + 365 days`
  - `path_state.cross_kpis.lh_score = {new score}`
- Confirm to user: "Annual Session abgeschlossen. V/TO™ refreshed,
   Themes gesetzt, Q1 Rocks committet. State-of-Company Meeting im
   Kalender."

## Rules

- **2 Days minimum.** 1-Day rush misses 3-Year-Picture™ rebuild
   quality. Wickman ist explicit: 2 Days.
- **Full Leadership-Team co-authored.** Solo-Founder-Refresh ist invalid.
- **No 3-Year-Picture™ shortcut.** Rebuild from scratch — not
   "minor adjustment to last year's". The point is to confront how
   reality moved vs prediction.
- **Annual Themes pre-tested in Section 11.** If team can't read
   them aloud without cringing, refine.
- **Org-Checkup™ scored independently first, then discussed.** Group-
   think distorts the raw signal.
- **Day 1 = Vision (slow-changing); Day 2 = Traction (fast-changing).**
   Honor the rhythm of EOS™.

## Related files

- `knowledge/scale/scale-org-and-processes.md` — Step 3.2 doctrine
- `knowledge/scale/wickman/wickman-vto.md` — V/TO™ source
- `knowledge/scale/wickman/wickman-three-year-picture.md` — 3-Year-Picture™
- `knowledge/scale/wickman/wickman-six-components.md` — Org-Checkup™
- `knowledge/scale/wickman/wickman-rocks.md` — Q1 Rocks setting
- `vto.md` — refreshed here
- `accountability-chart.md` — potential rebuild
- `scorecard.md` — recalibration
- `quarterly-rebuild.md` — quarterly cousin
