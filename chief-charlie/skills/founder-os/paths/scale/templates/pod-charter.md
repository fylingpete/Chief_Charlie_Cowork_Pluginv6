---
deliverable_type: pod-charter
status: empty_template
team_required: false
source: matrix_partners_schatz
last_updated: null
version: v1-draft
---

# Pod Charter

> **Status:** empty_template — eine Instanz pro Pod, gelockt wenn Pod 2 Quartale bei Quota mit allen sechs Attributes stable
> **Team-required:** no (Sales-Leader oder VP Sales-driven, ein Charter pro Pod)
> **Source:** Schatz (Matrix) — Pod-Replication als atomic unit of sales output

> **STRICT SIX-ATTRIBUTES-LOCKED.** Composition, ICP, Quota, Lead-Mix,
> Coaching-Cadence, Reporting — alle sechs explicit, ein Charter pro
> Pod, sonst ist Performance-Varianz zwischen Pods uninterpretable.
> Adding a half-pod (AE ohne SDR, SDR ohne AE) bricht die Math UND die
> Coaching-Capacity. Pod #N+1 wird erst gestartet wenn Pod #N capacity-
> util > 70% UND win-rate ≥ 80% Baseline für ≥ 4 Wochen.

## How to use this file

Pods sind atomic. Sobald der erste Pod predictable Bookings produziert,
wird Scaling die Frage "wie viele Pods, wie schnell". Jeder neue Pod
bekommt SEIN eigenes Charter — gleicher Template, frische Zahlen.

Pod-Cloning-Rule: capacity-util > 70% UND pod-win-rate ≥ 80% baseline,
beide sustained ≥ 4 Wochen, BEVOR pod #N+1 hire startet. Hiring lead-
time ist 4-6 Monate; früher starten ist verfrüht, später ist verspätet.

## Rules (from the substance rubric)

- **six_attributes_locked (non-negotiable):** Composition, ICP, Quota,
  Lead-Mix, Coaching-Cadence, Reporting — alle sechs sind explizit
  dokumentiert beim Pod-Start. Nicht später, nicht "decided as we go".
- **pod_composition_strict:** 1 SDR + 1 AE + 0.25 CSM. NICHT 2 AEs
  share 1 SDR. NICHT solo AE. Pod-Integrität ist die Discipline.
- **same_icp_as_validated_motion:** Pod #2 verkauft an dieselbe ICP wie
  Pod #1 — kein "let's try a new segment with the new pod". Neues
  Segment = neuer Sales-Motion = neues Validierungs-Problem.
- **clone_when_signal_dual:** Capacity-util > 70% UND win-rate ≥ 80%
  baseline, beide ≥ 4 Wochen, BEVOR nächster Pod startet.
- **seven_rep_manager_cap:** Pod-Wachstum pro Manager ≤ 7 Reps. 8. Rep
  triggert zweiten Manager (extern hiren, NICHT Top-AE promoten).
- **pod_health_weekly:** Cap-Util, Win-Rate, Pod-Bookings, SDR-AE-Conv
  werden weekly im L10™ als Scorecard-Numbers reviewed.

---

## Pod-Identifikation

- **pod_id:** <!-- e.g. "Pod-2" -->
- **created_at:** <!-- date -->
- **manager:** <!-- name -->
- **previous_pod_signal:** <!-- "Pod-1 cap-util 76%, win-rate 84% baseline, 5 Wochen sustained" -->

## Attribut 1 — Composition

<!-- INSTRUCTION: 1 SDR + 1 AE + 0.25 CSM. Wenn shared CSM: nennen welche anderen Pods er bedient. -->

- **sdr_name:**
- **ae_name:**
- **csm_name (0.25 FTE):** <!-- shared with which other pods? -->
- **expected_full_ramp_date:** <!-- m6 from hire date -->

## Attribut 2 — ICP

<!-- INSTRUCTION: SAME als validated motion. Verweis auf gtm/icp-doc.md oder scale-internal ICP. -->

- **icp_doc_reference:** <!-- path zu icp-doc.md oder Inline-Snapshot -->
- **target_market:**
- **buyer_persona:**
- **disqualifiers:**

## Attribut 3 — Quota

<!-- INSTRUCTION: AE-Quota = 4-6× OTE (Skok). Klar dokumentieren. -->

- **ae_ote:** <!-- z.B. $180K -->
- **ae_annual_quota:** <!-- z.B. $900K (5× OTE) -->
- **ae_quarterly_targets:** <!-- Q1/Q2/Q3/Q4 break-up -->
- **sdr_quota_qualified_opps_per_month:** <!-- z.B. 15-20 -->

