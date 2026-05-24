---
name: kpi-tracking
description: Read, update, and reason about KPIs stored in .founder-os/dashboard_data.json. Use when the user mentions a metric, when running a check-in, or when comparing current vs. target values.
---

# kpi-tracking

You manage the KPI rows in `dashboard_data.json` → `kpis.rows[]`. This skill handles read, update, and status calculation.

## Data shape

`.founder-os/dashboard_data.json` has a `data.kpis.rows[]` array (or `kpis.rows[]` depending on version). Each row:

```json
{
  "metric": "MRR",
  "current": "4,200 EUR",
  "target": "10,000 EUR",
  "status": "amber"
}
```

Valid `status` values: `"red"`, `"amber"`, `"green"`. **Nothing else.** The UI ignores other values.

Never write `label` / `value` fields — the UI ignores those. Always use `metric` / `current` / `target` / `status`.

## Updating a KPI

1. **Read the dashboard:** `Read .founder-os/dashboard_data.json`
2. **Find the row** matching the metric the user mentioned. Be lenient on naming ("MRR" matches "Monthly Recurring Revenue").
3. **Update `current`** with the new value. Keep the user's unit string ("4,200 EUR", "47 customers", "12%").
4. **Recompute `status`:**
   - `green` if current ≥ target
   - `amber` if current ≥ 80% of target
   - `red` if current < 80% of target
   - For inverse metrics (churn, CAC payback) — green means *lower* than target. Ask the user if the direction is ambiguous.
5. **Write back** using Edit (string replacement on the JSON, exact match) — never rewrite the whole file unless the structure changed.
6. **Confirm** to the user: `MRR aktualisiert: 4.200 EUR → 4.800 EUR (Status: amber, Ziel: 10k)`

## Adding a new KPI

Only add KPIs that are listed in the path's `templates/kpis_per_step.json` for the current phase. If the user asks to track something custom, ask first:

> Soll das eine einmalige Custom-KPI sein, oder soll ich sie als persistente Metrik in die Step-Templates aufnehmen?

For one-offs: add to the dashboard only. For persistent: also add to `kpis_per_step.json` in the founder-os skill (this changes the plugin source, surface it as a decision).

## Reading KPIs

When the user asks "wie stehen wir?" or "show me the KPIs":

```
| Metric | Current | Target | Status | Δ to target |
|---|---|---|---|---|
| MRR | 4,200 EUR | 10,000 EUR | 🟡 amber | -5,800 EUR |
| Customers | 47 | 100 | 🟡 amber | -53 |
```

Always show delta — bare numbers without targets are useless.

## Trend tracking

For trends over time, use the path-specific log files (e.g., `weekly_checkin_log.template.jsonl`). The dashboard is only a snapshot — it does NOT store history. If the user asks "how has MRR moved?", grep the weekly check-in log.
