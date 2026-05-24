# Scale Auto-Fill Recipe — Agent Instructions

After Scale onboarding completes (Q-Scale-1 `growth_mode` captured),
populate every empty `dashboard_data.data.*` field deterministically
using the rules below. Run BEFORE the Closing-Flow.

## Inputs

- `dashboard_data.json` — contains business_profile, focus,
  current_path = "scale", path_state, roadmap (with here:true on the
  routed sub).
- `paths/scale/roadmap_defaults.json` — rich step content (overview,
  bottlenecks, keys, deliverables, sources).
- `paths/scale/templates/kpis_per_step.json` — hardcoded KPI rows
  per step.
- `path_state.growth_mode` (from onboarding Q-Scale-1) — informs
  Sources override below. Values: `bootstrapped` | `vc_backed` |
  `pe_ready`.
- `path_state.cross_kpis` — preserved cross-step KPIs (Rule of 40,
  NDR, Leadership-Health-Score). Carry over on step-advance.

## Read these first

1. `dashboard_data.data.roadmap.currentSubphase` — the active step ID
   (e.g. "3.1").
2. `dashboard_data.data.roadmap.phases[*].subs[here:true]` — for the
   phase ID + name.
3. `paths/scale/roadmap_defaults.json` → `steps[currentSubphase]` —
   for overview, bottlenecks, deliverables, sources.
4. `paths/scale/templates/kpis_per_step.json` → `steps[currentSubphase]`
   — for KPI rows.
5. `dashboard_data.data.business_profile` — for industry / buyer /
   build_type personalization.
6. `dashboard_data.data.focus.bottleneck` — Q8 free-text answer for
   matching.
7. `path_state.growth_mode` — Q-Scale-1 signal for Sources override
   (only step 3.1 uses this).
8. `path_state.cross_kpis` — preserved Rule of 40, NDR, LH-Score for
   continuity across steps.

## Field-by-field rules

> **Skipped fields (deprecated):** `currentPhase`, `coreAssumption`,
> `decision`, `evidence` are NOT rendered by any pill UI and have been
> removed from this recipe. Do NOT write them. `doNotDo.focus` is also
> deprecated.

### `currentFocus`

```
← roadmap_defaults.steps[currentSubphase].overview.mainGoal,
  truncated to ≤80 chars (cut at last word boundary, no ellipsis)
```

### `bottleneck.title` / `bottleneck.description`

Q8 (`focus.bottleneck`) is free-text. The active step has 5
`bottlenecks[*]` entries with `category` fields.

```
1. Match focus.bottleneck semantically against the 5 categories.
2. Set bottleneck.title = a short ≤6-word phrase derived from the
   matched category (NOT the long bottleneck text).
3. Set bottleneck.description = matched bottlenecks[i].bottleneck text.
4. Remember the matched category — surfaced in the Closing-Flow for
   user confirmation.
```

If no clean match: pick the closest, mark in path_state.warnings as
"bottleneck_match_uncertain", surface explicitly in Closing.

### `oneThing`

```
← roadmap_defaults.steps[currentSubphase].deliverables[0],
  rephrased as imperative starting with an action verb,
  truncated to ≤80 chars.
```

### `projects` (max 3, `n: 1..3`)

```
Pick the 3 deliverables that best represent the step's exit criteria.
Prefer deliverables with numeric targets (counts, percents, thresholds).

Map each:
- n         ← 1, 2, 3
- title     ← short ≤4-word label derived from the deliverable
- why       ← one sentence drawn from the matching keys[*].tag/bullets
              or bottlenecks[*].advance, NOT invented
- goal      ← the deliverable text, kept as-is (with the numeric target)
- outcome   ← one sentence linking the goal to the step's exit criterion
```

### `tasks` (5–7 items)

```
For each project, generate 1–3 atomic tasks:
- id        ← incrementing 1..N
- text      ← imperative ≤80 chars
- done      ← false
- today     ← true for the first 1–2 tasks, false for rest
- project   ← matches projects[*].title EXACTLY (string match — Tasks UI filters by this)
- date      ← "today" if today=true else "this week"
- dateTone  ← "today" or "week" matching `date`
```

