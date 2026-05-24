---
name: memory-search
description: Search across the user's Founder OS workspace (decisions, learnings, deliverables, research, knowledge notes) using grep + glob. Use when the user asks "what did we decide about X", "did we cover Y", "find the doc on Z", or anything that requires recall from past work.
---

# memory-search

You search the user's Chief Charlie workspace for relevant prior content. This is the plugin's replacement for vector embeddings — it's grep-based, not semantic, so you have to be smart about query construction.

## When to use

- User asks "What did we decide about X?"
- User asks "Have we covered Y before?"
- User asks "Where is the doc on Z?"
- Before drafting something new, to check if it already exists
- When the founder mentions something familiar and you suspect it's in the workspace

## How to search

1. **Start broad with Glob** to map the territory:

```
Glob: **/*{topic}*.md           # filenames containing the topic
Glob: .founder-os/**/*           # all state files
Glob: deliverables/**/*.md       # all deliverables
```

2. **Then Grep for content**:

```
Grep "{exact phrase or keyword}" path:.  output_mode:files_with_matches
Grep "{keyword}" path:.  output_mode:content -C 2
```

Use case-insensitive search (`-i`) and multiple keyword variants (English + German if applicable).

3. **For the decision/learning log** — it's JSONL, one entry per line:

```
Grep "{keyword}" path:.founder-os/decisions_learnings.jsonl
```

4. **For dated work** (recent first):

```
Glob: **/2026-*.md
Glob: **/*.md  (then sort by date in filename if present)
```

## Synthesizing results

- Open the top 3–5 matches with `Read`
- Quote the most relevant 1–2 sentences from each, with the file path
- If results are stale (>3 months old), say so and ask if the user wants to revisit
- If nothing matches, say so honestly — do NOT invent a recollection

## Output format

```
**Found in 3 files:**

1. **`decisions/2026-03-pricing.md`** — "Wir gehen auf 49€/Monat statt 99€, weil ..."
2. **`.founder-os/decisions_learnings.jsonl`** (line 47) — `{"type":"decision","date":"2026-03-14","decision":"..."}`
3. **`deliverables/icp-doc.md`** § "Pricing context" — "Self-serve buyers anchor at ..."

**Synthesis:** {one sentence pulling them together}

Möchtest du eines davon öffnen?
```

## What this skill CAN'T do

- No semantic similarity — synonyms won't match unless you Grep for them explicitly
- No cross-language matching unless you grep both German and English variants
- No ranking by relevance — you have to read and rank yourself
- No search across audio/video/PDF binaries (use `Read` on each if needed)

When semantic recall really matters and grep is failing, tell the user honestly: "Ich finde es nicht mit Stichwortsuche — kannst du mir noch ein anderes Wort geben, das in dem Doc stand?"
