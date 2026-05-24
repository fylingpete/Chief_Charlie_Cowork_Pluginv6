# Scale Path

Goal: scale the proven engine — aggressively deploy capital, install the
organizational operating system (EOS™), and expand via geographic or
product-line vectors — without breaking unit economics. Path entered
after GTM (all three Phase 8 gates pass: LTGP:CAC > 3, CAC payback
< 18 mo, gross margin > 70%). **Terminal path** — exited to Operating
Mode when all six Scale-Complete-Conditions hold for ≥ 4 quarters.

## Phase 3 — Scaling the Business

4 sequential / parallel-okay steps from "engine proven" to "Operating
Mode":

1. **Hit the gas & scale** — All three gates green for ≥ 6 months,
   ≥ 2 lead sources contributing > 20% each, ≥ 2 pods at quota for
   ≥ 2 quarters, segment-level unit economics drives allocation,
   cash-trough modeled with Polster ≥ 6 mo, Rule of 40 ≥ 40 or
   credible 18-mo path. Exit: the proven engine is compounding without
   breaking.

2. **Scale the organization & processes** — Full EOS™ install:
   Accountability Chart™ (function-first, V/I configuration explicit),
   V/TO™ in 1-2 day off-site, L10™ weekly for ≥ 8 weeks, Scorecard™
   stable with leading indicators tied to 1-Year Plan, Core Processes™
   identified/documented/compiled, Org-Checkup™ ≥ 70. Exit: leadership
   team runs the org; founder is leader-of-leaders, not operator.

3. **Expand internationally** — First country picked by buyer-behavior
   similarity (not TAM), Country-GM-hire is the most-consequential
   decision, 24-month break-even budgeted, replikations-Playbook as a
   Core Process™. Exit: first country contributes ≥ 10% of new ARR for
   ≥ 2 quarters with unit economics matching home market, kill-criteria
   applied at least once.

4. **Add additional product lines** — NDR ≥ 110% sustained precondition,
   Core Focus™ stays-in-the-cone filter applied to every vector candidate,
   three properties for successful second product (Same ICP / Same
   Channel / Startup-inside-Startup), 10-customer pre-sells at real
   price before engineering, kill-criteria pre-written. Exit: additional
   vector contributes ≥ 20% Total ARR with own positive unit economics
   AND all six Scale-Complete-Conditions hold for ≥ 4 quarters →
   Operating Mode.

Sub-phases gate progression. **3.1 → 3.2 is strict** (the EOS™ install
requires the engine from 3.1 to license the work). **3.3 + 3.4 are
parallel-okay after 3.2 exit** — sequence them per Skok's discipline,
don't run both simultaneously. 3.4 is terminal; passing it switches the
system to Operating Mode (no Phase 4).

## Operations

- `operations/weekly-checkin.md` — 5 min (Default Mode 3.1) / 90 min
  (L10™ Mode 3.2+, full Wickman Level 10 Meeting agenda)
- `operations/monthly-review.md` — 60 min, step-aware: 3.1 Three Gates +
  Cash-Trough, 3.2 Scorecard™ + Org-Checkup™, 3.3 Country P&L, 3.4
  Vector P&L. Refreshes Cross-Step KPIs (Rule of 40, NDR, LH-Score)
- `operations/quarterly-rebuild.md` — 3-4 h, becomes Wickman Quarterly
  Rocks™ Planning at 3.2+ (IDS™ Top 3, new 3-7 Rocks, Scorecard™ refresh,
  prior Rocks scored binary)
- `operations/annual-planning.md` — **Scale-only**, 2 days off-site:
  Year-in-Review + V/TO™ refresh + 3-Year-Picture™ rebuild + Org-Checkup™
  run + Q1 Rocks setting + State-of-Company prep
- `operations/learning-documentation.md` — ad-hoc lightweight capture
- `operations/phase-change.md` — sub-phase advance (preserves Cross-Step
  KPIs, re-runs auto-fill recipe)
