# GTM Path

Goal: build a repeatable, scalable, profitable acquisition motion.
Path entered after PMF (Sean Ellis Score ≥ 40%); exited when all three
Skok Phase 8 gates pass (LTGP:CAC > 3, CAC payback < 18 months, gross
margin > 70%).

## Phase 2 — Search for Go-to-Market Fit

5 sequential steps from validated PMF to Phase 3 readiness:

1. **Find a repeatable sales motion** — One ICP, one use case, one
   channel (Hormozi Core Four), one core message, one sales motion.
   Founder-led, 50-150 buyer-conversations (Kazanjy). Exit: Sales
   playbook a stranger could execute, with ≥2 wins via the same
   playbook.
2. **Prove non-founders can sell** — Hire 2 ordinary reps in cohort
   (trailblazer + grinder). Build full playbook (objection map, demo
   script, coaching cadence). Exit: ≥1 of 2 reps at >4× OTE
   productivity post-ramp, customers as happy as founder-led deals,
   founder off closing-seat ≥30 days.
3. **Make growth scalable** — Layered lead sources (≥2 channels >20%
   share), bookings math (#Reps × PPR), first marketing-gen hire,
   cohort-based marketing-sales contract, pod model (SDR+AE+CSM).
   Exit: ≥2 lead sources contributing, ≥2 pods at quota for 2 quarters,
   no single-channel-dependence.
4. **Ensure customers succeed** — Activation metric defined and
   predictive (cohort-validated), Time-to-Wow under target band,
   onboarding flow engineered around activation, pricing axes for
   Negative Churn. Exit: Logo retention >85% at 12 months, NDR >100%
   or path to it.
5. **Make it profitable** — All three gates: LTGP:CAC > 3, CAC payback
   < 18 months, gross margin > 70%. Channel-level economics monthly,
   cash-trough modeled. Exit: All three gates passing for ≥2
   consecutive monthly reviews + Rule of 40 ≥ 40.

Sub-phases gate progression. Don't skip ahead — Skok: scaling sales
before non-founders can sell, or layering channels before the first
saturates, or hitting the gas before unit economics are proven, are
the most expensive mistakes in the entire roadmap.

## Operations

- `operations/weekly-checkin-review.md` — 5 min, weekly (step-aware Q6)
- `operations/monthly-review.md` — 60 min, monthly (step-aware metrics)
- `operations/quarterly-rebuild.md` — 3-4h, quarterly (step-filtered sections)
- `operations/call-debrief.md` — after each sales call
- `operations/playbook-update.md` — incremental refinement of any template section
- `operations/learning-documentation.md` — ad-hoc quick capture
- `operations/icp-adjustment.md` — full ICP hypothesis change (cascades)
- `operations/messaging-adjustment.md` — full messaging hypothesis change (cascades)
- `operations/phase-change.md` — sub-phase advance (re-runs auto-fill recipe)
- `operations/project-close.md` — when project complete
- `operations/event-2.5-milestone.md` — triggered when all 3 Phase 8 gates pass
- `operations/event-channel-failed.md` — triggered on channel kill criteria hit
- `operations/event-conversion-drop.md` — triggered on >30% funnel-stage drop
- `operations/event-churn-spike.md` — triggered on retention/NDR drop

## Structured deliverables (templates/)

Each step produces structured, version-locked deliverables:

- **2.1**: `icp-doc.md`, `messaging-doc.md`, `channel-test.md`, `sales-playbook.md` (v1)
- **2.2**: `sales-playbook.md` (v1.5 rep-ready), `objection-map.md`
- **2.3**: `bookings-plan.md`, `marketing-sales-contract.md`
- **2.4**: `activation-metric-doc.md`, `onboarding-flow.md`
- **2.5**: `unit-economics-model.md`

Each template has frontmatter (status, version, source), substance
rubric (rules), contamination check, version history, and cross-references
to relevant knowledge files.

## Living documents

- `icp_playbook.md` — append-only notebook, raw observations across
  ICP hypotheses
- `messaging_playbook.md` — append-only notebook, raw observations
  across messaging hypotheses

These complement (do NOT replace) the structured templates:
- Structured templates = lock-versioned deliverables (v1-draft → v1-locked)
- Living docs = append-only notebooks for raw evidence

## Streams owned by this path

- `weekly_checkin_log.jsonl` — append on every weekly check-in
- `monthly_review_log.jsonl` — append after each Monthly Review
- `quarterly_rebuild_log.jsonl` — append after each Quarterly Rebuild
- `decisions_learnings.jsonl` — append on every decision/learning capture
- `churn_reason_log.jsonl` — append on every churn event (Step 2.4 onwards)

## Knowledge

Top-level synthesis files (one per step):

- `knowledge/gtm/repeatable-sales-motion.md` — Step 2.1 doctrine
- `knowledge/gtm/founder-to-rep-handoff.md` — Step 2.2 doctrine
- `knowledge/gtm/scale-demand-and-sales.md` — Step 2.3 doctrine
- `knowledge/gtm/activation-and-retention.md` — Step 2.4 doctrine
- `knowledge/gtm/unit-economics.md` — Step 2.5 doctrine

Author-curated source files:

- `knowledge/gtm/matrix/` — Skok / Kazanjy / Schatz / Gally (Matrix
  Partners "Zero to 100")
- `knowledge/gtm/yc/` — Y Combinator
- `knowledge/gtm/hormozi/` — Alex Hormozi

## Channel-aware Source Selection

In Step 2.1, the 4 source pills shown in the Roadmap-Tab are
personalized based on `path_state.current_best_channel` from
onboarding Q10. Default is Skok / Hormozi / YC / Kazanjy; slot 4 is
swapped for a channel-specific source (e.g. `yc-cold-email-tactics`
for Cold Email, `hormozi-ad-anatomy` for Paid Ads). See
`templates/auto_fill_recipe.md` for the swap table.

## Switch out

When `path_state.kpis.rows` for Step 2.5 show all three gates passing
(LTGP:CAC > 3, CAC payback < 18 months, gross margin > 70%) for ≥2
consecutive monthly reviews, `event-2.5-milestone.md` fires and
proposes the Scale path switch. Actual path-switch flow handed to
master `SKILL.md` "Path Switch" section. See `paths/scale/path.md`
(currently skeleton).
