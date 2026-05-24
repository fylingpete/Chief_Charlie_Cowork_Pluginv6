# Messaging Adjustment

Used when a fundamental messaging hypothesis changes — different core
message, different pitch, different value frame. Not for small tweaks
(use `playbook-update.md` for those).

## When to run this

- Cold-outreach reply rate < threshold for 2 weeks (current message
  isn't landing)
- Discovery calls show consistent confusion ("what do you actually
  do?") — signal: message isn't clear
- New objection pattern emerges in 3+ calls — signal: message isn't
  addressing real concerns
- Hormozi 5-rules-test fails on retrospective audit (e.g. message
  drifted into feature-tour, lost benefit-led discipline)
- ICP just changed via `icp-adjustment.md` and messaging needs to
  follow

## Step 1: Confirm what's changing

```
Was willst du am Messaging anpassen?

- Andere Kernbotschaft? (anderes Pain-Frame)
- Anderer Pitch? (andere Story-Reihenfolge)
- Anderes Outcome-Frame? (anderes Versprechen — quarter-inch hole)
- Anderer Proof-Stack? (andere Evidence)
- Anderer Hook für Cold-Outreach?
- Andere Differentiation-Aussage?
```

## Step 2: Archive the old hypothesis

1. Append the old messaging version to `decisions_learnings.jsonl` as
   `hypothesis_discarded` with `reason` and `replaced_by`:

   ```jsonl
   {"type":"hypothesis_discarded","date":"YYYY-MM-DD","domain":"MSG","old":"...","reason":"...","replaced_by":"..."}
   ```

2. In `messaging-doc.md`, append the old version to the Version
   History table as `v1-archived`. The Buyer-Word Trail entries from
   v1 stay (audit value), but mark them as "v1 evidence".

3. Document in 1-2 sentences why the new hypothesis is
   better-supported (which call-debrief patterns? which buyer quotes?
   which channel signals?).

## Step 3: Write new version in `messaging-doc.md`

The strict 5-rules-test still applies — benefit-led, clear, simple,
short, differentiated. Plus quarter-inch-hole-test (>70% hole-to-drill
ratio).

1. Update `messaging-doc.md`:
   - Set `version` to `v2-draft` in frontmatter
   - Update Core Message line, Quarter-Inch-Hole sections, Use-Case
     Specificity, Differentiation, SPCL decomposition (optional)
   - Update Channel Variants — each variant must be re-derived from
     the new core message
   - Reset Buyer-Word Trail (new evidence required for v2 lock)
   - Reset Validation Against Repeat Wins (must be re-validated)
   - Mark Contamination Check items as `unchecked` until re-validated

2. Update `dashboard_data.json`:
   - `data.bottleneck.title` / `data.bottleneck.description` if the new
     messaging shifts the active bottleneck
   - `path_state.messaging_signals.conversations_since_change` → reset to 0
   - `path_state.messaging_signals.reply_rate_since_change` → reset to 0

3. Append `decision` entry to `decisions_learnings.jsonl`:

   ```jsonl
   {"type":"decision","date":"YYYY-MM-DD","domain":"MSG","reasoning":"Messaging-Wechsel: {old core line} → {new core line}. {1-sentence reason}"}
   ```

## Step 4: Update related docs (cascade)

- `sales-playbook.md` — One-Liner Pitch and Discovery Call opener need
  to reflect new message
- `channel-test.md` — `message_used` reference points to new
  `messaging-doc.md` v2; the channel test continues but with the new
  variant
- `objection-map.md` — old objections may not apply anymore; new
  objections may emerge. Watch the next 5 calls.

## Validation thresholds (when to flip v2-draft → v2-locked)

The new messaging locks when:
- 5+ conversations with consistent positive resonance to the new core line
- Reply rate / book rate ≥ pre-change baseline (or stated improvement target)
- Objection pattern stable (no new emerging objections after 2 weeks)
- ≥2 closed-won deals via the new messaging
- Contamination Check passes all 6 items

## Rules

- **Never silently overwrite** — always archive in
  `decisions_learnings.jsonl` AND in `messaging-doc.md` Version History.
- **Test new messaging on cold outbound BEFORE updating sales-script
  openers.** Cold gets unbiased reply rate; warm calls already have
  rapport that masks message problems.
- **If the change comes from a deeper ICP shift**, run
  `icp-adjustment.md` FIRST, then this. Don't do both in one session.
- **Old `messaging_playbook.md` (Living Doc)** stays as append-only
  notebook — it captures all observations including ones from
  discarded messaging hypotheses.

## Related files

- `messaging-doc.md` — the structured v1/v2-locked deliverable being adjusted
- `messaging_playbook.md` — append-only Living Doc with observations
- `icp-adjustment.md` — upstream cascade if ICP must change first
- `sales-playbook.md` — downstream — opener and pitch use new message
- `channel-test.md` — downstream — channel-variant uses new message
- `objection-map.md` — downstream — new messaging changes objections
- `decisions_learnings.jsonl` — audit trail for archival
- `knowledge/gtm/repeatable-sales-motion.md` — Step 2.1 messaging doctrine
- `knowledge/gtm/hormozi/hormozi-spcl.md` — SPCL frame
- `knowledge/gtm/matrix/skok-phase4-icp-and-messaging.md` — 5-rules