### `kpis`

```
phase ← "SCALE"
rows  ← copy paths/scale/templates/kpis_per_step.json[currentSubphase].rows VERBATIM

EXCEPTIONS — preserved Cross-Step values on step-advance:
- If path_state.cross_kpis.rule_of_40 is set → write into "Rule of 40" row's `current`
- If path_state.cross_kpis.ndr is set → write into "Net Dollar Retention (NDR)" row's `current`
- If path_state.cross_kpis.lh_score is set → write into "Organizational Checkup™ Score" row's `current`

The step-specific KPI (row 1) starts from the default unless explicit
prior reading exists in path_state.
```

### `doNotDo.home` / `doNotDo.sprint`

The active step has 5 `bottlenecks[*]` entries. Each is an anti-pattern.
Invert each `bottlenecks[i].bottleneck` text into a ≤6-word imperative
("Nicht X tun"), then route to one of the two buckets:

- `home`   ← strategische + kognitive Anti-Pattern (Gate-Bypass, Cash-
            Trough-Underestimation, Names-before-Structure, GWC-
            Ambiguität, TAM-Trap, Off-Cone, NDR-Below-100, M&A-as-
            Shortcut) — 2-3 entries
- `sprint` ← operative Anti-Pattern (Channel-Saturation,
            Hiring-vs-Ramp, L10-Drift, AE-vor-GM, Bolt-on,
            Parallel-Launch, No-Kill-Criteria) — 2-3 entries

Routing heuristic: "Welche Page würde dieses Anti-Pattern am ehesten
verhindern?" Strategie/Org-Design/Vector-Pick → home, Ausführung/
Cadence → sprint.

> Do NOT write `doNotDo.focus` — that bucket has no UI rendering.

---

## Sources Override — `growth_mode` Personalization

This is the Scale-specific feature. Analog to GTM's
`current_best_channel` Q10. PMF has only static sources; Scale
personalizes the 4 Source-Pills based on `path_state.growth_mode`
from onboarding Q-Scale-1 — but ONLY for step 3.1 (where the
financial-strategy framing matters most).

### Default behavior (all steps)

```
sources ← roadmap_defaults.steps[currentSubphase].sources VERBATIM
```

### Override for step 3.1 only

```
IF currentSubphase == "3.1" AND path_state.growth_mode IS SET:
  Apply the growth-mode-aware swap below.
ELSE:
  Use defaults verbatim.
```

### Growth-Mode-Aware Swap Table (step 3.1)

The default 4 sources for 3.1 are:
- MS — Matrix · Skok (Phase 9 Hit the Gas · Cash Trough) — `#378ADD`
- AH — Alex Hormozi (Core Four · Ad-Spend Phases) — `#D85A30`
- GW — Gino Wickman (Rocks™ · 90-Day Execution) — `#7B3F99`
- YC — Y Combinator (B2B Metrics — swappable per growth_mode) — `#F26625`

Replace **slot 4 (YC B2B Metrics)** with a growth-mode-specific source:

| growth_mode | Replace slot 4 with |
|---|---|
| `bootstrapped` | MS — `skok-saas-cash-trough` + `skok-conserve-cash-until-scaling` (initials MS, subtitle "Cash-First · Trough Discipline", color `#1D9E75` to differentiate from primary Skok pill) |
| `vc_backed` | MS — `skok-rule-of-40` + AH — `hormozi-ad-spend-phases` blended (initials MS, subtitle "Rule of 40 · Velocity-First", color `#1D9E75`) |
| `pe_ready` | MS — `skok-stage-appropriate-metrics` + AH — `hormozi-ltgp-vs-cac` blended (initials MS, subtitle "Margin-Expansion · Exit-Window", color `#1D9E75`) |
| not-set / unknown | (no swap — keep YC B2B Metrics as default) |

The `prompt` field for swapped sources follows this template:

```
"Erzähle mir mehr über {author} und {topic} im Kontext von Step 3.1
Hit the gas & scale und meinem aktuellen Growth-Mode ({growth_mode})."
```