## Attribut 4 — Lead-Mix

<!-- INSTRUCTION: % inbound vs % outbound vs % partner — exact agreement at pod start. -->

- **inbound_percentage:**
- **outbound_percentage:**
- **partner_percentage:**
- **source_channels_inbound:** <!-- e.g. paid search, content -->
- **source_channels_outbound:** <!-- e.g. cold email, LinkedIn -->

## Attribut 5 — Coaching-Cadence

<!-- INSTRUCTION: Schatz Black Sheet — weekly 1:1 + monthly call-review. First 90 Tage non-negotiable. -->

- **manager_one_on_one_day:** <!-- z.B. "Mittwochs 10:00" -->
- **call_review_rubric:** <!-- which rubric (Schatz Black Sheet / custom) -->
- **call_review_cadence:** <!-- "1 recording pro Rep pro Woche" -->
- **demo_certification_required:** <!-- yes/no — bevor solo demos -->

## Attribut 6 — Reporting

<!-- INSTRUCTION: Pod-Level KPIs visible to manager weekly. Welche Numbers, an wen, wann. -->

- **kpis_tracked:**
  - Capacity Utilization
  - Pod Win Rate
  - Pod Bookings (% of quota attainment)
  - SDR-AE Conversion Rate
- **reporting_cadence:** <!-- "Mondays 9:00 — Pod-Manager + VP Sales" -->
- **scorecard_owner:** <!-- name (typically pod manager) -->

---

## Pod-Health KPIs (live)

| KPI | Definition | Current | Target | Status |
|---|---|---|---|---|
| Capacity Utilization | (opps AE actively works) ÷ (capacity at full lead-flow) |   | 70-95% | red/amber/green |
| Pod Win Rate | closed-won ÷ qualified-opps |   | ≥ 80% baseline (Pod-1) | red/amber/green |
| Pod Bookings | AE quota attainment |   | 100% quarterly |   |
| SDR-AE Conversion | qualified-opps SDR → accepted by AE |   | ≥ 70% |   |

## Ramp-Status

<!-- INSTRUCTION: Reps zu m3 zählen als 0.4, m6 als 0.7, m9+ als 1.0 (Skok). Update monatlich. -->

- **months_since_hire_ae:**
- **ramp_factor:** <!-- 0.4 / 0.7 / 1.0 -->
- **months_since_hire_sdr:**
- **ramp_factor_sdr:**

## Clone-Decision-Log

<!-- INSTRUCTION: Pod #N+1 startet erst wenn Pod #N beide Signals ≥ 4 Wochen hat. Decision dokumentieren. -->

- **next_pod_signal_met:** <!-- yes/no -->
- **cap_util_4wk_avg:**
- **win_rate_4wk_avg:**
- **next_pod_hiring_start_date:** <!-- 4-6 Mo vor benötigtem Productivity-Date -->

---

## Contamination Check

<!-- INSTRUCTION: Self-audit before locking pod as "stable". -->

- Alle 6 Attributes explizit dokumentiert: <!-- yes/no -->
- Pod-Composition: 1 SDR + 1 AE + 0.25 CSM (keine Half-Pods): <!-- yes/no -->
- ICP matched validated motion (kein neues Segment): <!-- yes/no -->
- AE-Quota = 4-6× OTE: <!-- yes/no -->
- Coaching-Cadence aktiv (≥ 1 1:1/Woche + ≥ 1 Call-Review/Woche): <!-- yes/no -->
- Pod-Level KPIs werden wöchentlich reviewed: <!-- yes/no -->
- Pod-Cloning-Rule respektiert (kein vorzeitiger Hire): <!-- yes/no -->

---

## Version History

| Version | Status | Date | Change summary |
|---|---|---|---|
| v1-draft | draft | | Pod created, attributes set |
| v1-locked | locked | | Pod 2 Quartale bei Quota, attributes stable |
| | | | |

## Related files

- `knowledge/scale/hit-the-gas.md` — Step 3.1 doctrine
- `knowledge/scale/matrix/schatz-pod-pod-pod-scaling.md` — Pod-Definition
- `knowledge/scale/matrix/schatz-vp-sales-org-design.md` — VP Sales role
- `three-gate-dashboard.md` — Gates that license adding pods
- `cash-trough-model.md` — Hiring sequenz feeds bookings math
