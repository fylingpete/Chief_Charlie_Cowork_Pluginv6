# Event — No Survey Responses

## Trigger

`pmf_survey_responses.jsonl` has received no new entries for ≥ 14
days. Computed by comparing `today` to the latest `received_at`
timestamp in the file.

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.streams.pmf_survey_responses.last_received_at`
- `path_state.warnings` (existing list)

Compute `days_since_last = today - last_received_at`.

## Action

1. **Notify the founder**:
   > "Seit {{days_since_last}} Tagen sind keine neuen Survey-Antworten
   > eingegangen. Lass uns den Distribution-Kanal kurz checken."
2. **Prompt to verify the distribution channel** — ask:
   - "Läuft der Survey-Link noch? (Typeform/Form/Email aktiv?)"
   - "Wie viele neue User haben das Produkt in den letzten 14 Tagen genutzt?"
   - "Wann hast du zuletzt aktiv um Antworten gebeten?"
3. **Propose tactics** — pick 1-2 to commit to:
   - More outreach (in-app prompt, email batch, founder DMs)
   - Different channel (community post, social, partner list)
   - Incentive review (clearer ask, small reward, shorter survey)
4. **Suggest knowledge review.** Recommend reading the `segmentation`
   knowledge block to confirm you are still asking the right people.

## Wrap

Append to `path_state.warnings` in `dashboard_data.json`:

```
{
  "type": "no_response",
  "at": "{{today}}",
  "days_since_last": {{N}}
}
```

Where `N` is the integer day count since the last response was
received.