### Override Audit Log

When swap is applied, log to `path_state.warnings`:

```json
{
  "type": "sources_personalized",
  "step": "3.1",
  "growth_mode": "{growth_mode}",
  "swapped_in": "{new_source_name}",
  "swapped_out": "YC B2B Metrics"
}
```

### Steps 3.2-3.4 — No Swap

Steps 3.2-3.4 use defaults verbatim. The growth-mode framing matters
most in 3.1 (financial strategy for the gas-pedal phase). Later steps
are framework-locked (EOS™, YC International, YC Second-Product +
Wickman Core Focus™) regardless of growth mode.

---

## Cross-Step KPI Preservation

This is the Scale-specific persistence pattern. Three KPIs survive
step-advance via `path_state.cross_kpis`:

```json
"cross_kpis": {
  "rule_of_40": { "value": null, "as_of": null },
  "ndr": { "value": null, "as_of": null },
  "lh_score": { "value": null, "as_of": null }
}
```

These are written by the Monthly Review (Phase D operation). On
step-advance:

```
1. Read cross_kpis from path_state.
2. For each cross-step row in the new step's kpis_per_step.json:
   - If the metric name matches (Rule of 40 / NDR / Org Checkup™):
     write cross_kpis[metric].value into rows[*].current.
   - Else: use the default from kpis_per_step.json.
3. Recompute status (red/amber/green) against new step's target.
```

The step-specific KPI (row 1) is RESET on step-advance — new step,
new dominant metric.

---

## Step-Wechsel-Verhalten (when `here:true` flips later)

When the user advances to the next step (e.g. 3.1 → 3.2), re-run:

### `kpis` (always re-generated on step-advance, cross-step preserved)

- Load `kpis_per_step.json[new_id].rows`.
- For Cross-Step trackers (Rule of 40, NDR, LH-Score): preserve
  `current` from `path_state.cross_kpis`.
- For step-specific metrics: use the new default.
- Overwrite `dashboard_data.data.kpis.rows` completely.

### `sources` (re-generated on step-advance)

- Load defaults from `roadmap_defaults.steps[new_id].sources`.
- Apply growth_mode-override only if `new_id == "3.1"` (typically not
  the case on advance — 3.1 happens first).

### `currentFocus` / `bottleneck` / `oneThing` / `projects` / `tasks` / `doNotDo`

These are NOT auto-regenerated on step-advance in the current design.
Step-advance is handled by the Phase D operations
(weekly-checkin / monthly-review / phase-change.md) — they own
re-generating these fields.

For now: on step-advance, set them to placeholders and the user
re-runs the auto-fill via slash command or operations event.

---

## Open Hooks (for Phase D operations)

When Phase D operations are built, they will trigger re-runs of
this recipe with these signals:

- `event-cac-payback-blowout.md` → re-evaluate bottleneck.title in
  3.1 + flag in path_state.events_pending
- `event-leadership-vacancy.md` → re-evaluate in 3.2 (Acc-Chart seat
  > 30 Tage offen)
- `event-country-stall.md` → trigger kill-criteria.md review in 3.3
- `event-3.4-milestone.md` → trigger scale-complete-checklist.md
  walkthrough → transition to Operating Mode
- `monthly-review.md` → refresh KPI rows with measured values +
  write to `path_state.cross_kpis`
- `phase-change.md` → trigger full auto-fill re-run for new step

These don't exist yet (Phase D scope) but the recipe is structured
to accommodate them.

## Rules

- **growth_mode_swap_only_3_1 (non-negotiable):** Source-Override
  fires nur in Step 3.1. Steps 3.2-3.4 sind framework-locked.
- **cross_kpi_preserve_on_step_advance:** Rule of 40, NDR, LH-Score
  preserve `current` across Step-Wechsel. Step-specific KPI resets.
- **q8_match_against_categories:** Bottleneck-Matching gegen
  `category` field, nicht gegen `bottleneck` text.
- **deprecated_fields_not_written:** currentPhase, coreAssumption,
  decision, evidence, doNotDo.focus are NEVER written.
