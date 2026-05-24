# Event — 40% Milestone Reached

## Trigger

Latest entry in `pmf_score_history.jsonl` shows `score >= 40` AND
`respondent_count >= 30` AND
`dashboard_data.json` → `path_state.events.forty_percent_milestone.fired`
is not `true`. Fires **once** per path.

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.readiness.pmf_score`
- `path_state.readiness.respondent_count`
- `path_state.events.forty_percent_milestone` (fired flag)
- `path_state.path_switch_proposed_at` (may be null)

Read recent entries from `decisions_learnings.jsonl` to surface 3-5
notable journey highlights (top learnings + key decisions since path
start).

## Action

1. **Congratulate** the founder explicitly:
   > "Sean Ellis Score {{score}}% with {{N}} respondents — du bist über
   > die 40er-Schwelle. PMF-Signal bestätigt."
2. **Summarize the journey.** Pull highlights from
   `decisions_learnings.jsonl`:
   - Top 3 learnings that drove the score up
   - Key decisions made along the way
   - Score arc (start → current) from `pmf_score_history.jsonl`
3. **Present the GTM switch proposal** per master SKILL.md "Path
   Switch" section. Make the offer concrete: "Willst du jetzt zum GTM
   Path wechseln?" — explain what changes (cadences, focus, streams).
4. **Await user confirmation.** Do not auto-switch.

## Wrap

- Set `path_state.events.forty_percent_milestone.fired = true` in
  `dashboard_data.json` (so this event never re-fires).
- Set `path_state.events.forty_percent_milestone.fired_at = today`.
- If user **confirms switch**: set
  `path_state.path_switch_proposed_at = today`. Actual path-switch
  flow is handled by master SKILL.md.
- If user **defers**: leave `path_switch_proposed_at` null and note
  in `path_state.events.forty_percent_milestone.deferred_at`.
