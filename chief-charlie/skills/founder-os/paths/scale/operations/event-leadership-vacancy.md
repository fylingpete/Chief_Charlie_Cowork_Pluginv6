# Event — Leadership Vacancy

## Trigger

Any one of these:

- An Accountability Chart™ seat has been open > 30 days
- A leader resigned and seat is currently unfilled with no documented
  90-day-plan for backfill
- An L10™ has missed > 2 weeks because Integrator-Seat is functionally
   vacant (founder still routing)
- `path_state.events.leadership_vacancy.last_fired_at` is NULL OR
   ≥ 30 days ago (throttle per seat)

## Pre-flight

Read from `dashboard_data.json`:
- `path_state.events.leadership_vacancy` — last-fired metadata, last-seat
- `path_state.roadmap.currentSubphase`

Read from templates:
- `accountability-chart.md` — seat-by-seat status, days-open per seat
- `people-analyzer.md` — GWC™ scores for any candidates already named
- `exec-90-day-plan.md` instances — backfill plans in progress

Read from logs:
- Last 4 `weekly_checkin_log.template.jsonl` — IDS™ items mentioning
   open seat
- Last 1 `monthly_review_log.template.jsonl` — Section 2.2e (Hiring +
   Exec-Plan Status)

## Action

### Step 1 — Notify the founder plainly

> "Signal: {{seat_name}} ist {{days_open}} Tage offen. Skok ist
> explizit: in Phase 10 ist Hiring-Velocity der neue Rate-Limiter.
> Jeder zusätzliche Tag mit offenem Seat ist zusätzlicher routing-load
> auf den Integrator — und in vielen Fällen route über den Founder."

### Step 2 — Diagnose: why open?

Walk through the failure modes:

- **No spec written:** is there a written ideal-candidate profile mit
   5 Major Roles + GWC™-Profil?
- **No recruiter capacity:** founder-led recruiting at this stage
   fails. In-house recruiter oder high-trust external partner aktiv?
- **Wrong profile being sourced:** "Next 18 months, not next 5 years"
   — match team-size INTO TRITT, not aspirational?
- **Top AE being promoted to manage (the typical mistake):** AE's
   coaching-skills unproven, AE-seat would go empty.
- **Hiring for "spike" missed:** specific work the new person will
   repeat — vs generic "manage the function"?

### Step 3 — Decision Path

**(A) Activate Recruiter / External Partner**

- Hire in-house recruiter ODER engage external retained partner.
- Written Ideal-Candidate-Profile pro Seat (5 Major Roles + GWC™ Y/N
   per dimension).
- Recruiter-Briefing + Search-Process documented.

**(B) Bridge with Interim**

- Identify Interim — fractional Exec, Advisor, oder Promoted-from-
   within mit explicit "Interim until candidate hired" framing.
- Document Interim Plan + Sunset-Date (30-90 Tage).
- Founder NICHT als Interim — das verfestigt das Bottleneck-Pattern.

**(C) Rescope the Seat**

- Wenn Seat nicht hire-able as-defined: rebuild Acc-Chart-Seat-Spec.
- Wickman: function before person. Wenn 5 Major Roles zu breit, split.
- Update `accountability-chart.md` mit revidiertem Seat-Design.

**(D) Promote with Mentorship**

- Internal Candidate identifiziert.
- GWC™ Y/N/Y konfiguration (Get-it + Want-it ja, Capacity in 2 von 5
   Major Roles). Mentorship + Coaching plan over 90 Tage.
- Voraussetzung: Three-Strike-Rule wenn Capacity nicht aufholt.
- 90-Day-Plan (exec-90-day-plan.md) signed mit klaren Milestones.

### Step 4 — Execute the chosen decision

#### If A (Recruiter):
- Document in `path_state.warnings`: `{"type": "recruiter_engaged", "seat": "...", "started": "today"}`
- Update Acc-Chart-Seat status mit `recruiter_active: yes`
- Founder hands off direct-sourcing; reviews shortlist weekly.

#### If B (Interim):
- Document `interim_plan: {name, sunset_date, decision_authority_limits}`
- Append `weekly_checkin_log` mit `{type: "interim_assigned"}`
- L10™ resumes with Interim sitting in the Seat.

#### If C (Rescope):
- Rewrite Seat 5 Major Roles in `accountability-chart.md`
- Re-review with Leadership in next L10™
- Search reset mit new spec.

#### If D (Internal Promotion):
- Open new `exec-90-day-plan.md` instance for the internal candidate
- People Analyzer™ score documented (Core Values + GWC™)
- Mentor named (typically Integrator oder peer-Function-Head)

### Step 5 — Update path_state

```json
{
  "events": {
    "leadership_vacancy": {
      "last_fired_at": "today",
      "last_seat_days_open": "...",
      "last_seat_name": "...",
      "decision_taken": "A / B / C / D"
    }
  }
}
```

Append `decisions_learnings.jsonl`:

```jsonl
{"type":"decision","date":"YYYY-MM-DD","domain":"org","reasoning":"Leadership vacancy {seat} ({days_open}d open): chose {A/B/C/D} — {1-sentence}"}
```

## Anti-pattern check

Before routing:

- **Open < 14 days:** that's normal hire-time, not vacancy. Skip.
- **Founder convinced "I can cover for a while":** that's THE
   pattern Phase 3.2 is built to break. Force the conversation.
- **Promoting top AE to manage pod 2 (parallel mistake):** if
   considered, surface Schatz-Rule explicitly + propose external hire.

## Connection to other operations

- Detected by `monthly-review.md` Section 2.2e
- Detected by `weekly-checkin.md` Q6 (Step 3.2)
- Detected by `quarterly-rebuild.md` Section 4 (Accountability Chart Refresh)
- Triggers downstream: `exec-90-day-plan.md` instance creation

## Rules

- **30+ days open triggers.** Earlier is normal Search-Window.
- **Founder NICHT als Interim** — das verfestigt das Bottleneck.
- **Throttle 30 Tage per Seat** — same Seat fires nicht repeat innerhalb
   30 Tage, aber andere Seats fire eigene Events.
- **Documented Decision** A/B/C/D with rationale.
- **GWC™ binär applied** wenn intern promoted — kein Capacity-Y wenn
   gap > 2 Major Roles.

## Related files

- `accountability-chart.md` — Seat-Definitionen + open-Days
- `exec-90-day-plan.md` — 90-Day Backfill Plan
- `people-analyzer.md` — GWC™ + Core Values for candidates
- `knowledge/scale/scale-org-and-processes.md` — 3.2 doctrine
- `knowledge/scale/wickman/wickman-accountability-chart.md` — Function-First Discipline
- `knowledge/scale/wickman/wickman-gwc.md` — GWC™ binary
- `knowledge/scale/yc/yc-hiring-executives.md` — YC Exec-Hire-Doctrine
- `knowledge/scale/matrix/schatz-vp-sales-org-design.md` — 7-Reps-Manager-Cap context
