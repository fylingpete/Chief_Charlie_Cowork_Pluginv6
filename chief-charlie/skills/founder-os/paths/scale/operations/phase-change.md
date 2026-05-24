# Scale Phase Change (Sub-Phase Transition within Scale)

Triggered when the user has reached the next Scale sub-phase
(deliverables done, exit criteria met). Re-runs the auto-fill recipe
for the new step and resets per-step state, **preserving Cross-Step
KPIs** (Rule of 40, NDR, LH-Score).

## When to run this

- All deliverables for `currentSubphase` marked complete in
  `roadmap_defaults.steps[currentSubphase].deliverables`
- Exit criteria from `roadmap_defaults.steps[currentSubphase].overview.readyWhen`
  hit
- Step-specific KPIs from `kpis_per_step.json[currentSubphase].rows`
  show passing values for sustained period
- User explicitly requests a phase check

## Special: 3.4 Terminal-State

If `currentSubphase == "3.4"` AND all 6 Scale-Complete-Conditions met:
→ Don't run this file. Instead trigger `event-3.4-milestone.md` which
celebrates, summarizes the journey, and switches to Operating Mode.

3.4 → no `next subphase` exists.

## Step 1: Phase-readiness check

Read `dashboard_data.json:path_state.roadmap.phases[*].subs[*]` (with
`here: true`) und `path_state.kpis.rows`. Pull current step's
deliverables + exit criteria from
`paths/scale/roadmap_defaults.json:steps[currentSubphase]`.

```
## Phase-Check: {phase.name} — Sub {roadmap.currentSubphase}

### Deliverables ({done}/{total})
- [x] {Deliverable 1} — done
- [x] {Deliverable 2} — done
- [ ] {Deliverable 3} — open

### Exit-Kriterien (readyWhen)
- [x] {readyWhen 1}
- [ ] {readyWhen 2}
...

### KPI-Status
{Table from path_state.kpis.rows with current vs target}

### Cross-KPI Status (will be preserved)
- Rule of 40: {value} / Target ≥ 40 / sustained {Q} quarters
- NDR: {value}% / Target > 110% / sustained {Q} quarters
- LH-Score: {value} / Target ≥ 80

### Einschätzung
{X von Y Deliverables erfüllt, {A} von {B} readyWhen-Kriterien.
Empfehlung: wechseln / noch nicht wechseln / nur Teilfortschritt}
```

## Step 2: Decision

```
Möchtest du in die nächste Sub-Phase wechseln?

- Auch wenn noch nicht alles erledigt ist, kann ein Wechsel sinnvoll
  sein wenn das Signal klar ist
- Aber: vorgezogener Wechsel ohne sustained-green Gates in 3.1 oder
  ohne V/TO™-Cascade in 3.2 ist der häufigste Failure-Mode
- Cross-Step-KPIs (Rule of 40, NDR, LH-Score) werden in jedem Fall
  preserved
```

If user defers: log `decision` entry in `decisions_learnings.jsonl`
mit `domain: "phase"`, `reasoning: "deferred {currentSubphase} → {next}
— reason: ..."`.

## Step 3: Special Sequencing Decision (3.2 → 3.3 OR 3.4)

If `currentSubphase == "3.2"` and ready for advance: the user has a
choice — 3.3 (Geographic) oder 3.4 (Product-Line)?

Per design doc: these are "parallel-okay" after 3.2-Exit, BUT
Skok-Discipline says sequence them — don't run both simultaneously.

```
Welcher Phase 11-Vektor zuerst?

(A) 3.3 — Expand internationally
    Wenn: home-market saturiert, board pusht international, Pipeline
    flach, Country-GM-Profil verfügbar.

(B) 3.4 — Add additional product lines
    Wenn: NDR > 110% sustained, customers actively asking for adjacent
    product, Same-ICP / Same-Channel viable.

(C) Vertical-Depth (innerhalb 3.4 subsumiert)
    Wenn: NDR 100-110%, niche-deepening highest-EV move.
    → wählt 3.4 mit Vertical-Depth-Vektor.
```

User wählt. Documented in `vector_state.next_vector_picked`.

## Step 4: Execute the phase change

### 4a. Roadmap state

1. `path_state.roadmap.phases[*].subs[*].here` — clear on the old sub,
   set on the new sub
