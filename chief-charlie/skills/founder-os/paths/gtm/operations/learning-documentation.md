# Document a Learning

Quick capture of a single learning without running a full review.

## Step 1: Capture

```
Was hast du gerade gelernt oder beobachtet?
```

## Step 2: Categorize and store

Agent picks a category (`ICP` / `MSG` / `SALES` / `ONBOARD` / `RETAIN` / `PRODUCT`) and appends a single line to `decisions_learnings.jsonl`:

```jsonl
{"type":"learning","date":"YYYY-MM-DD","category":"...","source":"...","insight":"...","action":"..."}
```

Then echo back:

```
Eingetragen in decisions_learnings.jsonl:

  type: learning
  date: {Datum}
  category: {Kategorie}
  source: {Quelle}
  insight: {Learning}
  action: {Aktion}

Soll ich daraus eine Aenderung am Playbook oder am dashboard_data.json ableiten?
```

If yes → route to `playbook-update.md`, `icp-adjustment.md`, or `messaging-adjustment.md`.

## Categories

- `ICP` — target audience, pain, trigger
- `MSG` — messaging, positioning, copy
- `SALES` — discovery, demo, objection, close
- `ONBOARD` — first-value moment, activation
- `RETAIN` — retention, expansion, churn
- `PRODUCT` — product-shape feedback

## Rules

- Append-only — never rewrite the JSONL
- One JSON object per line, no outer array
- If insight is large, prefer linking to a doc rather than stuffing prose into the line
