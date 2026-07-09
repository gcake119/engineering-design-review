---
name: engineering-design-review
description: Review feature proposals, workflows, architecture changes, APIs, webhooks, data sync, reporting, AI agent workflows, caching, releases, migrations, implementation strategy, language/runtime adoption, full rewrites, module extraction, and sidecar/worker strategy for engineering blind spots and unknown unknowns. Use when the user asks to find hidden risks, discuss design considerations, compare engineering trade-offs, review a plan before implementation, evaluate Rust/Go/Python/TypeScript migration, or turn blind spots into decisions, acceptance criteria, tests, Spectra tasks, or ADR notes.
---

# Engineering Design Review

## Purpose

Find engineering blind spots, then facilitate design trade-off discussion and decision capture. Treat the skill as a design review companion, not as a replacement for code review, security review, or deterministic tests.

## Modes

- `scan`: identify unknown unknowns and hidden risks.
- `discuss`: compare design options and trade-offs.
- `decide`: converge on a recommendation, acceptance criteria, tests, and documentation updates.

If the user does not specify a mode, scan first, then propose the highest-impact blind spot to discuss. Do not finalize the architecture while the user is still clarifying product constraints, reliability expectations, or implementation cost.

## Workflow

1. Classify the work type: API, webhook, data sync, reporting, AI agent workflow, frontend state, cache, release, migration, implementation strategy, rewrite, runtime migration, language adoption, module extraction, sidecar/worker, security-sensitive surface, or other.
2. Identify boundaries: callers, callees, source of truth, external systems, side effects, state owners, and user-visible failure points.
3. Run the blind-spot scan using the categories below. If an important risk does not fit, mark it as `unclassified` and explore it instead of forcing it into a category.
4. Prioritize findings by risk, reversibility, implementation cost, and product impact.
5. For discussion, explain the mature engineering domain and common terminology before comparing options.
6. Compare only the options relevant to the current decision.
7. Recommend a path based on the project stage: prototype, MVP, internal pilot, production, multi-tenant production, or regulated/high-trust workflow.
8. Convert the decision into acceptance criteria, tests, Spectra tasks, ADR notes, or implementation notes when useful.

## Discussion Style

In `discuss` mode, use progressive clarification by default.

- Discuss one blind spot at a time.
- Ask one key question at a time.
- Prefer the highest-leverage unresolved question first.
- Do not ask a long questionnaire.
- Do not move to the next blind spot until the current decision is clear enough, deferred intentionally, or the user asks to move on.
- When the user answers, summarize the implication, update the recommendation, then ask the next question if needed.
- If multiple options exist, compare only the options relevant to the current question.
- If the user asks for a complete review, first provide the scan summary, then propose the first blind spot to discuss.

## Blind-Spot Categories

Use these categories as prompts, not as a rigid checklist or closed taxonomy.

1. Boundary contract: success, failure, timeout, retry, cancellation, versioning, idempotency, and ownership.
2. Lifecycle: trigger, refresh, cancellation, reentry, stale request handling, and state transitions.
3. Cache invalidation: source of truth, change token, TTL, stale data policy, and old response overwrite risks.
4. Degraded mode: last known good state, partial results, user-facing honesty, and operational recovery.
5. Rate limits: retry policy, exponential backoff, gate, circuit breaker, queue throttling, and shared quota state.
6. Namespaced identity: tenant, source, channel, session, external ID, deduplication scope, and collision risks.
7. Data pipeline consistency: canonical pipeline, metric definitions, time zones, reconciliation, exports, and drill-down parity.
8. Test isolation: global state, mocks, cache, database fixtures, fake timers, queues, and parallel test pollution.
9. Build and generated artifacts: migrations, generated types, schema clients, bundles, Docker layers, and release packages.
10. Migration path: old users, old data, old settings, old API clients, rollback, and compatibility window.
11. Implementation strategy: current pain, product stage, language/runtime fit, rewrite vs extraction, contract maturity, equivalence tests, rollout path, rollback, and long-term maintainability.

## Unclassified Blind Spots

