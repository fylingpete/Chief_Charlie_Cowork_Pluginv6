---
description: Run the quarterly rebuild. Strategic pivot assessment, KPI target adjustment, people/org changes. In Scale 3.2+, this is Wickman Quarterly Rocks™ Planning.
---

# /quarterly-rebuild

The heaviest cadence — a real "stop and rebuild" session, not a check-in.

1. Read `.founder-os/dashboard_data.json` → `current_path`.

2. Load and follow the canonical workflow:
   - **PMF:** `skills/founder-os/paths/pmf/operations/quarterly-rebuild.md`
   - **GTM:** `skills/founder-os/paths/gtm/operations/quarterly-rebuild.md`
   - **Scale:** `skills/founder-os/paths/scale/operations/quarterly-rebuild.md` (at 3.2+, this IS Wickman Quarterly Rocks™ Planning — different structure)

3. Sections (general — Scale 3.2+ overrides with Rocks™ format):
   - **Quarter retro** — what worked, what didn't, what surprised
   - **Strategic pivot assessment** — does the current path/phase still make sense?
   - **KPI target adjustment** — recalibrate targets based on reality
   - **People / org changes** — hires planned, exits, role changes
   - **Risk register** — top 3 risks for next quarter
   - **Next quarter's 3 Rocks™ (Scale)** or **next quarter's 3 priorities (PMF/GTM)**

4. After completion:
   - Update `path_state.cadences.next_quarterly_due` to today + 90 days
   - Append a row to `quarterly_rebuild_log.template.jsonl`
   - In Scale 3.2+: log each Rock™ to `rocks_completion_log.template.jsonl` with binary scoring at quarter end
   - If a phase transition is warranted, surface the recommendation but require explicit user confirmation
