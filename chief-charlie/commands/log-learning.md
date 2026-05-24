---
description: Append a learning (insight, observation, killed hypothesis) to .founder-os/decisions_learnings.jsonl.
argument-hint: [learning description]
---

# /log-learning

Append a learning entry to the append-only decision/learning log.

1. Get the learning content. If `$ARGUMENTS` is provided, use it as the seed. Otherwise ask:

   > **Was hast du gelernt — und woraus?**

2. Probe for missing fields:
   - **insight** — what you now understand (1–2 sentences)
   - **category** — `ICP | Messaging | Product | Pricing | Market | Org` (pick the best fit, ask if ambiguous)
   - **source** — `call | checkin | survey | manual | research`
   - **action** — what you'll do differently because of this (1 sentence)

3. Decide entry type:
   - If the user **discarded a hypothesis** (e.g., "we were wrong about X, the real thing is Y") → use the `hypothesis_discarded` schema
   - Otherwise → use the standard `learning` schema

4. Read `.founder-os/dashboard_data.json` → `current_path` for the `path` field.

5. Construct the JSON line. Schemas:

```json
// Standard learning
{"type":"learning","date":"YYYY-MM-DD","path":"...","category":"ICP|Messaging|Product|Pricing|Market","insight":"...","source":"call|checkin|survey|manual","action":"..."}

// Hypothesis discarded
{"type":"hypothesis_discarded","date":"YYYY-MM-DD","path":"...","hypothesis":"...","reason":"...","replaced_by":"..."}
```

6. Append to `.founder-os/decisions_learnings.jsonl` (one line, no pretty-printing).

7. Confirm and offer:

   > Learning logged. Möchtest du es als eigenes Markdown-File ausbauen (`decisions/learning-{date}-{slug}.md`)?
