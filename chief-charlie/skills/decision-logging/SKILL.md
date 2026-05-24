---
name: decision-logging
description: Detect when the user makes a strategic decision or shares a learning in normal conversation, and append it to .founder-os/decisions_learnings.jsonl automatically. Use during every founder conversation — this is non-negotiable per the Founder OS SKILL.md rules.
---

# decision-logging

You watch every founder conversation for decisions and learnings, and append them to the append-only log without being asked. This is the "Mandatory Logging" rule from the founder-os master skill, surfaced as its own skill so you remember to do it.

## Trigger phrases (English + German)

Listen for any of these — the user doesn't have to call `/log-decision` explicitly:

**Decisions:**
- "we decided" / "wir haben entschieden"
- "we'll go with" / "wir gehen mit"
- "let's do X instead of Y" / "lass uns X statt Y machen"
- "killing X" / "wir killen X"
- "switching to" / "wir wechseln zu"
- "we're pivoting" / "wir pivoten"
- "going with option A" / "Option A"

**Learnings:**
- "I learned" / "ich habe gelernt"
- "turns out" / "stellt sich raus"
- "I was wrong about" / "ich lag falsch bei"
- "the data says" / "die Daten zeigen"
- "we discovered" / "wir haben rausgefunden"

**Hypothesis discarded:**
- "X is not the bottleneck after all" / "X ist doch nicht das Problem"
- "scratch that idea" / "vergiss die Idee"
- "actually Y, not X" / "eigentlich Y, nicht X"

## Workflow

1. **Detect** — when a trigger fires, briefly confirm with the user:

   > Soll ich das als Decision/Learning loggen? *(Decision/Learning: "{paraphrased}")*

   Skip the confirmation if it's unambiguous (e.g., user explicitly said "log this").

2. **Construct the JSON entry** using the schemas from `skills/founder-os/SKILL.md` — copy them verbatim, don't invent fields.

3. **Append** to `.founder-os/decisions_learnings.jsonl`:

```bash
echo '{...}' >> .founder-os/decisions_learnings.jsonl
```

Never read-and-rewrite the whole file — it's append-only.

4. **Acknowledge briefly** ("Logged.") and continue the conversation. Do not interrupt the founder's flow with a long confirmation.

## What NOT to log

- Tactical preferences ("ich nehme lieber Tee als Kaffee")
- Speculation without commitment ("vielleicht sollten wir X")
- Ideas that are still being explored — wait until commitment

If unsure: ask. One clarifying question is cheaper than a polluted log.
