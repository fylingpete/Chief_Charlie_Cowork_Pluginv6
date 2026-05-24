---
description: First-run setup for Chief Charlie. Guides the user to a dedicated Chief Charlie folder, captures founder identity, and initializes Founder OS state files.
---

# /onboarding — Chief Charlie First-Run Setup

You are running the first-run setup for a new Chief Charlie user. This command has two phases: **(Phase 0) folder validation**, then **(Phase 1+) the full Founder OS onboarding** which lives in the `founder-os` skill.

## Phase 0 — Folder validation (BLOCKING)

Before doing anything else, verify the user is in a dedicated Chief Charlie folder. Run:

```bash
pwd && ls -la
```

Then check:

1. **Is `.founder-os/dashboard_data.json` already present?**
   - **Yes →** Onboarding has already been run. Tell the user that, show them the current path/phase from the dashboard, and offer `/founder-os` instead. Stop this command.
   - **No →** Continue to step 2.

2. **Does the current folder look dedicated to Chief Charlie?**
   Heuristics for "looks dedicated":
   - Folder is empty or contains only a handful of unrelated files
   - Folder name contains "charlie", "founder", "chief", "gtm", "pmf", "scale", or the user's company name
   - User explicitly created it for this purpose

   If the folder does **not** look dedicated (e.g., it's a code repo, a Desktop folder full of unrelated files, the user's home directory), **STOP and instruct the user**:

   > **Bevor wir starten, brauchst du einen dedizierten Ordner für Chief Charlie.** Claude Cowork arbeitet immer im Kontext eines Working-Directory — alles, was Chief Charlie baut, lebt dort.
   >
   > **Bitte jetzt:**
   > 1. Lege einen Ordner an, z.B. `~/ChiefCharlie/` oder `~/Documents/ChiefCharlie/{deine-firma}/`.
   > 2. Wähle diesen Ordner in Claude Cowork als Working-Directory aus.
   > 3. Wenn du im neuen Ordner bist, tippe `/onboarding` noch einmal.
   >
   > Mache mit: `mkdir -p ~/ChiefCharlie && cd ~/ChiefCharlie` im Terminal, dann starte Claude Cowork dort neu.

   Wait for the user to confirm they're in a new folder, then re-run the `pwd` check before continuing.

3. **Folder looks fine →** Initialize the workspace skeleton:

```bash
mkdir -p .founder-os/templates research deliverables knowledge decisions roadmaps kpis
```

## Phase 1+ — Founder OS onboarding

Hand off to the `founder-os` skill. Specifically:

1. Read `skills/founder-os/SKILL.md` from this plugin to load the master OS rules.
2. Read `skills/founder-os/onboarding.md` to load the canonical onboarding flow.
3. Read `skills/founder-os/assessment/onboarding-questions.md` for the exact question wording.
4. Execute the onboarding exactly as documented in `onboarding.md` — starting with the opening greeting, then Q1–Q4, then the hard stop / first roadmap render, then Q5–Q9, then Auto-Fill, then the Closing Flow.
5. The user's language is **German by default** — translate the canonical English questions to German at runtime, preserving meaning and tone, no decorative emojis.

## State files to create

By the end of `/onboarding`, these files must exist in the workspace:

```
.founder-os/
├── dashboard_data.json          # primary state (business_profile, path_state, currentPhase, kpis, ...)
├── roadmap_data.json            # per-step rich content (lazy-loaded but seeded at onboarding)
├── decisions_learnings.jsonl    # append-only decision/learning log (empty after onboarding)
└── templates/                   # deliverable stubs copied from the skill
```

Plus `onboarding_completed_at` set to the current ISO timestamp in `dashboard_data.path_state`.

## Hand-off

When onboarding completes, end with:

> Onboarding fertig. Du bist jetzt in **{path} {phase}** — *{phase title}*.
>
> Tippe `/founder-os` für den aktuellen Step und die anstehende Arbeit, oder leg gleich los:
>
> > **Was ist gerade dein größter Bottleneck?**