- `operations/project-close.md` — formal project closure with learning
- `operations/event-cac-payback-blowout.md` — triggered when CAC-Payback
  > 24 mo for 2 Q, OR Polster < 6 mo. Decision tree: slow hiring /
  kill bad channel / price increase / fundraise
- `operations/event-leadership-vacancy.md` — triggered when
  Accountability Chart™ seat > 30 days open. Decision tree: recruiter /
  interim / rescope seat / internal promotion
- `operations/event-country-stall.md` — triggered when country < 50% of
  Plan for 2 Q, OR hits Month-12/18 kill-criteria check. Decision tree:
  continue+reset / replace GM / pivot Centralize-Localize / kill
- `operations/event-3.4-milestone.md` — terminal event: all six
  Scale-Complete-Conditions met → Operating Mode switch (fires once
  per path)

## Structured deliverables (templates/)

Each step produces structured, version-locked deliverables:

- **3.1**: `three-gate-dashboard.md`, `cash-trough-model.md`,
  `pod-charter.md` (one instance per pod), `channel-portfolio.md`
- **3.2**: `accountability-chart.md`, `vto.md`, `scorecard.md`,
  `people-analyzer.md`, `exec-90-day-plan.md` (one instance per
  VP-level hire)
- **3.3**: `country-similarity-matrix.md`, `country-launch-playbook.md`
  (Core Process™), `kill-criteria.md` (one instance per country)
- **3.4**: `vector-decision-doc.md`, `kill-criteria.md` (one instance
  per vector), `scale-complete-checklist.md` (the terminal gate)

Each template has frontmatter (status, version, source), substance
rubric (rules), contamination check, version history, and
cross-references to relevant knowledge files.

EOS™ tools (`accountability-chart.md`, `vto.md`, `scorecard.md`,
`people-analyzer.md`) carry "Concepts attributed to Gino Wickman,
*Traction™*" footer.

## Living documents

Scale doesn't ship dedicated living-doc templates in this iteration —
the structured templates above (refreshed quarterly via Quarterly
Rebuild, annually via Annual Planning) carry the same function. If a
specific living-doc pattern emerges in production use, add it via the
established Path-Builder pattern (GTM has `icp_playbook.md` /
`messaging_playbook.md` as precedent).

## Streams owned by this path

- `weekly_checkin_log.jsonl` — append on every weekly check-in
  (Default Mode or L10™ Mode)
- `monthly_review_log.jsonl` — append after each Monthly Review (with
  cross-KPI snapshot + step-specific KPIs)
- `quarterly_rebuild_log.jsonl` — append after each Quarterly Rocks™
  Planning (new Rocks set, prior Rocks scored, V/TO™ refresh notes,
  IDS™ resolutions)
- `scorecard_history.jsonl` — append weekly snapshot of EOS™ Scorecard™
  (Step 3.2+)
- `rocks_completion_log.jsonl` — append per-Rock binary score at
  quarter-end (done / not-done, Wickman discipline)
- `cross_kpi_log.jsonl` — append monthly snapshot of the three Scale
  Cross-Step KPIs (Rule of 40, NDR, Leadership-Health-Score) — drives
  Scale-Complete-Checklist evidence
- `decisions_learnings.jsonl` — append on every decision/learning
  capture (shared across paths)

## Knowledge

Top-level synthesis files (one per step):

- `knowledge/scale/hit-the-gas.md` — Step 3.1 doctrine
- `knowledge/scale/scale-org-and-processes.md` — Step 3.2 doctrine
  (EOS™-centric)
- `knowledge/scale/international-expansion.md` — Step 3.3 doctrine
- `knowledge/scale/product-line-expansion.md` — Step 3.4 doctrine
  (terminal + Operating Mode)

Author-curated source files:

- `knowledge/scale/matrix/` — Skok (Phase 9-11) + Schatz (VP Sales Org
  Design, Pod-Scaling) — Matrix Partners "Zero to 100"
- `knowledge/scale/yc/` — Y Combinator (Scaling Org, International
  Expansion, Second Product, Hiring Executives, Series B/C)
