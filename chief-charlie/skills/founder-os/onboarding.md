# Founder-OS Onboarding

Four questions → first roadmap shown in the canvas → more questions to
refine it. Path routing (PMF / GTM / Scale) happens early to drive the
first-version roadmap.

**Language:** the canonical wording in `assessment/onboarding-questions.md`
is English. Translate it to the user's language at runtime — preserve
meaning and tone, do NOT add decorative emojis. The only emoji used in
the onboarding chat is the agent's identity emoji in the opening
greeting.

## Opening — Greeting (before Question 1)

Send the greeting from `assessment/onboarding-questions.md` § Opening.
This frames who Charlie is (Founder Harness, not assistant) before any
question is asked. Substitute `{user_first_name}` from the user
profile and the agent's emoji from IDENTITY.md.

## Questions 1-4 — First Pass (drives the first-version roadmap)

Read the full canonical wording, options, examples, and parser hints
for each question from `assessment/onboarding-questions.md`. Ask one
at a time. Translate the wording, explainers and options to the user's
language. Present them in full — the explainers and option subtitles
are part of the substance, not optional flavor.

Storage targets:

| Q | Store path | Type |
|---|---|---|
| Question 1 — What are you building? | `business_profile.build_type` | enum |
| Question 2 — Who do you sell to? | `business_profile.buyer` | enum |
| Question 3 — Where do you stand? | `business_profile.stage` | enum (drives path routing) |
| Question 3a — Where exactly on the PMF path? *(only if Q3 = Product-Market Fit, MANDATORY when triggered — keep asking until one of the 4 enum values is given)* | `business_profile.pmf_substage` | enum |
| Question 3b — Where exactly on the GTM path? *(only if Q3 = GTM, MANDATORY when triggered — keep asking until one of the 5 enum values is given)* | `business_profile.gtm_substage` | enum |
| Question 4 — What industry do your customers work in? | `business_profile.industry` | enum_with_other |
| Question 5 — What exactly are you building, and for whom? | `business_profile.product_description` + `.problem_solved` + `.customer_description` + `.elevator_pitch` (verbatim) | free_text (3 parts) |
| Question 6 — Tell me how it's going right now. | `focus.today` (verbatim) + parsed `focus.revenue_today` / `.team_size_today` / `.status_one_liner` if extractable | free_text |

After Question 1, set `path_state.current_step = "onboarding-q2"` and
increment per question (`onboarding-q3`, `onboarding-q3a` if PMF,
`onboarding-q3b` if GTM, `onboarding-q4`, `onboarding-first-roadmap`,
`onboarding-q5`, `onboarding-q6`, `onboarding-q7`, `onboarding-q8`,
`onboarding-q9`, then `onboarding-q9-done` once the step-specific
debrief (and any adaptive follow-up) is complete). After Auto-Fill
runs, advance to `onboarding-project-selection` for Step E, then
`onboarding-closing` while the Closing-Flow runs, and finally
`operating` once the Closing-Flow finalizes.

**Question 3a is mandatory when Q3 == Product-Market Fit.** If the user
replies with "I don't know" / "doesn't matter" / refuses to choose,
re-ask once with a brief clarification of the four options. If they
still won't pick, default to `idea_only` and tell them they can change
it later.

**Question 3b is mandatory when Q3 == GTM.** If the user replies with
"I don't know" / "doesn't matter" / refuses to choose, re-ask once with
a brief clarification of the five options. If they still won't pick,
default to `repeatable_motion` (Step 2.1) and tell them they can change
it later.

## ⛔ HARD STOP after Question 4 — DO NOT continue to Q5

**Right after the user answers Q4 (industry), you MUST run the entire
"First Roadmap Setup" section below before asking any further
question.** This is the single most important UX moment of the
onboarding — the user sees their roadmap appear in the canvas after
just 4 questions. Skipping this in favor of asking Q5 first BREAKS the
wow-moment.

Concretely, after Q4 you MUST:

1. NOT ask Q5 yet.
2. Run Step A1 (`copy_skill_files` for the two data files —
   `roadmap_data.json` + `dashboard_data.json`).
3. Run Step B-early (small `file_edit`s to personalize Q1-Q4 fields,
   substage routing, and the badge in `dashboard_data.json`).
4. Run Step A2 (`copy_skill_files` for the 5 pill files, with
   `roadmap.json` FIRST — this is the trigger that opens the canvas
   tab, and by now the data files are fully personalized).
5. Run Step C: `file_read` on `roadmap_data.json` to pull the active
   step's `whyThisStep`, `mainGoal`, and `sources`, then send the
   structured intro message that introduces the user's current step
   and the experts behind the playbook.
6. THEN proceed to Q5 and Q6.
7. After Q5/Q6, run Step B-late (the remaining `file_edit`s for the
   Q5/Q6 fields and the `focus.today` block).

If you find yourself thinking "let me just collect Q5+Q6 first and
then do everything in one batch" — STOP. That's wrong. The hard rule
is: **4 questions → roadmap visible → continue.** Not 6 questions
and then a roadmap.

## Path Routing (decided after Question 3 / Question 3a / Question 3b)

1. Hard rule from Q3: Product-Market Fit → pmf, GTM → gtm, Scale → scale.
2. Sanity check Q1-Q2 for contradictions. If found, ask ONE clarifying question.
3. Path is committed to `dashboard_data.json` in the **First Roadmap Setup**
   step below — do NOT write to disk before then. Hold answers in
   conversation context until then.

## First Roadmap Setup (after Q4 — the wow moment)

This is the user-visible payoff of Q1-Q4: a personalized roadmap appears
in the canvas. Four substeps, **strictly in order**:

