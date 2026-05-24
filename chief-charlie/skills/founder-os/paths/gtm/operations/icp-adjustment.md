# ICP Adjustment

Used when a fundamental ICP hypothesis changes — different audience,
different pain, different trigger. Not for small tweaks (use
`playbook-update.md` for those).

## When to run this

- After ≥3 lost deals showing the same pattern (wrong segment, wrong
  pain, wrong trigger)
- After a `call-debrief.md` flags consistent ICP-mismatch
- When `path_state.warnings` accumulates `icp_match_uncertain` entries
- When founder feels the ICP is wrong but hasn't formalized it

## Step 1: Confirm what's changing

```
Was hat sich am ICP geaendert?

- Andere Zielgruppe? (anderer Titel, anderes Segment)
- Anderer Schmerz? (anderer Use Case)
- Anderer Trigger? (anderer Kaufanlass)
- Andere Disqualifikatoren? (negative ICP)
- Anderer Channel-Fit?
```

## Step 2: Archive the old hypothesis

Before writing the new version, lock the old one explicitly:

1. Append the old ICP version to `decisions_learnings.jsonl` as
   `hypothesis_discarded` with `reason` and `replaced_by`:

   ```jsonl
   {"type":"hypothesis_discarded","date":"YYYY-MM-DD","domain":"ICP","old":"...","reason":"...","replaced_by":"..."}
   ```

2. In `icp-doc.md`, append the old version to the Version History
   table as `v1-archived` (don't delete the file, the audit trail
   matters).

3. Document in 1-2 sentences why the new hypothesis is
   better-supported (which lost-deal patterns? which buyer-conversation
   IDs?). The Evidence Trail in `icp-doc.md` must be updated accordingly.

## Step 3: Write new version in `icp-doc.md`

The strict two-halves rule still applies — both positive AND negative
characteristics, ≥5 fields each.

1. Update `icp-doc.md`:
   - Set `version` to `v2-draft` in frontmatter
   - Update Target Market, Use Case, Positive/Negative sections
   - Reset Evidence Trail counts (new evidence required for v2 lock)
   - Reset Repeat-Win Validation (must be re-validated for v2)
   - Mark Contamination Check items as `unchecked` until re-validated

2. Update `dashboard_data.json`:
   - `data.currentFocus` if affected (the only canonical user-facing
     summary field — write into `data.*`, not `path_state.*`)
   - `data.bottleneck.title` / `data.bottleneck.description` if the new
     ICP shifts the active bottleneck
   - `path_state.icp_signals.conversations_since_change` → reset to 0
   - `path_state.icp_signals.lost_deals_since_change` → reset to 0

3. Append `decision` entry to `decisions_learnings.jsonl`:

   ```jsonl
   {"type":"decision","date":"YYYY-MM-DD","domain":"ICP","reasoning":"ICP-Wechsel zu {new_target_market}: {1-2-sentence reason}"}
   ```

## Step 4: Update related docs (cascade)

The ICP cascades downstream. Check and update:

- `messaging-doc.md` — does messaging still target the new ICP? If not,
  route to `messaging-adjustment.md` (one change per session — schedule
  for next session).
- `channel-test.md` — is the chosen channel still right for the new
  ICP? If ACV-band shifted (Skok GTM Model rule), kill the test and
  restart channel pick.
- `sales-playbook.md` — ICP Quick Reference section needs update.

## Validation thresholds (when to flip v2-draft → v2-locked)

The new ICP locks when:
- 10+ buyer-conversations with consistent fit signals
- ≥2 closed-won deals with the same playbook (repeat-win test)
- Sales-cycle length and close rate within target range
- Contamination Check passes all 6 items

## Rules

- **Never silently overwrite an old ICP** — always archive in
  `decisions_learnings.jsonl` AND in `icp-doc.md` Version History.
- **One change per session** — don't batch ICP + Messaging + Offer.
  Cascade through separate sessions.
- **If the trigger is upstream of Messaging**, route afterwards to
  `messaging-adjustment.md`.
- **Old `icp_playbook.md` (Living Doc)** stays as append-only
  notebook — it captures customer-language quotes from all hypotheses,
  including the discarded one. Don't delete it.

## Related files

- `icp-doc.md` — the structured v1/v2-locked deliverable being adjusted
- `icp_playbook.md` — append-only Living Doc with raw observations
- `messaging-adjustment.md` — downstream cascade if messaging affected
- `channel-test.md` — downstream cascade if ACV-band shifts
- `decisions_learnings.jsonl` — audit trail for archival
- `knowledge/gtm/repeatable-sales-motion.md` — Step 2.1 ICP doctrine
- `knowledge/gtm/matrix/skok-phase4-icp-and-messaging.md` — two-halves rule
