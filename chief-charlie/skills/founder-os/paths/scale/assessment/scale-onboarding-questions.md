# Scale Path — Onboarding Questions Q-Scale-1 to Q-Scale-4

Run only after path routing has committed `current_path: "scale"`.
These 4 questions deepen the picture beyond the universal Q1-Q8 (and
beyond GTM's Q9-Q12, if the user transitioned via the `event-2.5-
milestone.md` switch-out flow). They feed the Source-Override for step
3.1, the starting-subphase routing, and the cross-step KPI baseline.

Ask one at a time. After each answer, acknowledge briefly and move on.
Skip a question if an existing workspace artifact already answers it
(summarize what you found and ask if it's still accurate).

---

## Q-Scale-1 — How are you funding the scale phase?

**Wording:** "Wie finanzierst du die Scale-Phase — und was ist deine
nächste 18-Monats-Capital-Strategie?"

**Pre-fill from prior path:** if user came from GTM and
`path_state_archive.gtm.cash_runway_at_phase8` exists, surface it:
"Du hattest in Phase 2.5 noch {{runway}} Monate Runway. Wie war die
Capital-Strategie für die Scale-Phase?"

**Explainer:** "Diese Frage entscheidet, welche Source-Stimmen wir in
Step 3.1 surfacen. Bootstrap-Founder hören Cash-Trough-Disziplin
zuerst; VC-backed Founder hören Velocity + Rule of 40; PE-ready
Founder hören Margin-Expansion."

**Type:** enum

**Valid answers:** `bootstrapped` | `vc_backed` | `pe_ready`

**Options to present:**
- **Bootstrapped** — Cash-First, profit-funded growth, Margin-driven,
  langsame Headcount-Wachstum. Series-Funding nicht im Plan.
- **VC-Backed** — Burn-Controlled, Velocity-First. Series B oder C
  im 18-Monats-Window. Aggressive Reinvestment.
- **PE-Ready** — Rule-of-40-Optimization, Margin-Expansion für
  Exit-Window. Bewertung statt Velocity.

**Store:** `path_state.growth_mode`

**Parser hints:**
- "bootstrapped", "self-funded", "profit-funded", "kein VC" → `bootstrapped`
- "VC", "Series A/B/C", "venture-backed", "burning Capital" → `vc_backed`
- "PE", "Exit", "Margin-Optimierung", "DCF" → `pe_ready`

**Downstream effects:**
- `paths/scale/templates/auto_fill_recipe.md` Source-Override (slot 4 in step 3.1) wird applied
- `monthly-review.md` Cross-KPI focus shifts (Rule of 40 weights different per mode)
- `cash-trough-model.md` Sensitivity-Analyse (default Polster = 6 Mo bei bootstrapped, 9 Mo bei vc_backed, 4 Mo bei pe_ready)

---

## Q-Scale-2 — Which Phase-9 gates are currently passing?

**Wording:** "Welche der drei Phase-9-Gates sind aktuell grün — und
seit wann?"

**Pre-fill from prior path:** if user came from GTM and last
`monthly_review_log` entry had Phase-8-Gate-Status: pre-fill values
and confirm.

**Explainer:** "Skok's three Gates (LTV:CAC > 3, CAC-Payback < 18 Mo,
NDR > 100%) licensen Phase 3. Alle drei seit ≥ 2 Monaten grün → wir
sind in 3.1 ready zum Gas geben. Wenn weniger: wir starten 3.1 mit
Härtung statt Gas."

**Type:** structured

**Sub-fields to capture:**
- `ltv_cac_current`: numeric (e.g. 3.2)
- `cac_payback_months_current`: numeric (e.g. 14)
- `ndr_current_pct`: numeric (e.g. 105)
- `months_all_three_green`: integer (0, 1, 2, ...)

**Store:**
- `path_state.cross_kpis.ndr.value` (initial reading)
- `path_state.kpis.rows[*].current` (in 3.1's three-gate row)
- Three-Gate-Dashboard initial draft seeds

**Parser hints:** if user says "alle drei grün seit 3+ Monaten" → set
`months_all_three_green: 3`. If "noch nicht alle" → identify which
gate is red and set `months_all_three_green: 0`. Surface this in the
Closing-Flow as "Du startest 3.1 mit {{X}} Gates grün — Reihenfolge
ist erst Gate-Härtung, dann Gas-Pedal."

---

## Q-Scale-3 — Where are you organizationally?

**Wording:** "Wo steht die Organisation heute — wie viele Leute, wer
sitzt im Leadership-Team, hast du schon einen Integrator oder einen
formalen V/TO™?"

**Explainer:** "Step 3.2 ist EOS™-Install. Wenn der Integrator-Seat
schon klar besetzt ist und V/TO™ existiert: wir starten 3.2 mit
Refresh. Wenn nicht: wir starten 3.2 mit Foundational-Install."

**Type:** free_text + structured

**Sub-fields to capture:**
- `headcount`: integer
- `leadership_team_size`: integer
- `integrator_seat_filled`: boolean (Y/N)
- `vto_exists`: boolean (Y/N)
- `l10_running_weekly`: boolean (Y/N)
- `last_org_checkup_score`: numeric or null (0-100, null if never run)

**Store:**
- `path_state.org_state.headcount`
- `path_state.org_state.integrator_named`
- `path_state.org_state.eos_install_status` (`none` | `partial` | `full`)
- `path_state.cross_kpis.lh_score.value` (if `last_org_checkup_score` provided)

**Parser hints:**
- "Founder ist alles" + "kein Integrator" → `eos_install_status: none`
- "Integrator existiert" + "V/TO™ nicht" → `eos_install_status: partial`
- "alles läuft" + "L10™ seit Monaten" → `eos_install_status: full`

**Downstream effects:**
- Routes the user's effective starting subphase: if `eos_install_status == "full"` and 3.1 gates green sustained: jumps directly to 3.3 or 3.4 vector decision
- If `none`: surfaces in 3.1's first weekly check-in that EOS™-foundation needs to be sequenced AHEAD of pod expansion

---

## Q-Scale-4 — Which expansion vectors are you considering?

**Wording:** "Welche Expansion-Vektoren stehen für die nächsten 24
Monate auf dem Tisch — international, neues Produkt, Acquisition,
oder erstmal nur Core-Vertiefung?"

**Explainer:** "Phase 11 hat 3 Vektoren (Geographic 3.3, Product-Line
3.4, M&A). Skok-Disziplin: einer zuerst, dann der nächste. Wir setzen
hier nur den initial Forecast — Vector-Decision passiert in 3.4 (via
`vector-decision-doc.md`)."

**Type:** multi_select + free_text

**Valid answers (multi):** `geographic` | `second_product` | `vertical_depth` | `m_and_a` | `none_yet`

**Options to present:**
- **Geographic Expansion** — international, neues Land
- **Second Product** — Adjacent SaaS-Produkt verkauft an gleiche ICP
- **Vertical Depth** — tiefer in existing Niche (Pricing, Features, Integrationen)
- **M&A** — Acquisition als Vector-Buy
- **Noch keiner** — fokussiert auf 3.1 + 3.2 erstmal

**Sub-fields:**
- `vectors_considered`: list of selected
- `vectors_ranked`: free text — user's intuition on which first
- `customers_asking_for_what`: free text — Customer-Pull-Signals
- `board_pressure_on_what`: free text — Investor-Pull-Signals

**Store:**
- `path_state.vector_state.vectors_considered` (initial list)
- `path_state.vector_state.customer_pull_signals`
- `path_state.vector_state.board_pull_signals`

**Parser hints:** This is descriptive (no commitment yet). Decision
happens in 3.4 via `vector-decision-doc.md` + Core-Focus™-Filter.
Surface in Closing: "Vector-Pick passiert formal später — wir tracken
diese Optionen aber jetzt."

---

## Closing of Scale-Onboarding

After Q-Scale-1 to Q-Scale-4 are captured:

1. **Run `paths/scale/templates/auto_fill_recipe.md`** with the new
   `path_state` to populate `currentFocus`, `bottleneck`, `oneThing`,
   `projects`, `tasks`, `kpis`, `doNotDo`, `sources` from
   `roadmap_defaults.steps["3.1"]`.
2. **Apply growth-mode Source-Override** (slot 4 swap) per
   `auto_fill_recipe.md` swap table.
3. **Set `path_state.cadences.next_checkin_due = today + 7 days`** for
   the first weekly check-in.
4. **Set `path_state.cadences.next_monthly_due = today + 30 days`**.
5. **Set `path_state.cadences.next_quarterly_due = today + 90 days`**.
6. **Set `path_state.cadences.next_annual_due = today + 365 days`**
   (Scale-only cadence — see `paths/scale/operations/annual-planning.md`).
7. **Surface starting-subphase decision** to user based on Q-Scale-2 +
   Q-Scale-3 answers:
   - Gates not all green sustained: start 3.1 with Gate-Härtung focus
   - Gates green ≥ 6 Mo + EOS™ install full: skip ahead to 3.3/3.4 vector pick
   - Default: start 3.1 with `here: true`

## Rules

- **One question at a time.** Don't batch.
- **Skip questions where existing artifacts answer them.** GTM→Scale
  transitions inherit a lot from `path_state_archive.gtm`.
- **Q-Scale-1 is non-skippable.** Growth-Mode drives Source-Override
  immediately on Closing.
- **Q-Scale-3 routes the starting subphase.** Don't auto-pick 3.1 if
  the org is already EOS™-installed; surface options.
- **Q-Scale-4 is descriptive, not committal.** Vector-Decision-Doc
  in 3.4 is where Core Focus™ + 10-Customer-Pre-Sell discipline gets
  applied.

## Related files

- `paths/scale/path.md` — Path-Goal + Switch-out
- `paths/scale/templates/auto_fill_recipe.md` — Source-Override consumed Q-Scale-1
- `paths/scale/roadmap_defaults.json` — Step content sourced from
- `paths/scale/operations/phase-change.md` — sub-phase advance
- `paths/scale/templates/dashboard_data.seed.json` — `path_state` seed
- Master `SKILL.md` Path Switch GTM → Scale section