```
Step A1 (data files)  →  Step B-early (personalize)  →  Step A2 (pills, roadmap.json FIRST)  →  Step C (user message)
```

The frontend auto-opens the roadmap canvas tab the moment
`roadmap.json` first appears in the workspace. The order above
guarantees that when the tab opens, the user immediately sees their
**personalized** roadmap (Q1-Q4 fields, correct substage, badge) — not
the unedited seed.

### Step A1 — Write the two data files first via `copy_skill_files`

These two files contain ALL the roadmap content the canvas will read.
Write them BEFORE any pills, and BEFORE any `file_edit`s.

**Important — two different seeds:**

- `roadmap_data.json` is seeded from the **merged all-phases seed**
  (`templates/roadmap_data.seed.json`) — path-independent, carries ALL
  14 steps (1.1–1.5 ∪ 2.1–2.5 ∪ 3.1–3.4) verbatim. No onboarding step
  edits its content; the active step is lazy-personalized later, only
  when the user actually works on the roadmap (see SKILL.md). This is
  what lets the roadmap canvas render full detail tabs for every step
  regardless of the user's active path.
- `dashboard_data.json` is seeded from the **path-specific seed**
  (`paths/<current_path>/templates/dashboard_data.seed.json`) which
  ALREADY contains the FULL roadmap tree (`phases` + `currentSubphase`
  + `here:true` on the path-default starting sub) and the correct
  `current_path` value.

```
copy_skill_files(files=[
  {"source":"project/founder-os/templates/roadmap_data.seed.json",                        "target":"01_Command_Center/Dashboards/roadmap_data.json"},
  {"source":"project/founder-os/paths/<current_path>/templates/dashboard_data.seed.json", "target":"01_Command_Center/Dashboards/dashboard_data.json"}
])
```

Replace `<current_path>` with `pmf`, `gtm`, or `scale` based on the
routing decision — this applies to the `dashboard_data.json` source
only; the `roadmap_data.json` source is the fixed merged seed and
takes no `<current_path>` substitution. After this call, no pills
exist yet — the canvas shows nothing new. That's intentional.

### Step B-early — Personalize the data files BEFORE writing any pills

Run all of these `file_edit`s on
`01_Command_Center/Dashboards/dashboard_data.json` BEFORE Step A2.
Small `file_edit`s are reliable; large ones have failed in the past.

**Group 1 — business_profile (Q1-Q4 only):**

Edit `"build_type": null` → `"build_type": "<Q1>"` (Software / Service /
E-Com / Content). Then `"buyer": null` → `"buyer": "<Q2>"` (B2B / B2C).
Then `"stage": null` → `"stage": "<Q3>"`. If PMF, also
`"pmf_substage": null` → `"pmf_substage": "<Q3a value>"`. If GTM, also
`"gtm_substage": null` → `"gtm_substage": "<Q3b value>"`. Then
`"industry": null` → `"industry": "<Q4>"`.

Leave `product_description`, `problem_solved`, `customer_description`,
`elevator_pitch` as `null` — those come from Q5 in Step B-late.

You can do this as one `file_edit` by replacing the relevant subset of
`business_profile` — keep the still-`null` fields untouched.

**Group 2 — Q3a substage routing** (only if PMF and Q3a != idea_only):

The PMF seed has `currentSubphase: "1.1"` and `here:true` on `subs[0]`
by default. If Q3a routes elsewhere, do TWO file_edits:
- One to flip `"here": true` → `"here": false` on the old `subs[0]`
- One to flip `"here": false` (or add the field) → `"here": true` on
  the new sub
- One to update `"currentSubphase": "1.1"` → the new id

Routing table:
- `idea_only` → no change (default already correct)
- `mvp_built` → `currentSubphase: "1.3"`, `here:true` on `subs[2]`
- `engaged_users` → `currentSubphase: "1.4"`, `here:true` on `subs[3]`
- `survey_running` → `currentSubphase: "1.5"`, `here:true` on `subs[4]`

INVARIANT: exactly ONE sub has `here:true` after these edits. The seed
guarantees the start state is consistent — only flip what you need.

**Group 2b — Q3b substage routing** (only if GTM and Q3b != repeatable_motion):

The GTM seed has `currentSubphase: "2.1"` and `here:true` on `subs[0]`
by default. If Q3b routes elsewhere, do TWO file_edits:
- One to flip `"here": true` → `"here": false` on the old `subs[0]`
- One to flip `"here": false` (or add the field) → `"here": true` on
  the new sub
- One to update `"currentSubphase": "2.1"` → the new id

Routing table:
- `repeatable_motion` → no change (default already correct)
- `non_founder_sales` → `currentSubphase: "2.2"`, `here:true` on `subs[1]`
- `scalable` → `currentSubphase: "2.3"`, `here:true` on `subs[2]`
- `customer_success` → `currentSubphase: "2.4"`, `here:true` on `subs[3]`
- `profitable` → `currentSubphase: "2.5"`, `here:true` on `subs[4]`

INVARIANT: exactly ONE sub has `here:true` after these edits.

**Group 3 — badge** (the "First version" pill on the roadmap header):

Replace `"badge": null` → `"badge": {"title": "First version", "subtitle": "Based on your answers so far"}`.

### Step A2 — Write the canvas pills, with `roadmap.json` FIRST

Only after Step B-early has finished do you write the pill files.
**`roadmap.json` MUST be the first entry** — the frontend triggers the
canvas auto-open on its appearance, and at this point all the backing
data is already personalized on disk.

