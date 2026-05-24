# Scale Learning Documentation

Lightweight ad-hoc capture. Run when user says "Lass uns das festhalten"
oder "Ich hab grad was Wichtiges gelernt" — outside scheduled cadences.

NOT a full review. NOT a decision. Just a structured way to capture
what the user observed, classified to enable later pattern-matching
in Monthly + Quarterly Reviews.

## When to run

- User explicitly requests learning-capture
- Mid-session, the user mentions a learning that's substantive enough
  to deserve its own structured log (not just throwaway weekly note)
- After a meaningful event (call, decision, customer-conversation,
   team-incident) where the lesson is fresh

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.roadmap.currentSubphase` — for category-default
- `bottleneck.title` — for context

## Action

### Step 1 — Capture the raw learning

> "Was hast du gelernt? Sag's mir in einem Satz oder zwei — wenn du
> mehr Detail brauchst, fügen wir später Context hinzu."

User responds. Capture verbatim.

### Step 2 — Classify

Pick category. Categories aligned with Scale-step-context (mirrors
weekly-checkin Q-2 categorization):

- **GATES** — Three-Gate / Unit-Economics related (3.1)
- **TROUGH** — Cash-Trough / Runway related (3.1)
- **POD** — Pod-cloning / Sales-Org related (3.1)
- **CHANNEL** — Channel-Mix / Lead-Source related (3.1)
- **ORG** — EOS™ / Accountability-Chart / People (3.2)
- **L10** — L10™-Cadence / IDS™-Quality (3.2)
- **HIRING** — Exec-Hire / Recruiting-Velocity (3.2)
- **COUNTRY** — Country-Launch / Localization (3.3)
- **VECTOR** — Second-Product / Vertical-Depth / M&A (3.4)
- **FOCUS** — Core Focus™ / Off-Cone discipline (3.4)
- **OTHER** — anything that doesn't fit

→ Suggest default based on currentSubphase but allow override.

### Step 3 — Add minimal context (optional, 1-2 fields)

- **Was hat es ausgelöst?** (Event / Conversation / Number-Trend)
- **What would you do differently next time?** (if applicable)
- **Wer sollte es noch wissen?** (Team-Member oder Function-Head)

Skip if the user just wants the bare learning logged.

### Step 4 — Append to log

Append to `decisions_learnings.jsonl`:

```jsonl
{"type":"learning","date":"YYYY-MM-DD","subphase":"...","category":"GATES|TROUGH|POD|...","raw":"<user statement>","trigger":"<optional>","next_time":"<optional>","share_with":"<optional>"}
```

### Step 5 — Surface related patterns (optional)

If this category has 3+ entries in last 30 days:

> "Du hast in den letzten 30 Tagen {{N}} ähnliche {{category}}-
> Learnings festgehalten. Pattern wert das im next Monthly Review zu
> diskutieren?"

→ If yes: append to `path_state.events_pending` mit
   `{"type": "pattern_emerging", "category": "...", "count": N}`.

## Rules

- **5 Min budget.** Keine deep-dive Decision. Wenn größer: route zu
   passender event-*.md.
- **Verbatim capture.** Founder's exact phrasing > structured rewrite.
- **Category required.** Ohne Category kann Monthly + Quarterly nicht
   pattern-matchen.
- **No follow-up commitment by default.** Learning ist Learning;
   Decision oder Action ist separate.

## Connection to other operations

- Fed by `weekly-checkin.md` Q0 + Q2 (longer learnings)
- Pattern-detected in `monthly-review.md` Section 4
- Pattern-detected in `quarterly-rebuild.md` Section 1 + 4

## Related files

- `decisions_learnings.jsonl` — append-target
- `weekly-checkin.md` — primary learning-capture during normal flow
- `monthly-review.md` — pattern-analysis
- `quarterly-rebuild.md` — meta-pattern over 3 months
