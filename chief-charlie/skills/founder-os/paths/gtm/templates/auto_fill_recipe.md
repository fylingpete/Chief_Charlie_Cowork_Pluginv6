# GTM Auto-Fill Recipe — Agent Instructions

After GTM onboarding completes (Q10 channel-signal captured), populate
every empty `dashboard_data.data.*` field deterministically using the
rules below. Run BEFORE the Closing-Flow.

## Inputs

- `dashboard_data.json` — already contains business_profile, focus,
  current_path = "gtm", path_state, roadmap (with here:true on the
  routed sub).
- `paths/gtm/roadmap_defaults.json` — rich step content (overview,
  bottlenecks, keys, deliverables, sources).
- `paths/gtm/templates/kpis_per_step.json` — hardcoded KPI rows per step.
- `paths/gtm/templates/projects_per_step.json` — canonical default
  projects per step.
- `path_state.current_best_channel` (from onboarding Q10) — informs
  Sources override below.

## Read these first

1. `dashboard_data.data.roadmap.currentSubphase` — the active step ID
   (e.g. "2.1").
2. `dashboard_data.data.roadmap.phases[*].subs[here:true]` — for the
   phase ID + name.
3. `paths/gtm/roadmap_defaults.json` → `steps[currentSubphase]` — for
   overview, bottlenecks, deliverables, sources.
4. `paths/gtm/templates/kpis_per_step.json` → `steps[currentSubphase]` —
   for KPI rows.
5. `dashboard_data.data.business_profile` — for industry / buyer /
   build_type personalization.
6. `dashboard_data.data.focus.bottleneck` — Q8 free-text answer for
   matching.
7. `path_state.current_best_channel` — Q10 channel signal for Sources
   override (only step 2.1 uses this).
8. `path_state.channels_tried` — list of channels the user has already
   tried (informs anti-patterns / coaching).

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

### `projects` (from `projects_per_step.json`, additive)

Source = `paths/gtm/templates/projects_per_step.json` → `steps[currentSubphase].projects`.

For onboarding (initial seed): if `dashboard_data.data.projects` is empty
or absent, copy ALL projects from the active step's template into
`data.projects`. For each project copied, set:

```
- n        ← 1-indexed sequential
- title    ← from template (personalize using business_profile — see below)
- outcome  ← from template (personalize using business_profile — see below)
- goal     ← from template
- why      ← from template
- status   ← "later" for all, EXCEPT mark the foundational starter
             project as "current" (typically the first "Run …" / "Write …"
             discovery project)
- step     ← currentSubphase (e.g. "2.1")
```

For phase-change (additive): NEVER overwrite or remove existing projects.
Only append the new step's template projects with `step: <new_sub_id>`.
Old projects keep their `step` value unchanged unless the user explicitly
moves them via the phase-change Project-Dialog (see
`paths/gtm/operations/phase-change.md`).

**Personalization rules** — for each project, rewrite `title` and
`outcome` so they read naturally for THIS user:

- Replace generic nouns ("buyer", "rep", "channel") with the user's
  ICP nouns from `business_profile` when concrete (e.g. "VP of Ops",
  "BDR"). Fall back to the generic when no clean noun exists.
- Adapt to `path_state.current_best_channel` from Q10: in step 2.1
  projects that mention "channel" or "Core Four", anchor on the user's
  current_best_channel (e.g. "cold outreach", "content").
- Keep numeric targets verbatim from the template (20 discovery calls
  stays 20 — these are calibrated against Skok / Hormozi norms).
- Keep `goal` and `why` verbatim — they're internal framing.

Skip projects only if they are LITERALLY impossible for this user (e.g.
"Hire 2 sales reps" if `business_profile.team_size_today == 1` and the
user is bootstrapped — surface as path_state.warnings entry; do not silently
drop).

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
phase ← "GTM"
rows  ← copy paths/gtm/templates/kpis_per_step.json[currentSubphase].rows VERBATIM

EXCEPTIONS (apply only if values are already known from onboarding):
- If path_state.channels_tried mentions a clear winner (e.g.
  current_best_channel = "cold-email"), write the channel name into
  the "Channel-Pick aktiv" row's `current` field for step 2.1.
- If path_state.bookings_baseline is set (rare — only if user already
  has paying customers from PMF phase carrying over), write into
  bookings rows.
