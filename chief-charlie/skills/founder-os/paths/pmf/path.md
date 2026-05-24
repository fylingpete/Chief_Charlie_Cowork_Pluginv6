# PMF Path

Goal: reach Sean Ellis Score ≥ 40% with ≥30 respondents, then offer
switch to GTM path.

## Phase 1 — Search for Product-Market Fit

5 sequential steps from idea to ≥40% Sean Ellis score:

1. **Problem & Founder-Fit** — YC 10-question idea eval, founder-market-fit, 5-10 problem interviews (Mom Test). Exit: validated problem with ≥5 unprompted user quotes.
2. **MVP scope & build** — Cut down to 5-10 features, ship hacky version. Exit: ≥3 real users use it without founder hand-holding.
3. **Erste 10 User & Lernen** — Manual recruitment ("do things that don't scale"), session observation, friction-pattern documentation. Exit: ≥10 engaged users (2× sessions in 2 weeks), ≥3 friction patterns.
4. **PMF-Score messen & Lieblings-User identifizieren** — Sean Ellis 4-question survey, V/S/N segmentation, HXC v1 from Very Disappointed only. Exit: score computed (≥15 directional / ≥40 valid), HXC v1 with 5 mandatory fields.
5. **Verbessern bis User dein Produkt nicht mehr missen wollen** — 50/50 roadmap (doubling-down + unblocking), weekly/monthly/quarterly rhythm. Exit: Sean Ellis ≥40% in 2 consecutive monthly reviews.

## Operations

- `operations/weekly-checkin.md` — 5 min, weekly
- `operations/monthly-review.md` — 60 min, monthly
- `operations/quarterly-rebuild.md` — 3-4h, quarterly
- `operations/event-40-milestone.md` — triggered on score ≥ 40
- `operations/event-score-drop.md` — triggered on drop > 5pts
- `operations/event-no-response.md` — triggered on 2 weeks without responses

## Streams owned by this path

- `pmf_survey_responses.jsonl` — append on every survey response
- `pmf_score_history.jsonl` — append after each Monthly Review

## Switch out

When latest entry in `pmf_score_history.jsonl` shows score ≥ 40 AND
respondent_count ≥ 30, agent proposes switch to GTM (see master SKILL.md
"Path Switch" section).
