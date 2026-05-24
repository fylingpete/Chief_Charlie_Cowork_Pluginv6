# PMF Auto-Fill Recipe — Agent Instructions

After PMF onboarding completes (Q3a + readiness check if applicable),
populate every empty `dashboard_data.data.*` field deterministically
using the rules below. Run BEFORE the Closing-Flow.

## Inputs

- `dashboard_data.json` — already contains business_profile, focus, current_path,
  path_state, roadmap (with here:true on the routed sub).
- `paths/pmf/roadmap_defaults.json` — rich step content (overview, bottlenecks,
  keys, deliverables, sources).
- `paths/pmf/templates/kpis_per_step.json` — hardcoded KPI rows per step.
- `paths/pmf/templates/projects_per_step.json` — canonical default projects per step.

## Read these first

1. `dashboard_data.data.roadmap.currentSubphase` — the active step ID (e.g. "1.4").
2. `dashboard_data.data.roadmap.phases[*].subs[here:true]` — for the phase ID + name.
3. `paths/pmf/roadmap_defaults.json` → `steps[currentSubphase]` — for overview, bottlenecks, deliverables.
4. `paths/pmf/templates/kpis_per_step.json` → `steps[currentSubphase]` — for KPI rows.
5. `dashboard_data.data.business_profile` — for industry / buyer / build_type personalization.
6. `dashboard_data.data.focus.bottleneck` — Q8 free-text answer for matching.

## Field-by-field rules

> **Skipped fields (deprecated):** `currentPhase`, `coreAssumption`,
> `decision`, `evidence` are NOT rendered by any pill UI and have been
> removed from this recipe. Do NOT write them. `doNotDo.focus` is also
> deprecated — see `doNotDo` rules below.

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
2. Set bottleneck.title = a short ≤6-word phrase derived from the matched
   category (NOT the long bottleneck text).
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

### `projects` (from `projects_per_step.json`, additive)

Source = `paths/pmf/templates/projects_per_step.json` → `steps[currentSubphase].projects`.

For onboarding (initial seed): if `dashboard_data.data.projects` is empty
or absent, copy ALL projects from the active step's template into
`data.projects`. For each project copied, set:

```
- n        ← 1-indexed sequential
- title    ← from template (personalize using business_profile — see below)
- outcome  ← from template (personalize using business_profile — see below)
- goal     ← from template
- why      ← from template
- status   ← "later" for all, EXCEPT mark the obviously first project
             as "current" (typically the project whose title starts with
             "Run …" or "Define …" — the foundational starting task)
- step     ← currentSubphase (e.g. "1.4")
```

For phase-change (additive): NEVER overwrite or remove existing projects.
Only append the new step's template projects with `step: <new_sub_id>`.
Old projects keep their `step` value unchanged unless the user explicitly
moves them via the phase-change Project-Dialog (see
`paths/pmf/operations/phase-change.md`).

**Personalization rules** — for each project, rewrite `title` and
`outcome` so they read naturally for THIS user:

- Replace generic nouns ("users", "buyer") with the user's
  `business_profile.customer_description` when concrete (e.g. "indie
  hackers", "ops managers"). Fall back to "users" when no clean noun
  exists.
- Adapt action verbs to the user's `business_profile.build_type`:
  software/content/service/e-com have different artefact vocabulary
  (e.g. for content: "publish" instead of "ship"; for service: "deliver"
  instead of "ship").
- Keep numeric targets verbatim from the template (15 interviews stays
  15 — these are calibrated).
- Keep `goal` and `why` verbatim — they're internal framing, not surfaced
  in copy-sensitive places.

Skip projects only if they are LITERALLY impossible for this user (e.g.
"Run Sean Ellis PMF survey" if `build_type == "content"` and the user
has no product yet). Surface skipped projects in path_state.warnings.

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
phase ← "PMF"
rows  ← copy paths/pmf/templates/kpis_per_step.json[currentSubphase].rows VERBATIM

EXCEPTIONS (apply only if values are already known from onboarding):
- If readiness.engaged_user_estimate is set, write it into the
  Engaged Users row's `current` field.
- If readiness.prior_baseline_notes mentions a prior Sean Ellis score
  (e.g. "60%"), write it into the Sean Ellis Score row's `current`
  field with a "(n=X)" annotation if sample is small.
```

### `doNotDo.home`

The active step has 5 `bottlenecks[*]` entries. Each is an anti-pattern.
Invert each `bottlenecks[i].bottleneck` text into a ≤6-word imperative
("Nicht X tun"), then pick the 2–4 strongest ones and write them to
`doNotDo.home`. The home dashboard renders this list as "Don't do yet".

Routing: prefer anti-patterns that the founder is most at risk of
violating right now (strategic + cognitive: Skalierung, ICP-Drift,
Wachstumsfantasien, Annahmen, Selbsttäuschung — but also operative ones
if they are the highest-risk patterns for the current step).

> `doNotDo` has only one bucket: `home`. Do NOT invent other buckets
> (e.g. `doNotDo.focus`) — they have no UI rendering and will be ignored.

## Step-Wechsel-Verhalten (when `here:true` flips later)

When the user advances to the next step (Operating Mode), re-run the
`kpis` rule:
- Load `kpis_per_step.json[new_id].rows`.
- For metric "Engaged Users": preserve `current` from the previous state.
- For metric "Sean Ellis Score": preserve `current` from the previous state.
- For the step-specific metric (row index 0): use the new default.
- Overwrite `dashboard_data.data.kpis.rows` completely.

The other auto-fill fields (`projects`, `tasks`, `oneThing`, `doNotDo`,
`currentFocus`, `bottleneck`) are NOT auto-regenerated on step-advance.
Step-advance is handled by the Quarterly Rebuild + Weekly Check-In —
they own those fields.
