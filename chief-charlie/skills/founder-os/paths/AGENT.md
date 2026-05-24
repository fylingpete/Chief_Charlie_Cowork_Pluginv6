# Roadmap Personalization — Agent Instructions

## When to personalize

Personalize the **current step's** rich content (in `roadmap_data.json`) whenever:

1. Onboarding completes and the start step is set (one-time bulk: personalize all steps in the current phase if user is at 1.1, or just the current step + next 1-2 if user starts further in).
2. The `here:true` flag flips to a new step (phase advance trigger).
3. The user explicitly asks ("personalize step 1.x for my business").

## Scope rule

Personalize ONLY the active phase's steps. Other phases keep the default pack content. Cross-phase steps (e.g. 2.x when user is in phase 1) are out of scope.

## Personalization recipe

For the target step:

1. Read `roadmap_data.json` → `steps[stepId]`. This is your starting point.
2. Read `dashboard_data.json` → `business_profile` (industry, buyer B2B/B2C, build_type, stage). Read `focus` (current bottleneck, current goal).
3. For each tab, adapt language and examples to fit the user's context:
   - **overview.whyThisStep** + **overview.deepenPrompt**: keep the structure, but rephrase using their domain vocabulary.
   - **overview.mainGoal** + **overview.mainQuestion**: keep the structure, swap generic terms for their business (e.g. "users" → "agencies" if buyer=B2B-agencies).
   - **overview.whatMatters**: keep the icons (`icon` enum is fixed: engaged/followup/idcard/star/target/compass/spark/users/check/heart). Adapt `label` text to their context.
   - **overview.readyWhen**: rephrase exit criteria using their domain terms.
   - **bottlenecks**: most-personalized tab. Add or rewrite categories that match their `bottleneck.title` from dashboard_data. Default categories (Produkt/Marketing/Sales/Customers/Team) are starting points.
   - **keys**: light personalization — rewrite tags + bullets with their tone/jargon.
   - **deliverables**: usually keep as-is. Personalize labels if their stack differs (e.g. "Notion-Doc" instead of "Google Form" if Notion is their tool).
   - **sources**: usually keep as-is. Add domain-specific sources from `knowledge/<path>/` files if a knowledge file aligns with the step + user's industry. Do NOT invent new sources.
4. Write back to `roadmap_data.json` — full file, replacing only `steps[stepId]`. Other steps untouched.

## Constraints

- DO NOT change `icon` enum values — frontend rejects unknown icons.
- DO NOT remove tabs (overview/bottlenecks/keys/deliverables). If you have nothing for a tab, keep its empty default — frontend renders empty-state copy.
- DO NOT touch `dashboard_data.json` from this workflow (no `here:true` flips during personalization — that's a separate event).
- KEEP all source-fidelity to YC + Sean Ellis. Do not invent frameworks. If a Bottleneck doesn't match user context, drop it rather than fabricate.

## Token budget

Single step personalization: ~2-3 KB output.
Full phase (5 steps): ~12-15 KB.
Trigger this only when needed; do not re-personalize on every turn.

## Responding to UI-generated structured prompts

The frontend generates structured prompts when the user clicks links inside the
roadmap step tabs. These prompts arrive in a fresh chat session and follow a
fixed template. You MUST recognize them and respond in the matching structure.

### Bottleneck-link prompts

Triggered when the user clicks an `advanceLabel` ("Manuell rekrutieren →") in
the Bottlenecks tab. Shape:

```
Ich bin in Step <stepId>: <stepName> und stoße auf den Bottleneck:

Kategorie: <category>
Problem: <bottleneck text>
Ziel: <advance text>

Bitte hilf mir konkret:
1. Was ist die Wurzel meines Problems hier (warum stocke ich genau bei diesem Schritt)?
2. Welche 1–2 nächsten konkreten Aktionen bringen mich zum Ziel "<advanceLabel>"?
3. Woran erkenne ich, dass ich den Bottleneck überwunden habe?

Berücksichtige meinen Business-Kontext (industry, ICP, stage) aus business_profile.
```

### Deliverable-link prompts

Triggered when the user clicks "Work on deliverable →" in the Deliverables tab.
Shape:

```
Ich bin in Step <stepId>: <stepName> und arbeite an diesem Deliverable:

"<label>"

Bitte hilf mir konkret:
1. Was ist das Ergebnis dieses Deliverables in einem Satz — wann ist es "fertig"?
2. Welche 2–3 nächsten konkreten Aktionen bringen mich dahin?
3. Welche Vorlage oder welches Format passt für mein Business am besten (basierend auf meinem business_profile)?

Wenn du eine konkrete Vorlage oder Datei erstellen kannst, schlag das aktiv vor.
```

### How to respond

When you see one of these structured prompts:

1. **Read `dashboard_data.json` → `business_profile`** for industry, buyer
   (B2B/B2C), build_type, stage. Read `focus` for current bottleneck/goal.
2. **Match the structure 1:1.** Answer all three numbered questions in the
   same order. Do not skip a point or merge them.
3. **Be concrete and business-specific.** Use the user's domain vocabulary,
   not generic founder-coach language. If `business_profile` says they're a
   B2B-agency in real estate, answer in those terms.
4. **For deliverables: actively offer to create the artifact.** If the
   deliverable is a list, doc, sheet, or script, propose a concrete first
   draft inline or offer to write it to a workspace file.
5. **Cross-reference the relevant knowledge file** when the step has one
   (`knowledge/pmf/yc/yc-do-things-that-dont-scale.md`,
   `knowledge/pmf/sean-ellis-test.md`, etc.). Quote the principle, don't just
   namedrop the source.
6. **Never re-render the prompt back at the user.** Skip restating "you are
   in step 1.3" — they know. Jump into the answer.

### Constraints

- DO NOT respond with generic founder-advice that ignores the structured
  prompt template.
- DO NOT add a fourth or fifth point — the user's UI affordance assumes 3.
- DO use the user's preferred language ("du" form, German tone).
- DO end with a concrete next action the user can take in &lt;30 minutes.
