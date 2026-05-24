# Event — 2.5 Milestone Reached (Phase 3 Switch)

## Trigger

`unit-economics-model.md` shows all THREE gates passing simultaneously:

- LTGP:CAC > 3 (computed on cohort ≥12 months old)
- CAC payback < 18 months (< 12 if SMB)
- Gross margin > 70%

PLUS:
- `path_state.events.gtm_25_milestone.fired` is not `true` (fires once
  per path)
- `path_state.cadences.last_monthly_at` data confirmed gates pass for
  ≥2 consecutive monthly reviews (not a one-off spike)

## Pre-flight

Read from `dashboard_data.json`:

- `path_state.kpis.rows` (current Step 2.5 row)
- `path_state.events.gtm_25_milestone` (fired flag)
- `path_state.path_switch_proposed_at` (may be null)

Read from logs:

- `unit-economics-model.md` last 2 monthly snapshots
- Last 6 entries from `monthly_review_log.jsonl`
- `decisions_learnings.jsonl` since Phase 2 start — for journey highlights

## Action

### Step 1 — Congratulate explicitly

> "Drei Gates bestanden:
> - LTGP:CAC = {ratio} (Target >3)
> - CAC-Payback = {months} Monate (Target <18)
> - Gross Margin = {margin} % (Target >70%)
>
> Du bist Phase-3-ready. Skok's Begründung: jetzt ist es nicht nur
> 'okay' Gas zu geben — es ist der teuerste Fehler, NICHT Gas zu geben.
> Die meisten Märkte sind winner-takes-all."

### Step 2 — Summarize the journey

Pull from `decisions_learnings.jsonl` and KPI history:

- **Top 5 decisions that drove unit economics up** (e.g. pricing
  increase, channel kill, ICP tightening, retention fix)
- **Top 5 learnings that mattered** (failed channels, objection
  patterns, ICP refinements)
- **KPI arc**: where did we start, where are we now? (LTGP:CAC,
  Payback, Margin, Bookings)
- **Sub-phase journey**: which step took longest? Which was hardest?

### Step 3 — Surface remaining risks

Before celebrating too hard, check:

- **Cash-trough position**: deepest point modeled, runway adequate?
- **Bookings trend**: still growing M-o-M, or flatlining beneath the
  unit-economics improvement?
- **Channel mix**: are we relying on a single channel that won't
  scale? Skok: "no single channel scales forever."
- **Pod health**: Pod 1 at quota for ≥2 quarters? Pod 2 at quota?
  Without that, scaling sales is premature.
- **Retention**: NDR > 100% (Negative Churn) achieved, or just
  acceptable retention? Skok: NDR > 100% is the SaaS multiplier.

If any of these flags red, surface them:

> "Diese 3 Gates passen — aber {risk_X} muss vorher noch geklärt
> werden, bevor wir Gas geben. Das wäre Phase 9 (Hit the Gas) ohne
> Fundament."

### Step 4 — Present the Phase 3 switch proposal

```
Du bist bereit für Phase 3 — "Hit the Gas and Scale".

Was sich ändert:
- Mindset: von Cash-Konservierung zu aggressiver Investition
- Fokus: nicht mehr Repeatability beweisen — sondern Volumen
- Hires: Marketing-Team aufbauen, VP Sales (wenn noch nicht da)
- Operations: andere Cadence (Skok CEO-Rolle, Schatz scaling rituals)
- Streams: Wechsel von monthly-review zu wöchentlichem Bookings-Review
- Timeline: Phase 3 dauert typically 2-5 Jahre (Skok)

Phase 3 Roadmap (laut roadmap_seed.json:phase3):
- 3.1 Hit the gas and scale
- 3.2 Scale the org and operating system
- 3.3 Expand into new markets
- 3.4 Add product lines

Willst du jetzt zum Scale Path wechseln, oder noch in 2.5 bleiben und
das Fundament härten?
```

### Step 5 — Await user confirmation

Do NOT auto-switch. Two options:

**5a. User confirms switch:**

```
path_state.events.gtm_25_milestone.fired = true
path_state.events.gtm_25_milestone.fired_at = today
path_state.path_switch_proposed_at = today
```

The actual path-switch flow is handled by master `SKILL.md` "Path
Switch" section. It will:
- Set `current_path = "scale"`
- Re-load `paths/scale/path.md` and (when built)
  `paths/scale/roadmap_defaults.json`
- Re-run `auto_fill_recipe.md` (eventual `paths/scale/templates/`)
  for sub-phase 3.1
- Switch cadences to scale-path operations

**Note:** As of writing, `paths/scale/path.md` is a skeleton. Surface
to the user that Phase 3 is partially-built and they may benefit from
co-developing it with the agent.

**5b. User defers:**

```
path_state.events.gtm_25_milestone.fired = true
path_state.events.gtm_25_milestone.fired_at = today
path_state.events.gtm_25_milestone.deferred_at = today
path_state.events.gtm_25_milestone.defer_reason = "{user reason}"
```

The user stays in 2.5. The event won't re-fire automatically — when
they're ready, they invoke `event-2.5-milestone.md` manually or it
re-fires after a quarterly-rebuild reaffirms the gates.

## Wrap

- Append `decisions_learnings.jsonl`:

  ```jsonl
  {"type":"milestone","date":"YYYY-MM-DD","domain":"gtm-phase","milestone":"2.5_milestone_reached","gates":{"ltgp_cac":..,"payback":..,"margin":..},"path_switch_decision":"confirmed|deferred"}
  ```

- If switched: cadences updated by master path-switch.
- If deferred: `path_state.cadences` continues unchanged.

## Connection to other operations

- Triggered FROM `monthly-review.md` Step 2.5 findings
- Triggered FROM `quarterly-rebuild.md` Section 8 if all gates pass
- Path-switch flow handed off to master `SKILL.md`

## Rules

- **Fires ONCE per path.** If user defers and gates still pass at next
  measurement, surface gently — don't re-celebrate fully.
- **Don't auto-switch.** Path-switch is the user's call, not the agent's.
- **Surface remaining risks** even if all 3 gates pass. Skok: gate-pass
  is necessary but not sufficient — channel concentration, retention
  health, cash-trough position all matter.
- **Honest about Phase 3 readiness state**: paths/scale is currently a
  skeleton, the user should know.

## Related files

- `unit-economics-model.md` — the three gates
- `quarterly-rebuild.md` Section 8 — where this typically gets flagged
- `monthly-review.md` Step 2.5 — first detection point
- `paths/scale/path.md` — destination path (currently skeleton)
- `knowledge/gtm/unit-economics.md` — Step 2.5 doctrine
- `knowledge/gtm/matrix/skok-phase8-unit-economics.md` — three gates source
- `knowledge/gtm/matrix/skok-phase9-hit-the-gas.md` — Phase 3 mindset shift
- `knowledge/gtm/matrix/skok-saas-cash-trough.md` — cash-trough check
- `knowledge/gtm/matrix/skok-rule-of-40.md` — fundability check