```

### `doNotDo.home`

The active step has 5 `bottlenecks[*]` entries. Each is an anti-pattern.
Invert each `bottlenecks[i].bottleneck` text into a ≤6-word imperative
("Nicht X tun"), then pick the 2–4 strongest ones and write them to
`doNotDo.home`. The home dashboard renders this list as "Don't do yet".

Routing: prefer anti-patterns the founder is most at risk of violating
right now (strategic + cognitive: ICP-Loose, Channel-Sprawl,
Hiring-vor-Playbook, Founder-Magic für Repeatability halten, Snapshot-
Retention für Cohort halten, Aggregat-CAC für Channel-CAC halten —
plus the most acute operative anti-patterns for the current step).

> `doNotDo` has only one bucket: `home`. Do NOT invent other buckets
> (e.g. `doNotDo.focus`) — they have no UI rendering and will be ignored.

---

## Sources Override — Q10 Channel-Aware Personalization

This is the GTM-specific feature. PMF has only static sources; GTM
personalizes the 4 Source-Pills based on `path_state.current_best_channel`
from onboarding Q10 — but ONLY for step 2.1 (where channel pick is the
active deliverable).

### Default behavior (all steps)

```
sources ← roadmap_defaults.steps[currentSubphase].sources VERBATIM
```

### Override for step 2.1 only

```
IF currentSubphase == "2.1" AND path_state.current_best_channel IS SET:
  Apply the channel-aware swap below.
ELSE:
  Use defaults verbatim.
```

### Channel-Aware Swap Table (step 2.1)

The default 4 sources for 2.1 are:
- MS — Matrix · Skok (Phase 4 ICP & Messaging)
- AH — Alex Hormozi (Grand Slam Offer · Core Four)
- YC — Y Combinator (Founder must sell · Best first customers)
- PK — Pete Kazanjy (100 Buyer Conversations)

Replace **slot 4 (PK)** with a channel-specific source:

| current_best_channel | Replace slot 4 with |
|---|---|
| `cold-email` | YC — `yc-cold-email-tactics` (initials YC, subtitle "Cold Email Tactics") |
| `cold-call` / `cold-outreach` | Hormozi — `hormozi-cold-outreach-value` (initials AH, subtitle "Cold Outreach Value") |
| `warm-outreach` / `referral` | Hormozi — `hormozi-aca-warm-outreach` (initials AH, subtitle "ACA Warm Outreach") |
| `paid-ads` / `paid-search` / `paid-social` | Hormozi — `hormozi-ad-anatomy` (initials AH, subtitle "Ad Anatomy") |
| `content` / `seo` / `social` | Hormozi — `hormozi-content-strategy` (initials AH, subtitle "Content Strategy") |
| `partner` / `partnership` | (no swap — keep PK as default; 2.1 default still applies) |
| not-set / unknown | (no swap — keep PK as default) |

Color for swapped sources: keep the source's author color (AH = #D85A30,
YC = #F26625, MS = #378ADD, PK = #1D9E75).

The `prompt` field for swapped sources follows this template:

```
"Erzähle mir mehr über {author} und {topic} im Kontext von Step 2.1
Find a repeatable sales motion und meinem aktuellen Channel-Test
({current_best_channel})."
```

### Override Audit Log

When swap is applied, log to `path_state.warnings`:

```
{
  "type": "sources_personalized",
  "step": "2.1",
  "channel": "{current_best_channel}",
  "swapped_in": "{new_source_name}",
  "swapped_out": "Pete Kazanjy"
}
```

### Steps 2.2-2.5 — No Swap

Steps 2.2-2.5 use defaults verbatim. The channel-pick is locked by
end of 2.1; later steps reference channel mix collectively, not a
single picked channel.

---

## Step-Wechsel-Verhalten (when `here:true` flips later)

When the user advances to the next step (e.g. 2.1 → 2.2), re-run:

### `kpis` (always re-generated on step-advance)

- Load `kpis_per_step.json[new_id].rows`.
- For Cross-Step trackers, preserve `current` from the previous state:
  - **Bookings (Net New ARR / Mo)** — preserve when transitioning
    2.2 → 2.3.
  - **Logo-Retention 12 Mo / NDR** — preserve when transitioning
    2.4 → 2.5.
- For step-specific metrics (rows that don't appear in the next step):
  use the new default (drop the old).
- Overwrite `dashboard_data.data.kpis.rows` completely.

### `sources` (re-generated on step-advance)

- Load defaults from `roadmap_defaults.steps[new_id].sources`.
- Apply Q10-override only if `new_id == "2.1"` (typically not the
  case on advance — 2.1 happens first).

### `currentFocus` / `bottleneck` / `oneThing` / `projects` / `tasks` / `doNotDo`

These are NOT auto-regenerated on step-advance in the current design.
Step-advance is handled by the (future) Phase D operations
(weekly-checkin / monthly-review / step-change.md) — they own
re-generating these fields.

For now: on step-advance, set them to placeholders and the user
re-runs the auto-fill via slash command or operations event.

---

## Open Hooks (for Phase D operations)

When Phase D operations are built, they will trigger re-runs of
this recipe with these signals:

- `event-channel-failed.md` → re-evaluate sources for 2.1 with new
  channel pick
- `event-conversion-drop.md` → re-evaluate bottleneck.title in 2.2-2.3
- `monthly-review.md` → refresh KPI rows with measured values
- `step-change.md` → trigger full auto-fill re-run for new step

These don't exist yet (Phase D scope) but the recipe is structured
to accommodate them.
