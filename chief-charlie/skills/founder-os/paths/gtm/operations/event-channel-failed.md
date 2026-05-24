# Event — Channel Failed

## Trigger

Active `channel-test.md` shows the kill criteria are met:

- Reply rate / response rate below the kill threshold for ≥2 weekly
  check-ins, OR
- 30-day exclusive test ended with `result: "fail"`, OR
- CAC trend in `monthly-review.md` (step 2.3 / 2.5) shows the
  channel CAC > 2× target for 2 consecutive months

PLUS:
- `path_state.events.channel_failed.fired_at` is older than 30 days OR
  not yet fired this channel-test (this event can fire repeatedly,
  one per failed channel)

## Pre-flight

Read from `dashboard_data.json`:

- `path_state.roadmap.currentSubphase` (typically 2.1, but can fire
  in 2.3 / 2.5 too)
- `path_state.warnings` — existing list

Read from `channel-test.md`:

- Channel name (`chosen_channel`)
- Kill criterion that matched (`fail_signal_at_week_2` or _4)
- Total spend, founder hours, attempts, closed-won
- First-pass CAC estimate

Read from `monthly_review_log.jsonl` if step 2.3 or 2.5:

- Channel-CAC trend last 3 months
- Channel-attributed retention if available

## Action

### Step 1 — Notify the founder plainly

```
Channel-Test {channel_name} hat das Kill-Kriterium getroffen.

- Volumen versucht: {volume}
- Closed-won via diesem Channel: {closed_won}
- Reply-Rate: {reply_rate} % (Threshold war {kill_threshold} %)
- First-Pass CAC: ${cac} (Target war ${target_cac})

Das ist nicht "der Channel hat versagt" — das ist "der Test hat
funktioniert". Du hast ein klares Signal in 30 Tagen statt 6 Monaten
Wishful Thinking.
```

### Step 2 — Diagnose: was war wirklich der Engpass?

Gehe systematisch durch:

1. **War der Channel falsch für die ICP?**
   - Sucht die Zielgruppe wirklich auf diesem Channel? (z.B. CFOs sind
     selten auf TikTok)
   - Skok GTM-Model-Match: passt die ACV zum Channel-CAC? (z.B. $99/mo
     Produkt via Field Sales = strukturell broken)
2. **War das Messaging falsch für den Channel?**
   - Cold-Email-Copy braucht andere Hook als Landing Page
   - Quarter-Inch-Hole-Test bestanden vor dem Test?
3. **War das Volume zu niedrig für ein Signal?**
   - YC: für 1 Customer können 800 Cold Emails nötig sein
   - Mittlerweile genug Sample für Schluss?
4. **War der Test zu kurz?**
   - 30 Tage minimal, manche Channels (Content/SEO) brauchen Quartale
5. **War die Liste / Audience falsch?**
   - Right channel, wrong segment within it

### Step 3 — Decision

```
Was wollen wir mit diesem Signal machen?

A) Kanal komplett verwerfen → neuer channel-test.md mit anderem Kanal
   aus Hormozi Core Four. Empfehlung basierend auf ICP / ACV / Stage:
   {recommendation}

B) Test verlängern um 14 Tage mit Anpassung → was ändern?
   - Andere Liste / Audience
   - Andere Hook / Subject Line
   - Anderes Volume

C) Channel parken, ICP / Messaging zuerst fixen → route zu
   icp-adjustment.md oder messaging-adjustment.md, dann wieder zurück
   zu channel-test.md mit dem gleichen Kanal

D) Nur in 2.3+ Phase: Channel war in der S-Curve-Saturation. Add layer
   #2 jetzt, statt den ersten zu reanimieren
```

### Step 4 — Execute

Depending on decision:

**A — Verwerfen:**
- Update `channel-test.md`: `result: "fail"`, `decision: "switch-to-channel-X"`,
  `decision_rationale` filled
- Append `decisions_learnings.jsonl`:
  ```jsonl
  {"type":"learning","date":"YYYY-MM-DD","category":"CHANNEL","insight":"{channel_name} failed for {reason}","action":"switching to {new_channel}"}
  ```
- Create new `channel-test.md` for the new channel (or amend existing
  if no clean handoff). New test starts fresh — kill criteria,
  volume math, exclusivity commitment.

**B — Verlängern:**
- Update `channel-test.md`: `decision: "extend-14d"`,
  `decision_rationale` filled with specific change
- Reset week counters; weekly log continues
- Update kill criteria if needed (don't lower them — that's
  rationalization)

**C — ICP / Messaging fix first:**
- Mark channel-test as paused (status: `paused-pending-upstream-fix`)
- Schedule `icp-adjustment.md` or `messaging-adjustment.md` for next
  session
- Don't restart channel-test until upstream is locked

**D — Layer next channel (2.3 only):**
- Don't kill the first channel — it's saturating, not failing
- Add Channel #2 to `bookings-plan.md` Lead-Source Mix as planned
- Old channel stays as Channel #1, declining gracefully

### Step 5 — Update path_state.warnings

Append:

```json
{
  "type": "channel_failed",
  "at": "{today}",
  "channel": "{channel_name}",
  "subphase": "{currentSubphase}",
  "decision": "{A|B|C|D}",
  "magnitude": {first_pass_cac_or_reply_rate}
}
```

### Step 6 — Set fired flag

```
path_state.events.channel_failed.last_fired_at = today
path_state.events.channel_failed.last_channel = "{channel_name}"
```

This event can fire multiple times per path (different channels), so
we track per-channel rather than once-per-path.

## Connection to other operations

- Detected by `weekly-checkin-review.md` Q6 (step 2.1 specifically)
- Detected by `monthly-review.md` (step 2.3, 2.5 channel-CAC checks)
- Detected by `quarterly-rebuild.md` Section 3 (Channel Mix Review)
- May trigger downstream: `icp-adjustment.md`, `messaging-adjustment.md`,
  fresh `channel-test.md`

## Rules

- **The test working is not the test failing.** Reframe: the kill
  criteria did its job — you got a clean signal in 30 days. Don't
  let user feel like they wasted time.
- **Don't lower kill criteria post-hoc.** That's rationalization. If
  the test is extended, change the inputs (channel/list/copy), not
  the bar.
- **One channel at a time, even after a fail.** New channel-test
  starts with the same exclusivity discipline — not a "let's run two
  in parallel now."
- **In step 2.3, channel saturation ≠ channel failure.** Saturation
  means it worked and now it's plateauing — different decision (add
  layer, not kill).

## Related files

- `channel-test.md` — the test that failed
- `messaging-doc.md` — possibly culprit
- `icp-doc.md` — possibly culprit
- `icp-adjustment.md` / `messaging-adjustment.md` — upstream fixes
- `bookings-plan.md` — for step 2.3 channel mix decisions
- `unit-economics-model.md` — for step 2.5 channel-CAC implications
- `knowledge/gtm/repeatable-sales-motion.md` — channel-pick doctrine
- `knowledge/gtm/hormozi/hormozi-core-four.md` — channel framework
- `knowledge/gtm/matrix/skok-gtm-model-selection.md` — ACV-channel fit
- `knowledge/gtm/matrix/skok-phase6-scalable-lead-sources.md` — S-curve
  saturation (step 2.3)
