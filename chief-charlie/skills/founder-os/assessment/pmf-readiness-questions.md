# PMF Readiness Check — 4 Questions

**Run only if onboarding Q3a is `engaged_users` or `survey_running`.** For
`idea_only` and `mvp_built`, the readiness check is meaningless (no users to
survey yet). Those substages start at step 1.1 or 1.3 respectively, and the
readiness check is naturally satisfied as the user progresses through the
roadmap.

---

Run only after path routing has committed `current_path: "pmf"`.

These questions probe whether the founder is ready to start measuring PMF
or whether they need to first build/instrument something. Soft-gates (not
hard blocks) — surface concerns, then let the founder decide whether to
proceed.

---

## Q1 — Does your product exist and is it currently used by real people?

**Type:** boolean
**Store:** `path_state.readiness.product_exists`
**Soft-gate:** if false, surface: "Du hast noch kein Produkt im Einsatz —
PMF kann man nicht messen ohne Nutzer. Wir können trotzdem mit der
Vorbereitung starten (HXC-Hypothese, Survey-Design), aber die erste echte
Messung wartet bis du Nutzer hast. OK?"

---

## Q2 — How many people used your product at least twice in the last two weeks?

**Type:** integer
**Store:** `path_state.readiness.engaged_user_estimate`
**Soft-gates:**
- ≥40 → green (proceed to survey design)
- 15-39 → yellow ("Knapp unter der idealen Schwelle. Survey-Ergebnisse
  werden noisy. Trotzdem starten oder erst auf 40+ engaged users warten?")
- 1-14 → red ("Mit so wenig engaged users macht Sean Ellis Test wenig
  Sinn — geh erst zurück in die Engagement-Loop. Ausnahme:
  high-touch-B2B mit <10 Kunden → wir machen Persona-Interviews statt
  Survey.")

---

## Q3 — Can you contact your engaged users? (Email/in-app/push/etc.)

**Type:** enum
**Valid answers:** `Email` | `In-App` | `Push` | `WhatsApp` | `Manual` | `None`
**Store:** `path_state.survey_infrastructure.contactability_channel`
**Soft-gate:** if `None`, surface: "Wir brauchen einen Kanal um die Survey
zu schicken. Welche Option willst du erst aufbauen — Email-Capture beim
Sign-up, oder ein Manual-Outreach auf bestehende Nutzer?"

---

## Q4 — Existing PMF measurement baseline?

**Type:** boolean + free_text
**Store:**
- `path_state.readiness.has_prior_baseline` (bool)
- `path_state.readiness.prior_baseline_notes` (string — only if true)
**Parser hints:**
- "Ja, wir haben Sean Ellis schon mal gemessen / die Quote war X%" → bool=true, notes capture details
- "Nein" / "noch nie" → bool=false, notes=null

If a prior baseline exists, the agent uses it as a sanity check during
the first new measurement.