When a meaningful risk does not fit the categories above, treat it as an unclassified blind spot.

1. Do not force the risk into the closest existing category.
2. Explain why the current taxonomy does not cover it well.
3. Identify the mature engineering or product domain, if one exists.
4. Explore system boundaries, product consequences, reversibility, validation gaps, and operational impact.
5. Ask one exploratory question at a time.
6. Decide whether the risk is a one-off project concern, a variant of an existing category, or a candidate for a new category.
7. Recommend adding a new category only when the risk recurs across contexts, has distinct review questions, and materially changes design decisions or acceptance criteria.

Use exploratory questions such as:

- What new role, boundary, or state owner appears in this feature?
- Which assumption is currently unvalidated?
- Which failure mode would confuse users, operators, or maintainers the most?
- Which decision would be expensive to reverse later?
- Which mature engineering or product domain already has terminology for this risk?

## Domain Routing

- For webhooks and APIs, emphasize idempotency, signatures, retries, timeout budgets, duplicate events, and envelope consistency.
- For data sync and reporting, emphasize source of truth, incremental sync, deduplication, time zones, canonical pipelines, and reconciliation.
- For AI agent workflows, emphasize tool contracts, side effects, cost bounds, recovery, human confirmation points, and auditability.
- For frontend state, emphasize lifecycle, stale request handling, loading/error/empty states, accessibility, and edit-state correctness.
- For releases and migrations, emphasize generated artifacts, install/upgrade paths, data migration, backward compatibility, and rollback.
- For implementation strategy, rewrites, language adoption, runtime migration, or module extraction, emphasize the mature domain first: rewrite feasibility assessment, strangler fig migration, compatibility contracts, golden tests, shadow mode, canary rollout, rollback, and maintenance cost. Compare full rewrite, incremental migration, specialized component extraction, sidecar/worker, and staying on the current stack. Do not recommend a rewrite until the current pain, contract maturity, test coverage, operational rollout, and team maintainability justify it.
- For security-sensitive work, suggest pairing this review with a security-specific review.

## Output Formats

### Scan Output

```md
## Engineering Blind-Spot Scan

### High-Risk Blind Spots
- Finding:
- Why it is easy to miss:
- Potential consequence:
- Recommended discussion:
- Suggested verification:

### Medium-Risk Blind Spots
- ...

### First Discussion Question
...
```

### Discussion Output

```md
## Blind Spot: <name>

### Why This Is Easy To Miss
...

### Mature Domain And Terms
...

### Relevant Options
1. ...
2. ...

### Trade-Off
...

### Provisional Recommendation
...

### One Question
...
```

### Unclassified Output

```md
## Unclassified Blind Spot: <name>

### Why Existing Categories Do Not Fit
...

### Possible Mature Domain
...

### Exploration Notes
- Boundary:
- Product consequence:
- Reversibility:
- Validation gap:
- Operational impact:

### Taxonomy Decision
One-off concern | Existing category variant | Candidate new category

### One Question
...
```

### Implementation Strategy Output

```md
## Implementation Strategy Review

### Current Pain
- Primary pain:
- Problem type:

### Mature Domain
- Domain:
- Common terms:
- Mainstream patterns:

### Options
1. Stay on current stack:
2. Refactor within current stack:
3. Extract specialized component:
4. Add sidecar/worker:
5. Incremental migration:
6. Full rewrite:

### Contract Readiness
- Format contract:
- Behavioral contract:
- Golden tests:
- Edge-case matrix:
- Compatibility tests:
- Performance baseline:

### Recommendation
- Recommended path:
- Why this fits the current stage:
- What not to rewrite yet:

### Acceptance Criteria
- ...

### Suggested Tests
- ...

### Rollout And Rollback
- Rollout:
- Rollback:
- Observability:

### Deferred Risks
- ...
```

### Decision Output

```md
## Decision Summary

- Adopted approach:
- Alternatives rejected:
- Why this fits the current stage:
- Acceptance criteria:
- Suggested tests:
- Documentation updates:
- Deferred risks:
```