- `knowledge/scale/wickman/` — Gino Wickman (EOS™ / *Traction™*):
  17 paraphrased files covering Six Components™, Accountability Chart™,
  V/TO™, Rocks™, Scorecard™, L10™, IDS™, People Analyzer™, GWC™,
  Visionary/Integrator, Core Focus™, 3-Year Picture™, 10-Year Target™,
  Core Values, Meeting Pulse™, Ninety-Day-World, Three-Step Process
  Documenter™

Cross-path references: several files in `knowledge/gtm/matrix/`,
`knowledge/gtm/yc/`, `knowledge/gtm/hormozi/` are referenced directly
by Scale top-level files (e.g. Skok cash trough, Skok Rule of 40,
Hormozi Core Four, Hormozi ad-spend phases). Not duplicated to keep
author folders clean; explicit cross-path-path resolution per
top-level file's "Default sources" section.

## Growth-Mode-Aware Source Selection

In Step 3.1, the 4 source pills shown in the Roadmap-Tab are
personalized based on `path_state.growth_mode` from scale-onboarding
Q-Scale-1. Default is Skok / Hormozi / Wickman / YC; slot 4 (YC B2B
Metrics) is swapped per mode:

| `growth_mode` | Slot 4 swap |
|---|---|
| `bootstrapped` | Skok Cash-Trough + Conserve-Cash blend |
| `vc_backed` | Skok Rule of 40 + Hormozi Ad-Spend-Phases blend |
| `pe_ready` | Skok Stage-Appropriate Metrics + Hormozi LTGP-vs-CAC blend |
| not-set | (no swap — keep YC B2B Metrics) |

See `templates/auto_fill_recipe.md` for the full swap table. Steps
3.2-3.4 are framework-locked (no growth-mode override).

## Cross-Step KPI Persistence

Three KPIs persist across all four Scale steps via
`path_state.cross_kpis`:

- **Rule of 40** — Growth % + FCF Margin % (target ≥ 40, ≥ 60
  best-in-class). Source: Skok.
- **NDR (Net Dollar Retention)** — > 110% sustained = expansion
  signal; > 120% best-in-class. Source: Skok.
- **Leadership-Health-Score** — Wickman Organizational Checkup™ score
  (target ≥ 80, ≥ 70 in 3.1 floor).

Values carry over on every step-advance via `phase-change.md` Section
4c. Step-specific KPI (row 1 in `kpis_per_step.json`) resets per step.

The three KPIs are also the Scale-Complete-Conditions: Rule of 40
sustained ≥ 4 Q + NDR ≥ 110% sustained ≥ 4 Q + LH-Score ≥ 80 sustained
are 3 of the 6 conditions required to trigger
`event-3.4-milestone.md` and switch to Operating Mode.

## Switch out — Terminal to Operating Mode

When all six Scale-Complete-Conditions hold for ≥ 4 quarters
(documented in `scale-complete-checklist.md` + signed off by full
Leadership-Team + acknowledged by Board), `event-3.4-milestone.md`
fires once and switches the system to **Operating Mode**.

Operating Mode = no Phase 4. The path is terminal. What continues:

- L10™ weekly (Wickman)
- Monthly Review (Cross-KPI refresh)
- Quarterly Rocks™ Planning (3-4 h)
- Annual Planning Session (2 days, Wickman)
- Cross-Step KPI tracking (Rule of 40, NDR, LH-Score)
- Event triggers (cac-payback-blowout, leadership-vacancy,
  ndr-drift, org-checkup-drift)

What deactivates:

- "Next-Step" recommendation (no next sub-phase, no next path)
- `phase-change.md` operation (no more sub-phases)
- Path-Switch flow (this is terminal)

Roadmap badge updates: `"Path Complete — Operating Mode"`.
`scale-complete-checklist.md` locks to v1-locked; the audit trail
in `decisions_learnings.jsonl` preserves the milestone-decision and
sign-off chain.

Inspired by EOS-Implementer Graduation pattern. If a future Path 4
("Founder-Out" / "Succession" / "IPO-prep") is added later, the
Operating Mode acts as the bridge between Scale completion and that
hypothetical Phase 4. For v1: terminal, indefinite.
