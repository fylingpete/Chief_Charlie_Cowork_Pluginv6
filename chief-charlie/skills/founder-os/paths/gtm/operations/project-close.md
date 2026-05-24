# Project Close

Used when a GTM project is complete (won, lost, or archived).

## Step 1: Pick project

If multiple active projects in `dashboard_data.json:path_state.projects`:

```
Welches Projekt moechtest du abschliessen?
```

## Step 2: Check success criteria

```
Goal fuer {projects[i].title}: {projects[i].goal}
Outcome (erwartet): {projects[i].outcome}

Erreicht? Trotzdem abschliessen?
```

## Step 3: Resolve open tasks

```
Es gibt noch {X} offene Tasks die zu diesem Projekt gehoeren:
- {Task 1}
- {Task 2}

Was soll damit passieren?
- Abhaken (done=true)
- In anderes Projekt verschieben (project-Feld aendern)
- Streichen (Task entfernen)
```

## Step 4: Close

1. Remove project from `dashboard_data.json:path_state.projects`
2. Resolve associated tasks in `path_state.tasks` (done=true / moved / deleted)
3. Append a `learning` entry to `decisions_learnings.jsonl`: what did the project produce? (insight, validation status, follow-on hypotheses)
4. If project produced a major decision, append a `decision` entry as well

## Rules

- Don't silently delete — always log a learning entry
- If success criteria not met, capture WHY in the learning (this is the highest-value data)
- Close projects deliberately — stale projects on the dashboard distort focus
