# Scale Project Close

Formal closure of a `path_state.projects[]` entry. Run when:

- A project is materially done (deliverable shipped, goal met)
- A project is being explicitly killed (priorities shifted, scope
  invalidated)
- Phase-change leaves a project orphaned (old sub-phase done but
  project incomplete — user picks close vs. carry-forward)
- User says "Lass uns das Projekt offiziell abschließen"

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.projects` — current active projects
- `path_state.tasks` — tasks linked to this project
- `path_state.roadmap.currentSubphase`

## Action

### Step 1 — Identify the project

> "Welches Projekt willst du formal schließen? Hier sind deine
> aktuellen aktiven Projekte:"

```
- {Project 1 title} (n: {1}, goal: {goal_text})
- {Project 2 title} (n: {2}, goal: {goal_text})
- {Project 3 title} (n: {3}, goal: {goal_text})
```

User picks one (or multiple).

### Step 2 — Classify the close-reason

Pick reason:

- **completed** — Deliverable shipped, goal met
- **partial** — Project gone far enough, scope reset for next sub-phase
- **killed** — Scope invalidated (Bottleneck-Diagnosis changed,
   Priority shifted, off-Cone-Decline)
- **deferred** — Not closing, just pausing (re-activate next quarter)

If `deferred`: this isn't a close. Re-route to a future-tasks bucket
oder skip.

### Step 3 — Capture the Learning

This is the value of formal close. Per project:

- **Outcome (1 sentence):** what shipped, what was achieved
- **Headline learning:** the single most-important lesson from this
   project
- **Would-do-differently:** if you ran this project again, what would
   change?
- **Dependencies-revealed:** did this project surface unexpected
   dependencies on Other-Function or Other-Tool?
- **Cross-step relevance:** does this learning apply to future
   sub-phases (3.2, 3.3, 3.4)?

### Step 4 — Append to logs

Append `decisions_learnings.jsonl`:

```jsonl
{"type":"project_close","date":"YYYY-MM-DD","subphase":"...","project_title":"...","close_reason":"completed|partial|killed","outcome":"...","headline_learning":"...","would_do_differently":"...","dependencies_revealed":"...","cross_step_relevance":"..."}
```

If close_reason == `killed`: also append as decision:

```jsonl
{"type":"decision","date":"YYYY-MM-DD","domain":"project","reasoning":"Killed project '{title}': {1-sentence reason}"}
```

### Step 5 — Update path_state

- Remove project from `path_state.projects[]`
- Tasks linked to this project: mark `done: true` (if completed) or
   `cancelled: true` (if killed). Don't delete — preserve history.
- Re-sort remaining projects' `n` values to fill the gap (1, 2, 3, ...)

### Step 6 — Surface cross-project pattern (optional)

If this is the 3rd+ project in the past quarter killed mit same reason
(e.g. "scope invalidated"): surface to user:

> "Dies ist der {{N}}. Projekt diesen Quarter mit {{close_reason}}.
> Pattern: wie sehr ist der Bottleneck-Diagnosis stabil?"

→ Append to `path_state.events_pending` mit
   `{"type": "project_kill_pattern", "count": N, "common_reason": "..."}`.
   Surface in next Monthly Review.

## Rules

- **Learning is non-skippable.** Even for "killed" projects — that's
   where the most learning lives.
- **Outcome is verbatim or close-to-it.** Don't sanitize.
- **Don't auto-close on phase-change.** Phase-change asks user
   explicitly; only this file actually closes.
- **Pattern-surfacing in Step 6 is optional** but high-value at scale.

## Connection to other operations

- Triggered by `phase-change.md` Step 4e (project orphan flow)
- Triggered by `monthly-review.md` Section 5 (Next-Month Focus may
   require closing a project)
- Triggered by `quarterly-rebuild.md` Section 1 (Quarter-Recap may
   surface deferred projects)

## Related files

- `decisions_learnings.jsonl` — append-target
- `phase-change.md` — typical trigger
- `learning-documentation.md` — lightweight learning if no formal close