```
copy_skill_files(files=[
  {"source":"project/founder-os/templates/workspace_skeleton/dashboards/roadmap.json",    "target":"01_Command_Center/Dashboards/roadmap.json"},
  {"source":"project/founder-os/templates/workspace_skeleton/dashboards/home.json",       "target":"01_Command_Center/Dashboards/home.json"},
  {"source":"project/founder-os/templates/workspace_skeleton/dashboards/projects.json",   "target":"01_Command_Center/Dashboards/projects.json"},
  {"source":"project/founder-os/templates/workspace_skeleton/dashboards/tasks.json",      "target":"01_Command_Center/Dashboards/tasks.json"},
  {"source":"project/founder-os/templates/workspace_skeleton/dashboards/kpis.json",       "target":"01_Command_Center/Dashboards/kpis.json"}
])
```

The ordering matters: pills appear in the canvas toolbar in file-creation
order. The pill bar order is: Roadmap, Home, Projekte, Tasks, KPIs.
`tasks.json` MUST be placed between `projects.json` and `kpis.json` so
Tasks surfaces between project-level and metric-level pills.

Do NOT change the ordering. Do NOT merge Step A1 and Step A2 into a
single call — the personalize edits between them are the whole point.

### Step C — Present the first step of the roadmap (trust-building moment)

After Step A2 returns successfully, the canvas auto-opens the roadmap
on its own. Now you (the agent) introduce **the user's current step**
in the chat — not the whole roadmap. This is the trust-building
moment: the user sees that you know exactly where they are, why this
step matters, what the goal is, and which experts the playbook is
based on.

**Step C.1 — Read the active step's content from the roadmap data file.**

Use the `file_read` tool to load
`01_Command_Center/Dashboards/roadmap_data.json`. The active step ID
is the `currentSubphase` you set in Step B-early Group 2 (e.g. `"1.1"`,
`"1.3"`, `"1.4"`, or `"1.5"` for PMF, or the path-specific default for
GTM/Scale). From `roadmap_data.json`, pull `steps["<currentSubphase>"]`
and read:
- `overview.whyThisStep` — the rationale
- `overview.mainGoal` — what "done" looks like
- `sources` — the experts/playbooks that back this step

**Do NOT generate this content yourself. Quote the file.** The user
will see the SAME text in the canvas — your chat message must match,
or trust evaporates.

**Step C.2 — Send a structured intro message in the user's language.**

