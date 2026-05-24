---
description: Append a decision to .founder-os/decisions_learnings.jsonl. Use this when the user makes a strategic decision outside a check-in.
argument-hint: [decision description]
---

# /log-decision

Append a decision entry to the append-only decision log.

1. Get the decision content. If `$ARGUMENTS` is provided, use it as the seed. If not, ask the user:

   > **Was hast du entschieden, und warum?**

2. Probe for missing fields — ask one focused follow-up if any are unclear:
   - **decision** — what was decided (1 sentence)
   - **reasoning** — why this option over alternatives (1–2 sentences)
   - **reverse_if** — what would cause you to reverse this decision (1 sentence)

3. Read `.founder-os/dashboard_data.json` → `current_path` to fill the `path` field.

4. Construct the JSON line:

```json
{"type":"decision","date":"YYYY-MM-DD","path":"pmf|gtm|scale","decision":"...","reasoning":"...","reverse_if":"..."}
```

5. Append (do NOT overwrite) to `.founder-os/decisions_learnings.jsonl`:

```bash
echo '{"type":"decision","date":"...","path":"...","decision":"...","reasoning":"...","reverse_if":"..."}' >> .founder-os/decisions_learnings.jsonl
```

6. Confirm to the user:

   > Logged. Decision-Counter dieses Quartal: {count}. Soll ich dir den Eintrag nochmal vorlesen?

7. **Important:** This is an append-only log. Never read it and rewrite the whole file. Only append new lines.