2. `path_state.roadmap.currentSubphase` — set to new id (e.g. "3.2")

### 4b. Re-run auto-fill recipe for new step

Trigger `paths/scale/templates/auto_fill_recipe.md` with the new
`currentSubphase`. The recipe handles:

- `currentFocus` (from new step's `overview.mainGoal`)
- `bottleneck.title` / `bottleneck.description` (matched against
  `focus.bottleneck` if user provided in check-in)
- `oneThing` (from new step's first deliverable)
- `projects` (3 from new step's deliverables with numeric targets)
- `tasks` (5-7 atomic from new step's projects)
- `doNotDo` (home + sprint buckets from new step's bottlenecks)
- `kpis` (from `kpis_per_step.json[new_id].rows`, **Cross-Step values
  preserved**)
- `sources` (from new step's defaults; growth_mode-override applies
  only to 3.1)

### 4c. Cross-Step-KPI Preservation (Scale-specific)

When transitioning between Scale sub-phases, **always** preserve:

| KPI | Preserved Field | Source |
|---|---|---|
| Rule of 40 | `path_state.cross_kpis.rule_of_40.value` | `cross_kpi_log` last entry |
| NDR | `path_state.cross_kpis.ndr.value` | `cross_kpi_log` last entry |
| Leadership-Health-Score | `path_state.cross_kpis.lh_score.value` | `cross_kpi_log` last entry |

Write these into the new step's `kpis.rows.current` field for any matching
metric. Status (red/amber/green) recompute against new step's target.

The step-specific KPI (typically row 1 in kpis_per_step.json) is
RESET to default — new step, new dominant metric.

### 4d. Cadence-Mode-Toggle (3.1 → 3.2)

Special: when transitioning 3.1 → 3.2, `cadence_mode` shifts from
`default` to `l10` automatically:

```json
{
  "path_state": {
    "cadence_mode": "l10"
  }
}
```

User can override per-week via `weekly-checkin.md` Mode-Detection.

When transitioning 3.2 → 3.3 oder 3.2 → 3.4: cadence_mode bleibt `l10`.

### 4e. Project/Task Hygiene

`path_state.projects` und `path_state.tasks` are reset by the auto-fill
recipe. Old projects that didn't close are NOT auto-archived — surface
them and ask user:

```
Diese Projekte aus {old_subphase} sind noch offen:
- {project_1}
- {project_2}

Was soll damit passieren?
- Mit in die neue Sub-Phase nehmen (bleiben in path_state.projects)
- Über project-close.md formell schließen (mit Learning loggen)
- Streichen (entfernt aus path_state.projects, kein Learning)
```

### 4f. Audit-Trail

Append `decisions_learnings.jsonl`:

```jsonl
{"type":"decision","date":"YYYY-MM-DD","domain":"phase","reasoning":"Scale Sub-Phase-Wechsel {old_subphase} → {new_subphase}: {1-sentence reason — was achieved, what's next}","cross_kpis_preserved":{"rule_of_40":...,"ndr":...,"lh_score":...}}
```

## Rules

- **Be honest about phase** — don't position the user further than
  reality supports.
- **Phase-change is a hard reset** of currentFocus / bottleneck /
  oneThing / projects / tasks. Don't carry stale state.
- **Cross-Step KPIs ALWAYS preserved** — losing Rule of 40, NDR,
  LH-Score breaks longitudinal visibility.
- **Auto-fill recipe is the single source of truth** for re-generating
  step-specific dashboard fields. Don't duplicate field rules here.
- **3.2 → 3.3 oder 3.4 is a User-Decision.** Skok-Sequencing: pick
  one, prove it, then add the other.
- **3.4 Terminal**: use `event-3.4-milestone.md` NOT this file.

## Related files

- `paths/scale/roadmap_defaults.json` — step content
- `paths/scale/templates/auto_fill_recipe.md` — field-by-field recipe
- `paths/scale/templates/kpis_per_step.json` — KPI rows per step
- `event-3.4-milestone.md` — Scale-Complete Terminal Switch
- `project-close.md` — for closing legacy projects from old step
- `decisions_learnings.jsonl` — audit trail
- `cross_kpi_log.template.jsonl` — Cross-Step KPI history
