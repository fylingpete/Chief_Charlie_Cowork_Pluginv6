---
description: Open the Founder OS — shows current phase, bottleneck, KPIs, and the next concrete step. Use this as the daily entry point.
---

# /founder-os — Founder OS Entry Point

Load the Founder OS for this session:

1. **Verify state exists.** Run `ls .founder-os/dashboard_data.json` — if it does not exist, tell the user to run `/onboarding` first and stop.

2. **Trust the SessionStart snapshot** if it's in your context (look for "Founder OS Dashboard Snapshot"). Otherwise read `.founder-os/dashboard_data.json` directly.

3. **Load the master skill.** Read `skills/founder-os/SKILL.md` from this plugin.

4. **Load the current path file.** Based on `current_path` from the dashboard, read `skills/founder-os/paths/{pmf|gtm|scale}/path.md`.

5. **Load the current step's rich content.** Read `.founder-os/roadmap_data.json` and pull the entry whose `id` matches `currentPhase` (e.g., `"1.3"`).

6. **Display to the user** in this structure:

```
## {Path Name} — Phase {phase_id}: {phase_name}

**Why this step:** {whyThisStep / overview}

**Current bottleneck:** {bottleneck.title} — {bottleneck.description}

**One Thing this week:** {oneThing}

### KPIs
| Metric | Current | Target | Status |
|---|---|---|---|
| ... | ... | ... | 🟢/🟡/🔴 |

### Open tasks
- [ ] {task 1}
- [ ] {task 2}

### Next actions
1. ...
2. ...
```

7. **End with one focused question** — usually "Was möchtest du als erstes angehen?" or, if a cadence is overdue (check `path_state.cadences`), offer that cadence instead.

Follow all rules in `skills/founder-os/SKILL.md` — especially the Data Contract (single source of truth, append-only logs, mandatory logging).
