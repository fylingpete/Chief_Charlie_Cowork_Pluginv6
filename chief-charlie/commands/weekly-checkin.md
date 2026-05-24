---
description: Run the weekly check-in for the user's current Founder OS path. Reviews progress, updates KPIs, captures decisions and learnings.
---

# /weekly-checkin

Run the weekly check-in. The exact workflow depends on the current path.

1. Read `.founder-os/dashboard_data.json` → `current_path`.

2. Load and follow the canonical workflow:
   - **PMF:** `skills/founder-os/paths/pmf/operations/weekly-checkin.md`
   - **GTM:** `skills/founder-os/paths/gtm/operations/weekly-checkin-review.md`
   - **Scale:** `skills/founder-os/paths/scale/operations/weekly-checkin.md` (auto-toggles to L10™ Mode at sub-phase 3.2+)

3. The check-in always covers:
   - **KPI review** — pull each row from `kpis.rows[]`, ask the user for current values, update the file
   - **Bottleneck** — confirm or change the current bottleneck
   - **Wins / losses** — at least 1 of each
   - **Decisions made this week** — append each one to `decisions_learnings.jsonl` with the schema from the master SKILL.md
   - **Learnings** — same: append to `decisions_learnings.jsonl`
   - **Next One Thing** — the single most important thing for next week

4. After completion:
   - Update `path_state.cadences.next_checkin_due` to today + 7 days
   - Append a summary row to `paths/{current_path}/templates/weekly_checkin_log.template.jsonl` (or the path-specific log)
   - Save the file
   - Confirm to the user that the check-in is logged

5. If the user is in Scale phase 3.2+, follow the **L10™ structure**: Segue → Scorecard™ → Rock™ Review → Customer/Employee Headlines → To-Do List → IDS (Identify, Discuss, Solve) → Conclude.