Format the message in three short sections (translate the section
headers to the user's language; the substance comes from the file):

> **Your first roadmap is ready** — you can see it on the right.
>
> I built this first version based on your answers so far.
> Where you are right now: **<currentSubphase> — <step title>**.
>
> **Why this step**
> <quote `overview.whyThisStep` verbatim>
>
> **Goal of this step**
> <quote `overview.mainGoal` verbatim>
>
> **What this is based on**
> The playbook for this step pulls from:
> – <source[0].name> · <source[0].subtitle>
> – <source[1].name> · <source[1].subtitle>
> – <source[2].name> · <source[2].subtitle>
> – <source[3].name> · <source[3].subtitle>
> (list ALL sources from the file — typically 4-5 — in the order they
> appear; do NOT invent or omit)
>
> As you progress through the roadmap, the playbooks shift with each
> phase — I'll bring in the right experts for whatever step you're on.
>
> Next, I'll ask a few more questions to customize this further.

**Substance rules:**
- The `whyThisStep`, `mainGoal`, and `sources` text MUST come from
  `roadmap_data.json` — never paraphrase, never invent.
- Translate ONLY the section headers ("Why this step", "Goal of this
  step", "What this is based on", "As you progress…", "Next, I'll
  ask…") to the user's language. The quoted content is already in
  German in the file — keep it as-is for German users; for other
  languages, translate it carefully without losing precision.
- Do NOT summarize the sources. The user sees the same source cards in
  the canvas — listing them in chat builds the bridge.

After the message, pause for the user to read and look at the canvas.
Then continue with Q5.

### Step B-late — Personalize Q5/Q6 fields AFTER Q5 and Q6 are answered

After the user has answered Q5 and Q6 (continue from Step C → Q5 → Q6),
write the remaining user-specific fields. Small `file_edit`s on
`01_Command_Center/Dashboards/dashboard_data.json`:

**Group 4 — business_profile (Q5 fields):**

Replace
`"product_description": null` → `"product_description": "<Q5 parsed: what>"`,
`"problem_solved": null` → `"problem_solved": "<Q5 parsed: which problem>"`,
`"customer_description": null` → `"customer_description": "<Q5 parsed: who buys>"`,
`"elevator_pitch": null` → `"elevator_pitch": "<Q5 verbatim full answer>"`.

**Group 5 — focus (Q6):**

Replace `"today": null` → `"today": "<Q6 verbatim>"`. Then if
extractable, `"revenue_today": null`, `"team_size_today": null`,
`"status_one_liner": null`. Leave `goal_12m`, `milestone_90d`,
`bottleneck` as null — those are Q7/Q8.

**Q5/Q6 fields you just wrote are reused later in:**
- The personalized markdown file (Step D — `@FOUNDER_HARNESS.md`) —
  pulls `product_description`, `customer_description`,
  `status_one_liner` into the canonical text.
- PMF Auto-Fill (`paths/pmf/templates/auto_fill_recipe.md`) — uses
  `product_description` + `customer_description` for the bottleneck
  match and the Closing-Flow message.
- GTM Q9-Q12 — Q9 (ICP) starts from `customer_description` instead of
  asking blind.

Do NOT discard these fields after onboarding. They are immutable
profile data unless the user explicitly changes them.

### Step D — Customize 3 markdown files via `file_write` (any time after Q8)

These files reflect the user's profile and are written ONCE during
onboarding. Defer them until the post-Q8 stretch (after auto-fill, before
closing) so the wow-moment after Q4 is not delayed by extra writes:

- `00_Configuration/@FOUNDER_HARNESS.md`
- `00_Configuration/@SCHEMA.md`
- `01_Command_Center/@INDEX.md`

Read each from `project/founder-os/templates/workspace_skeleton/<path>` for the
canonical structure, then personalize via `file_write` using the data
already in `dashboard_data.json`. Specifically:

- `@FOUNDER_HARNESS.md` — reference the user's
  `business_profile.elevator_pitch` and `bottleneck.title` so the
  harness rules feel specific to this founder.
- `@SCHEMA.md`, `@INDEX.md` — use canonical structure
  but adapt examples/placeholders to the user's domain
  (`business_profile.industry`, `business_profile.build_type`).

NEVER write generic boilerplate — every file must visibly reflect what
the user told you in Q1-Q8.

## Q7 + Q8 — Refinement Questions

Continue with the universal questions. Each answer is a single
`file_edit` on `01_Command_Center/Dashboards/dashboard_data.json`.

| Q | Store path | Type |
|---|---|---|
| Q7 — Wo willst du hin? | `data.focus.goal_12m` (object) + `data.focus.milestone_90d` (object) — see schema below | two-part structured |
| Q8 — Was hält dich zurück? | `data.focus.bottleneck` + `data.bottleneck.title` | free_text |
| Question 9 — Step-specific debrief | `path_state.step_debrief.raw` + `path_state.step_debrief.parsed` | structured |

**Q7 schema (both `goal_12m` and `milestone_90d` use the same shape):**

```json
{
  "revenue_target": null,           // string, e.g. "€500k ARR" or "<10k MRR" — extracted if mentioned
  "customer_count_target": null,    // number or string range — extracted if mentioned
  "team_size_target": null,         // number — extracted if mentioned
  "qualitative_goals": [],          // array of strings (anything that isn't a number — e.g. "category leader in DACH", "first sales rep hired", "playbook v1 locked")
  "raw_text": null                  // verbatim user input — ALWAYS populated when user answers
}
```

Populate what the user gives, leave the rest at `null` / `[]`. Don't
pressure for numbers if the user didn't offer them — qualitative-only
answers are valid. See full parser hints in
`assessment/onboarding-questions.md` § Question 7.

## Question 9 — Step-specific debrief

After Q8, before Step B-late, fire a debrief question scoped to the user's current step. Read the wording from
`paths/{path}/templates/debrief_questions.json` using the user's `business_profile.gtm_substage` or `.pmf_substage`
(or the scale equivalent) as the key.

Flow (hybrid γ — adaptive follow-up):

1. Ask the `main` question for the user's step. If the step has no entry in `debrief_questions.json` (e.g. Scale path
   with the current stub), fall back to a generic: *"Was hast du in deinem aktuellen Schritt schon konkret probiert?
   Was hat funktioniert, was nicht?"*
2. Receive the answer. Store the verbatim text at `path_state.step_debrief.raw`.
3. Parse the answer (LLM extraction) into:

   ```json
   {
     "tried": [...],
     "worked": [...],
     "failed": [...],
     "scale": "..."
   }
   ```

   Store at `path_state.step_debrief.parsed`.
4. Check each `followup_triggers[*].if_missing` against the parsed fields. If a trigger fires, ask its `ask` text
   **once** (no nested follow-ups — keep onboarding tight). Append the follow-up answer to
   `path_state.step_debrief.raw` and re-parse.
5. Move to Step B-late.

Storage targets:

| Field | Path |
|---|---|
| Verbatim Q9 answer (incl. any follow-up) | `path_state.step_debrief.raw` |
| Parsed structure | `path_state.step_debrief.parsed` |

`path_state.current_step` after Q9: `onboarding-q9-done`.

## PMF Readiness Check (only if `current_path == "pmf"` AND Q3a in {`engaged_users`, `survey_running`})

Run `assessment/pmf-readiness-questions.md` (4 readiness questions).
Skip entirely for Q3a in {`idea_only`, `mvp_built`} — those substages
don't need the survey readiness gate yet.

## Auto-Fill (PMF + GTM, after roadmap seed + path-specific addendum)

When `current_path == "pmf"` or `current_path == "gtm"`, run the
deterministic auto-fill recipe BEFORE Step E (project selection) and
the Reminder Setup step.

1. Read `paths/{current_path}/templates/auto_fill_recipe.md` and follow
   it field-by-field.
2. Inputs: `dashboard_data.json` (already contains Q1-Q12 + readiness
   answers + roadmap with here:true), `paths/{current_path}/roadmap_defaults.json`,
   `paths/{current_path}/templates/kpis_per_step.json`.
3. Outputs (write into `dashboard_data.data.*` in a single update):
   `currentFocus`, `bottleneck`, `oneThing`, `kpis`, `doNotDo.home`.
   **`projects` and `tasks` are written by Step E (after Auto-Fill)** —
   Auto-Fill is the deterministic seed for the non-project fields only.
   If the recipe file still lists project/task field writes, treat
   those as superseded by Step E and skip them here.
4. **Deprecated fields — do NOT write:** `currentPhase`,
   `coreAssumption`, `decision`, `evidence`, and any `data.doNotDo.*`
   bucket other than `home` (only `data.doNotDo.home` is rendered —
   "Don't do yet" on home.json). Older workspaces may have them; leave
   them untouched (passthrough), but never create them anew.
5. Remember the matched bottleneck `category` (Q8 → bottlenecks[*]) for
   the Closing-Flow.

For the Scale path, the auto-fill recipe is not yet defined — keep the
legacy "KPI Initial Rows" behavior below for the non-project fields.
Step E (project selection + tasks) runs regardless of path as long as
`paths/{current_path}/templates/projects_per_step.json` has an entry
for the active step.

### Legacy KPI Initial Rows (GTM + Scale only)

Write 3-4 starter KPI rows to `dashboard_data.data.kpis.rows`. Canonical
field names: `metric`, `current`, `target`, `status`
(`'red' | 'amber' | 'green'`). NEVER use `label` or `value` — the UI
ignores them.

Example for GTM:
```json
{"metric": "Pipeline coverage", "current": "n/a", "target": "3x quota", "status": "red"}
```

## Step E — Project selection + task generation (after Auto-Fill)

After Auto-Fill has written the deterministic fields (`currentFocus`,
`bottleneck`, `oneThing`, `kpis`, `doNotDo.home`), run Step E to
populate `data.projects[]` and `data.tasks[]` interactively. This step
depends on `path_state.step_debrief.parsed` from Q9 — without that
context, the project proposals will be generic.

Set `path_state.current_step = "onboarding-project-selection"` at the
start of this step.

**Inputs:**

- `paths/{current_path}/templates/projects_per_step.json` — looked up
  by `current_step` (sub_id like `"2.1"`). Each step's array carries
  6–8 candidate projects with `title`, `outcome`, `goal`, `why`, and
  `tasks` (2–3 anchor tasks each).
- `business_profile.industry` / `.buyer` / `.product_description` —
  for personalization.
- `path_state.step_debrief.parsed` — informs WHICH 2–3 projects to
  propose as `current`.

**Substep 1 — Charlie picks 2–3 current projects:**

Read all three inputs. Select 2–3 projects whose `outcome` directly
addresses what the user said in their debrief is failing or missing.
Prefer projects that compound (output of one feeds the next). The
remaining projects are `later`.

**Substep 2 — Charlie posts the proposal in chat (German, founder-direct tone):**

```
Basierend auf deinem Debrief schlage ich vor:

🟢 Current (jetzt starten):
1. <Project title> — weil <one-sentence reason grounded in step_debrief>
2. <Project title> — weil <reason>

⚪ Later (kommt später):
3. <Project title>
4. <Project title>
5. <Project title>
6. <Project title>
(7. <Project title>)
(8. <Project title>)

Wenn das passt, sag 'go'. Wenn du tauschen willst: 'tausch 2 gegen 5'
oder 'nimm 3 statt 1' oder beschreib's frei.
```

**Substep 3 — Apply user's modification (if any):**

Parse the user's reply. Common forms:

- `go` / `ok` / `passt` → no change.
- `tausch X gegen Y` → swap project X (current) with project Y (later).
- `nimm zusätzlich Z` → bump current count from 2 to 3.
- `eigentlich will ich mit X anfangen` → make X current, demote the
  closest match.

If the reply is ambiguous, ask ONE clarifying question. Do not loop
indefinitely — after 2 turns, commit Charlie's best interpretation and
proceed.

**Substep 4 — Write `data.projects[]`:**

For each project (current + later), write to `dashboard_data.json` →
`data.projects[]`:

```json
{
  "n": 1,
  "title": "...",
  "why": "...",
  "goal": "...",
  "outcome": "...",
  "status": "current",
  "step": "2.1"
}
```

`n` is 1-indexed sequentially across all projects (current first, then
later). `step` is the active sub_id (the one with `here:true` in
`data.roadmap.phases`).

**Substep 5 — Generate tasks (hybrid: anchors + LLM tailoring):**

For each project (current AND later — all of them get tasks):

1. Copy the anchor tasks from
   `projects_per_step.json[step].projects[i].tasks[]` verbatim.
2. Generate 1–2 user-tailored tasks using `business_profile` +
   `step_debrief.parsed` as context. Tailored tasks should reference
   specifics — industry vocabulary, named channels from the debrief,
   concrete numbers.

Write each task to `dashboard_data.json` → `data.tasks[]`:

```json
{
  "id": 1,
  "text": "...",
  "done": false,
  "today": false,
  "project": "<projects[i].title>",
  "date": null,
  "dateTone": null
}
```

`id` is auto-increment starting at 1, monotonically across all tasks
(not reset per project). `project` field must match `projects[i].title`
exactly (string equality — no fuzzy match downstream).

**Substep 6 — Confirm to user:**

```
Plan steht ✓
- <N current projects> aktiv mit <total tasks for currents> Tasks
- <M later projects> warten mit <total tasks for laters> Tasks
  (kommen wenn du eins zumachst)

Womit willst du heute anfangen?
```

This message hands off to the daily workflow. Do not yet set
`current_step = "operating"` — the Closing-Flow (after the Weekly
Check-In Setup) still owns that transition. After Substep 6 set
`path_state.current_step = "onboarding-closing"`.

**Invariants:**

- Every project has `status` ∈ {`current`, `later`} after Step E.
  `done` is reserved for runtime, not onboarding.
- Every project has ≥1 task in `data.tasks[]` (2–3 anchors + 1–2
  tailored = 3–5 per project).
- Task `project` field exactly matches `projects[i].title` (string
  equality — no fuzzy match downstream).
- 2 ≤ count(`status="current"`) ≤ 3.

**Scale path fallback:** if
`paths/scale/templates/projects_per_step.json` has no entry for the
current sub_id, skip Step E and append a warning to
`path_state.warnings` (array; create if missing). Each warning is an
object:

```json
{
  "code": "missing_projects_template",
  "step": "<sub_id>",
  "at": "<iso-8601 timestamp>"
}
```

Charlie still proceeds to Closing-Flow; the Closing-Flow recap will
note projects haven't been populated yet.

## Path-Specific Addendum

After Q1-Q8, run the path-specific question set:

- If `current_path == "pmf"` → handled in the **PMF Path — Post-Routing
  Steps** section above. The readiness check
  (`assessment/pmf-readiness-questions.md`) runs only when Q3a is
  `engaged_users` or `survey_running`.
- If `current_path == "gtm"` → run `paths/gtm/assessment/gtm-onboarding-questions.md`
  (4 deep-dive Qs: ICP, acquisition history, sales process maturity,
  founder role).
- If `current_path == "scale"` → run scale sub-onboarding (placeholder,
  expand later).

## Weekly Check-In Setup (universal — required before Closing-Flow)

The Weekly Check-In is the heartbeat of the Founder Harness. Before
showing the dashboard, set the rhythm together with the user. This
section is conversational — do NOT silently call tools. The user must
understand WHY this matters and actively pick a time.

Two reminders get created at the end of this section:
- Weekly Check-In (recurring `weekly`)
- Monthly Review (recurring `monthly` — fires on the same day
  each month)

### Step 1 — Explain why the rhythm matters

Send this message verbatim (translate to user's language, preserve meaning):

> Bevor ich dir das Dashboard zeige, lass uns das Wichtigste fix machen:
> deinen **Weekly Check-In**.
>
> Das ist der eine Termin, der alles zusammenhält. Einmal pro Woche,
> ca. 20 Minuten, mit mir. Was du davon hast:
>  • Du bleibst im Fokus — was war diese Woche, was kommt nächste,
>    wo hakt's.
>  • Ich bin aktuell informiert — neue User-Quotes, neue Zahlen,
>    neue Bottlenecks. Ohne Check-In rate ich, statt zu wissen.
>  • Dein nächster Schritt steht fest — am Ende jedes Check-Ins
>    wissen wir beide genau, was diese Woche dran ist.
>
> Du siehst oben im Chatfenster immer, wie aktuell ich bin. Den Check-In
> kannst du jederzeit selbst anstoßen — und ich erinnere dich per
> WhatsApp, wenn der Slot kommt.

### Step 2 — Suggest one slot, accept alternatives

Suggest **Montag 9:00** as the default. Offer the user the option to
pick a custom slot if Monday 9:00 doesn't fit.

Ask:

> Wann passt's dir? Mein Vorschlag: **Montag 9:00 Uhr** — frischer Wochenstart,
> du planst nach vorn.
>
> Passt das — oder willst du einen eigenen Slot? Sag mir einfach
> Wochentag + Uhrzeit.

Parse the user's answer into:
- `weekday` — one of monday/tuesday/wednesday/thursday/friday/saturday/sunday (lowercase English)
- `time` — HH:MM in 24h format

### Step 3 — Verify timezone AND WhatsApp number

Run BOTH checks before creating any reminder. Both via the `user_profile` tool.
Profile data is stored in the `cc_users` table on the CC backend; the
`user_profile` tool is the only correct interface.

**3a — Read timezone:**

```
user_profile(action="read", field="timezone")
```

The default value in `cc_users` is `Europe/Berlin`. If the user is
clearly somewhere else (rare for this product), confirm:

> "Bist du in Europe/Berlin (Deutschland/Österreich/Schweiz)? Falls
> nicht, sag mir deine Zeitzone (z.B. America/New_York, Europe/London)."

If the user gives a different timezone, save:
```
user_profile(action="update", field="timezone", value="<IANA tz>")
```

Otherwise keep `Europe/Berlin` and proceed.

**3b — Read phone number:**

```
user_profile(action="read", field="phone_number")
```

Possible results:
- **Returns a phone number** → confirm with user:
  > "Ich schick den Reminder an {masked_number} (z.B. +49 ••• ••• 1234).
  > Passt die Nummer für WhatsApp?"
  - If user says yes → proceed to Step 4.
  - If user says no → ask for correct number, then:
    ```
    user_profile(action="update", field="phone_number", value="<+49...>")
    ```
- **Returns empty / null** → ask:
  > "Damit ich dich erinnern kann, brauche ich deine WhatsApp-Nummer.
  > Erinnerungen werden aktuell über WhatsApp zugestellt. Magst du mir
  > deine Nummer geben?"
  - User gives number →
    ```
    user_profile(action="update", field="phone_number", value="<+49...>")
    ```
  - User declines → set `path_state.reminders.opted_out = true` in
    `dashboard_data.json`, skip Steps 4-6, proceed to Closing-Flow with
    a note: "Alles klar, kein WhatsApp-Reminder. Du kannst den Check-In
    jederzeit selbst über das Chatfenster starten."

### Step 4 — Create the Weekly Check-In reminder

Compute `remind_at` per the date-anchoring rules in `manage_reminders`:
- Read today's date from system context.
- For weekly recurring: first fire = NEXT occurrence of `{weekday}` ≥ today
  at `{time}`. If today IS that weekday and `{time}` hasn't passed yet,
  fire today; otherwise next week.
- Format as ISO local time without Z suffix, e.g. `"2026-05-11T09:00:00"`.

Call:

```
manage_reminders(
  action="create",
  message="🟢 Charlie hier — Zeit für den Weekly Check-In. Ca. 20 Min, und du weißt wieder genau, was diese Woche zählt. Bereit?",
  remind_at="<computed first-fire ISO local>",
  timezone="<from Step 3a>",
  channel="whatsapp",
  frequency="weekly",
  schedule_day="<weekday from Step 2>",
  schedule_time="<HH:MM from Step 2>"
)
```

Store the returned reminder ID in `dashboard_data.json` →
`path_state.reminders.weekly_checkin_id`. Also write:
- `path_state.reminders.weekly_checkin_schedule` ← `"{weekday} {time} {timezone}"`
- `path_state.reminders.last_verified` ← current ISO date

### Step 5 — Suggest Monthly Review slot

Proposed at **Freitag 9:00**, on a date in the future. Compute default:
- Monthly first-fire = next Friday that is ≥ 28 days from today

Send this message:

> Top — Weekly Check-In steht ✅
>
> Eine Sache noch zur Cadence, damit du das ganze Bild hast:
>
> **Monatlich** machen wir ein größeres Review — das **Monthly Review**.
> Da messen wir den Score neu, schauen Trends statt Punktwerte, und
> justieren die Roadmap. Ca. 60 Min.
>
> Mein Vorschlag: **Freitag, {monthly_default_date} um 9:00 Uhr** —
> und dann jeweils am gleichen Datum jeden Monat. Passt das,
> oder lieber anderer Termin?

Parse user's answer. Accept "passt"/"ja" = default, OR a user-provided
slot.

### Step 6 — Create Monthly reminder

For Monthly Review, call (`monthly` = same calendar day each month,
e.g. always the 7th):

```
manage_reminders(
  action="create",
  message="📊 Charlie hier — Monthly Review steht an. Wir messen den Score neu und justieren die Roadmap. Ca. 60 Min.",
  remind_at="<monthly first-fire ISO local>",
  timezone="<from Step 3a>",
  channel="whatsapp",
  frequency="monthly",
  schedule_time="<HH:MM>"
)
```

Store ID in `path_state.reminders.monthly_review_id`. Also write:
- `path_state.reminders.monthly_review_schedule` ← `"day {DD} of month {time} {timezone}"`

### Step 7 — Confirm all reminders are set, then transition to Closing-Flow

Send:

> ✅ Alles eingerichtet:
>  • Weekly Check-In: jeden {weekday} um {time}
>  • Monthly Review: am {DD}. jeden Monat, {time}
>
> Reminder kommen per WhatsApp an {masked_phone}.
>
> Jetzt zum Dashboard 👇

Then proceed to the Closing-Flow.

## Closing-Flow (PMF — review the auto-filled dashboard with user)

When `current_path == "pmf"`, do NOT just set the timestamp and move
on. Show the user what we built and let them refine.

### Step 1: Present the dashboard

> **Recap variable bindings:**
> - `currentProjects = data.projects.filter(p => p.status === "current")`
> - `laterProjects = data.projects.filter(p => p.status === "later")`

Render this message verbatim (substitute placeholders from
`dashboard_data.json`):

```
✅ Onboarding fast fertig. Aus deinen Antworten und Step
{currentSubphase} ({step name}) habe ich dir ein Dashboard
vorbereitet.

Kurz, damit das Vokabular gleich Sinn ergibt:
Wir jagen Product/Market Fit. Der North Star ist der
Sean-Ellis-Score ≥40% — heißt: wenn du deine User fragst
„Wie wärst du drauf, wenn's das Produkt nicht mehr gäbe?",
sagen mindestens 4 von 10 „sehr enttäuscht". Das ist die
Linie, ab der ein Produkt wirklich sitzt.

Um da hinzukommen, splittest du deine Zeit 50/50:
 • Doubling-Down — verstärken, was deine Fanatics
   (die „sehr enttäuscht"-Gruppe) schon lieben.
 • Hopefuls Unblocken — Blocker beseitigen für die
   „etwas enttäuscht"-Gruppe, damit sie zu Fanatics werden.

So sieht's aus deinen Antworten aus:

📍 FOKUS
   Worum's geht: {currentFocus}
   Bottleneck (aus Q8): {bottleneck.title}
   → Wir haben das als „{matched_category}" interpretiert. Passt das?

🎯 CURRENT
   This Week: {oneThing}
   Current Projekte ({currentProjects.length}):
     1. {currentProjects[0].title} — Ziel: {currentProjects[0].goal}
     2. {currentProjects[1].title} — Ziel: {currentProjects[1].goal}
     (3. {currentProjects[2].title} — Ziel: {currentProjects[2].goal})
   + {laterProjects.length} weitere als „later" gemerkt
   {tasks.length} Tasks angelegt — willst du sie sehen?

📊 KPIs
   {kpis.rows[0].metric}: {kpis.rows[0].current} → {kpis.rows[0].target}
   {kpis.rows[1].metric}: {kpis.rows[1].current} → {kpis.rows[1].target}
   {kpis.rows[2].metric}: {kpis.rows[2].current} → {kpis.rows[2].target}

🚫 NICHT TUN
   {doNotDo.home joined ", "}

A) Passt alles → mit welchem Task willst du starten?
B) Da gibt's was zum Anpassen — willst du am Plan, an den Projekten
   oder an den Aufgaben was ändern?
```

### Step 2: Handle user reply

- **A (passt alles)**: Ask "Welcher Task aus der Liste? Ich markiere ihn
  als `today:true`." Update the chosen task in `dashboard_data.data.tasks`.
  Proceed to Step 3.

- **B (was anpassen)**: Ask "Was willst du anpassen — am Plan, an den
  Projekten oder an den Aufgaben?" Then branch on user's choice:

  - **"Plan"** → walk through the strategic setup: re-pick the
    `bottleneck` from the step's bottlenecks[*] list, refine
    `currentFocus` if user wants. Write new `bottleneck` + (optional)
    `currentFocus`. Re-confirm.

  - **"Projekte"** → walk through `projects[]` one by one. Let user
    edit title, goal, why, or remove a project. Update `tasks[]`
    accordingly (string match `task.project` == `project.title`) so
    tasks stay attached to renamed projects.

  - **"Aufgaben"** → walk through `tasks[]`. Let user reword, mark
    `today:true/false`, remove tasks, or add new tasks (max 7 total).

  After each refinement, re-show the changed section and ask for
  confirmation before moving on. When the user says "passt" or
  "fertig", proceed to Step 3.

### Step 3: Finalize

In a single `file_edit` on `01_Command_Center/Dashboards/dashboard_data.json`:

- `data.path_state.onboarding_completed_at` ← current ISO timestamp
- `data.path_state.current_step` ← `"operating"`
- `data.roadmap.badge` ← `null` *(removes the "First version" pill from the roadmap header)*

Confirm: "Alles klar — Operating Mode läuft. Ich melde mich beim nächsten
Check-In ({path_state.cadences.next_checkin_due})."

## Closing-Flow (GTM — review the auto-filled dashboard with user)

When `current_path == "gtm"`, do NOT just set the timestamp and move
on. Show the user what we built and let them refine. Same shape as
the PMF Closing-Flow, GTM-specific vocabulary.

### Step 1: Present the dashboard

> **Recap variable bindings:**
> - `currentProjects = data.projects.filter(p => p.status === "current")`
> - `laterProjects = data.projects.filter(p => p.status === "later")`

Render this message verbatim (substitute placeholders from
`dashboard_data.json`):

```
✅ Onboarding fast fertig. Aus deinen Antworten und Step
{currentSubphase} ({step name}) habe ich dir ein Dashboard
vorbereitet.

Kurz, damit das Vokabular gleich Sinn ergibt:
Wir bauen jetzt deinen Go-to-Market — also den wiederholbaren Weg,
wie du Kunden gewinnst. Drei Sachen entscheiden hier alles:

 • Dein **ICP** (Ideal Customer Profile) — wer genau dein
   bester Kunde ist. Nicht „Marketingleute", sondern z.B.
   „B2B-SaaS-CMOs, 50-200 Mitarbeiter, Series A, in DACH".
 • Dein **Acquisition Channel** — der eine Kanal, der für DICH
   funktioniert (Outbound / Content / Paid / Partner / Community).
   Nicht alle gleichzeitig, sondern einer richtig.
 • Dein **Sales Process** — der wiederholbare Weg vom ersten
   Kontakt zum Abschluss. Mit klaren Stages, Conversion-Rates,
   und einem Forecast, dem man trauen kann.

Das Ziel: predictable revenue. Heißt, du kannst sagen
„nächsten Monat schließen wir X Deals zu Y €" — und es stimmt.

So sieht's aus deinen Antworten aus:

📍 FOKUS
   Worum's geht: {currentFocus}
   Bottleneck (aus Q8): {bottleneck.title}
   → Wir haben das als „{matched_category}" interpretiert. Passt das?

🎯 CURRENT
   This Week: {oneThing}
   Current Projekte ({currentProjects.length}):
     1. {currentProjects[0].title} — Ziel: {currentProjects[0].goal}
     2. {currentProjects[1].title} — Ziel: {currentProjects[1].goal}
     (3. {currentProjects[2].title} — Ziel: {currentProjects[2].goal})
   + {laterProjects.length} weitere als „later" gemerkt
   {tasks.length} Tasks angelegt — willst du sie sehen?

📊 KPIs
   {kpis.rows[0].metric}: {kpis.rows[0].current} → {kpis.rows[0].target}
   {kpis.rows[1].metric}: {kpis.rows[1].current} → {kpis.rows[1].target}
   {kpis.rows[2].metric}: {kpis.rows[2].current} → {kpis.rows[2].target}

🚫 NICHT TUN
   {doNotDo.home joined ", "}

A) Passt alles → mit welchem Task willst du starten?
B) Da gibt's was zum Anpassen — willst du am Plan, an den Projekten
   oder an den Aufgaben was ändern?
```

### Step 2: Handle user reply

Same logic as PMF Closing-Flow Step 2 — Plan / Projekte / Aufgaben:

- **A (passt alles)**: Ask "Welcher Task aus der Liste? Ich markiere ihn
  als `today:true`." Update the chosen task. Proceed to Step 3.

- **B (was anpassen)**: Ask "Was willst du anpassen — am Plan, an den
  Projekten oder an den Aufgaben?" Then branch on user's choice
  (Plan → bottleneck/currentFocus; Projekte → projects[];
  Aufgaben → tasks[]). After each refinement, re-show the changed
  section and ask for confirmation before proceeding.

### Step 3: Finalize

In a single `file_edit` on `01_Command_Center/Dashboards/dashboard_data.json`:

- `data.path_state.onboarding_completed_at` ← current ISO timestamp
- `data.path_state.current_step` ← `"operating"`
- `data.roadmap.badge` ← `null` *(removes the "First version" pill from the roadmap header)*

Confirm: "Alles klar — Operating Mode läuft. Ich melde mich beim
nächsten Check-In ({path_state.cadences.next_checkin_due})."

## Closing (Scale — placeholder)

For the Scale path, sub-onboarding is still a placeholder. No auto-fill
recipe exists yet.

In a single `file_edit` on `01_Command_Center/Dashboards/dashboard_data.json`:

- `data.path_state.onboarding_completed_at` ← current ISO timestamp
- `data.path_state.current_step` ← `"operating"`
- `data.roadmap.badge` ← `null`

Confirm with user. Operating Mode begins.
