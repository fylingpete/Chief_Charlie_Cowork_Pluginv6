# Event — Score Drop

## Trigger

Latest entry in `pmf_score_history.jsonl` shows `score` dropped more
than 5 points compared to the previous entry. Computed at the end of
each Monthly Review.

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.readiness.pmf_score` (current)
- `path_state.warnings` (existing list)

Read last two entries from `pmf_score_history.jsonl` to compute the
exact magnitude (`previous_score - current_score`). Read the latest
roadmap shipping notes from `decisions_learnings.jsonl` since the
previous Monthly to surface candidate causes.

## Action

1. **Notify the founder** plainly:
   > "Heads up — Sean Ellis Score ist um {{magnitude}} Punkte gefallen
   > (von {{prev}}% auf {{curr}}%). Das triggert eine kurze
   > Diagnose-Schleife."
2. **Investigation prompts** — ask in order, log each answer:
   - "Was hat sich seit der letzten Messung verändert?" (product, audience, distribution, market)
   - "Welche Initiative ist seit dem letzten Monthly gelaufert?"
   - "Hast du einen anderen Respondenten-Pool gemessen als sonst?"
3. **Log finding** as a `learning` entry in
   `decisions_learnings.jsonl`:
   `{kind: "learning", category: "pmf_score_drop", text, magnitude, at: today}`.
4. **Suggest knowledge review.** Recommend reading the
   `roadmap-fifty-fifty` knowledge block to re-check whether the
   Doubling Down ↔ Unblocking balance is still healthy.

## Wrap

Append to `path_state.warnings` in `dashboard_data.json`:

```
{
  "type": "score_drop",
  "at": "{{today}}",
  "magnitude": {{N}}
}
```

Where `magnitude` is `previous_score - current_score` (positive
integer = points dropped).
