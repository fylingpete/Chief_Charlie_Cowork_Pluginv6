# PMF Phase Change

Triggered when the user feels the **goal of the current step is
substantially reached**. Goal-based, not deliverable-checklist-based.
Loads new step's projects additively, asks the user per-project what
to do with the old ones.

Mirrors `paths/gtm/operations/phase-change.md` — same flow, PMF-specific
content.

## When to run this

The trigger is **conversation-based**, not metric-based:

- User explicitly says "I think I'm done with this step" / "ready for
  the next phase" / "let's move on"
- During a weekly or monthly review, the agent observes that the
  step's `overview.mainGoal` is substantially achieved
- The agent surfaces this proactively when KPIs from
  `kpis_per_step.json` cross their targets (e.g. Sean Ellis ≥40% twice
  in a row for 1.5 → outbound 2.1)

Use `readyWhen` and `deliverables` as **orientation only**, never as
hard gates. The user owns the decision.

## Step 1: Goal-check (soft, not strict)

Read the current step's `overview.mainGoal` from
`paths/pmf/roadmap_defaults.json:steps[currentSubphase]`.

Ask the user **plainly**, in their language:

```
Goal of step {currentSubphase}:
  "{overview.mainGoal verbatim}"

Have you substantially reached this — even if not every detail is
perfectly checked off?
```

Show `readyWhen` as a **non-blocking checklist** for orientation. The
user can confirm goal-reached even if 1–2 readyWhen items are still open.

If the user is uncertain, share an honest assessment:

```
What you have:
- {readyWhen items the user has confirmed}

What's still loose:
- {readyWhen items still open}

KPI snapshot:
{Table from path_state.kpis.rows with current vs target}

My honest read: {1–2 sentences. Hard call: name the trade-off. e.g.
"Goal is 80% there. Moving to 1.5 without a documented favorite-user
persona is the canonical Sean Ellis failure mode — I'd recommend
finishing the persona before switching. But you decide."}
```

## Step 2: User decision

If the user defers:
- Log a `decision` entry to `decisions_learnings.jsonl`:
  `{"type":"decision","date":"YYYY-MM-DD","domain":"phase","reasoning":"deferred {currentSubphase} → {next} — reason: ..."}`
- Exit. No state changes.

If the user confirms → proceed to Step 3.

## Step 3: Project Dialog (additive, not reset)

**Critical** — projects are NOT reset. The user decides per project.

Read all projects in `dashboard_data.data.projects` where
`step === <old_subphase>`. Group by status:

```
Your projects from {old_subphase}:

Currently active ({count}):
  1. {title}
  2. {title}
  …

Later ({count}):
  3. {title}
  4. {title}
  …

Done ({count}):
  (no action needed — these stay as done with step={old_subphase})
```

For each NON-done project, ask the user:

```
What should happen with "{project.title}"?

- Continue → keep it active, re-tag step={new_subphase} (now belongs to
  the new phase, appears in the new projects.json)
- Close   → mark status="done" (optional: log a learning)
- Drop    → remove from data.projects entirely (no learning)
```

Recommended interaction: present all open projects in one message with
keyed shortcuts so the user can answer quickly (e.g. `1=continue,
2=close, 3=drop`).

Apply each decision:
- **Continue** → `project.step = <new_subphase>`, leave status untouched
- **Close**    → `project.status = "done"`, `project.step` unchanged
- **Drop**     → remove the project from `data.projects`

Done projects from the old step keep their `step` value (they remain
historical artefacts).

## Step 4: Add new step's default projects

Trigger the projects-block of `paths/pmf/templates/auto_fill_recipe.md`
with `currentSubphase = <new_subphase>`:

- Read `paths/pmf/templates/projects_per_step.json` →
  `steps[<new_subphase>].projects`
- Personalize each project using `business_profile` (industry, buyer,
  customer_description)
- Append each to `data.projects` with `n` continuing from current max,
  `status="later"` (or "current" for the foundational starter),
  `step=<new_subphase>`

**Never overwrite or remove existing projects** in this step. Only append.

## Step 5: Update roadmap state + remaining auto-fill fields

### 5a. Roadmap state

1. `data.roadmap.phases[*].subs[*].here` — clear on the old sub, set on the new sub
2. `data.roadmap.currentSubphase` — set to new id (e.g. "1.5")

### 5b. Re-run NON-project auto-fill fields

Trigger `paths/pmf/templates/auto_fill_recipe.md` for the new step,
**but skip the `projects` rule** (already handled in Step 4). The recipe
regenerates:

- `currentFocus` (from new step's `overview.mainGoal`)
- `bottleneck.title` / `bottleneck.description` (matched against
  `focus.bottleneck` if available)
- `oneThing` (from new step's first deliverable)
- `doNotDo.home` (from new step's bottlenecks — rendered as "Don't do yet" on home.json)
- `kpis` (from `kpis_per_step.json[new_id].rows`, preserving cross-step
  trackers — see 5c)
- `sources` (from new step's defaults)

**Tasks**: do NOT auto-regenerate. Tasks belong to projects — when the
user promotes a new project to `status="current"` in projects.json,
tasks get generated then. Existing tasks tied to continued projects stay.

> Deprecated fields NOT to write: `currentPhase`, `coreAssumption`,
> `decision`, `evidence`, `doNotDo.focus`.

### 5c. KPI cross-step preservation

When transitioning, preserve cross-step trackers:

| Transition | Preserve |
|---|---|
| 1.x → 1.y | "Engaged Users" current value, "Sean Ellis Score" current value |

The step-specific row (row index 0) uses the new default from
`kpis_per_step.json`.

### 5d. Audit trail

Append a `decision` entry to `decisions_learnings.jsonl`:

```jsonl
{"type":"decision","date":"YYYY-MM-DD","domain":"phase","reasoning":"Phase-Wechsel {old_subphase} → {new_subphase}: {1-sentence reason — what was achieved, what's next, which projects continued/closed/dropped}"}
```

## Switch-out check (PMF → GTM)

If `currentSubphase == "1.5"` AND Sean Ellis ≥40% in two consecutive
monthly measurements (from `pmf_score_history.jsonl`):

→ Don't run `phase-change.md` directly. Instead trigger
`event-40-milestone.md` which celebrates, summarizes the journey, and
proposes the PMF → GTM path-level switch.

## Rules

- **Goal-based, not deliverable-checklist-based** — `mainGoal` is the
  question. Deliverables and readyWhen are orientation, never gates.
- **Be honest about phase** — when the user is fooling themselves, say
  so plainly and let them override. Don't position the user further
  than reality supports.
- **Projects are additive** — never auto-archive or auto-delete the
  user's projects. Surface them, ask per-project, apply the user's
  choice. Continued projects re-tag to the new step; old "done"
  projects keep their original step value.
- **Preserve cross-step trackers** (Engaged Users, Sean Ellis) —
  losing them breaks longitudinal visibility.
- **Tasks are project-driven, not phase-change-driven** — new tasks
  appear when the user promotes a project to `status="current"` in
  projects.json, not at phase change.

## Related files

- `paths/pmf/roadmap_defaults.json` — step content (overview,
  bottlenecks, deliverables, sources)
- `paths/pmf/templates/projects_per_step.json` — canonical default
  projects per step
- `paths/pmf/templates/auto_fill_recipe.md` — field-by-field recipe
- `paths/pmf/templates/kpis_per_step.json` — KPI rows per step
- `event-40-milestone.md` — PMF → GTM path-level switch
- `decisions_learnings.jsonl` — audit trail
