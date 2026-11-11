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

## First-Principles Analysis

Use first principles to build the analysis: start from the required outcome, verified facts, and actual constraints, then derive the design implications. Do not treat an existing implementation, popular pattern, or industry convention as sufficient justification.

- Define the problem, affected users, desired observable outcomes, and success criteria before evaluating solutions. Separate the need from the proposed implementation.
- Distinguish verified facts, assumptions, hard constraints, and negotiable preferences. Identify the source or evidence for consequential claims; mark missing evidence and uncertainty explicitly.
- Decompose the system into boundaries, state owners, data flows, side effects, and necessary invariants. Trace how a trigger can lead to success or failure, including dependencies and recovery.
- Challenge assumptions that materially affect the decision. Explain the causal link from a fact or assumption to a failure mode, product consequence, and design requirement; avoid presenting a category checklist as analysis.
- Derive the simplest sufficient options, including retaining or improving the current approach when relevant. Compare them against the same outcomes, constraints, lifecycle costs, and reversibility.
- State what evidence would change the recommendation and suggest the lowest-cost sufficient validation for critical unknowns. Scale depth to the decision; do not invent precision or require exhaustive analysis for small questions.

## Pyramid-Principle Reporting

Present the report using the pyramid principle: lead with the answer, organize supporting reasons underneath it, and place evidence and detail below each reason. The analysis may proceed bottom-up; the delivered report should be conclusion-first.

- Open with the main finding or recommendation, its decision impact, and any uncertainty that changes the action. If constraints remain unresolved, give a provisional conclusion and the key unresolved condition instead of claiming a final decision.
- Group supporting points by distinct decision-relevant reasons, ordered by importance or causal dependency. Each group should support the conclusion above it; avoid overlapping groups, unsupported claims, and a chronological account of the investigation.
- Support material findings with the relevant fact or assumption, causal explanation, consequence, and verification. Keep observed evidence separate from inference and proposed work.
- End with the next decision or action. In discussion mode, ask only the single highest-impact unresolved question, preserving progressive clarification.
- Use the output formats below as adaptable outlines, not mandatory empty sections. Keep short answers short, and put the conclusion before background, terminology, option detail, and checklists in every mode.

## Workflow

1. Classify the work type: API, webhook, data sync, reporting, AI agent workflow, frontend state, cache, release, migration, implementation strategy, rewrite, runtime migration, language adoption, module extraction, sidecar/worker, security-sensitive surface, or other.
2. Establish the problem, success criteria, evidence, assumptions, and constraints using first-principles analysis. Identify boundaries: callers, callees, source of truth, external systems, side effects, state owners, and user-visible failure points.
3. Run the blind-spot scan using the categories below and look for transferable solutions from relevant mature domains using Cross-Domain Solution Discovery. If an important risk does not fit, mark it as `unclassified` and explore it instead of forcing it into a category.
4. Prioritize findings by risk, reversibility, implementation cost, and product impact.
5. For discussion, explain the mature engineering domain and common terminology before comparing options.
6. Compare only the options relevant to the current decision.
7. Recommend a path based on the project stage: prototype, MVP, internal pilot, production, multi-tenant production, or regulated/high-trust workflow.
8. Convert the decision into acceptance criteria, tests, Spectra tasks, ADR notes, or implementation notes when useful.
9. Present the findings using pyramid-principle reporting, with a conclusion appropriate to the current mode and evidence strength.

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

## Cross-Domain Solution Discovery

During the scan, proactively offer established solutions from different mature domains when they illuminate a meaningful blind spot or provide a materially different option. Do not wait for discussion mode to surface these possibilities.

- Abstract the problem into its underlying structure, such as duplicate effects, uncertain completion, resource contention, feedback delay, reconciliation, or human handoff. Look beyond the feature's immediate technical domain.
- Identify relevant mature domains and their established mechanisms. For example, uncertain workflow completion may draw on distributed-systems acknowledgments and accounting reconciliation; resource contention may draw on queueing theory and admission control. These are discovery prompts, not a mandatory domain list.
- Explain each candidate in plain language: source domain and common term, original problem, shared causal structure, transferable mechanism, and intended observable benefit.
- State where the analogy breaks: required assumptions, differences in scale or failure tolerance, adoption and operating costs, and conditions where the mechanism is unsuitable. Similar vocabulary alone does not establish applicability.
- Compare useful candidates against the same first-principles outcomes and constraints, including the simplest existing approach. Offer multiple domains when they yield meaningfully different choices; do not force a fixed number or add complexity merely to demonstrate breadth.
- Distinguish an established practice in its source domain from an unvalidated transfer to this project. Support consequential or unfamiliar claims with authoritative primary sources as needed, and propose the lowest-cost sufficient check of applicability.
- Include the strongest relevant candidates in the scan summary, then preserve one-question-at-a-time discussion. Present candidates as options until project evidence and constraints justify adoption.

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

### Main Finding And Decision Impact
- Conclusion (provisional if needed):
- Key supporting reasons:
- Critical uncertainty:

### High-Risk Blind Spots
- Finding:
- Why it is easy to miss:
- Potential consequence:
- Relevant mature domains and candidate mechanisms (when useful):
- Transfer fit, limitations, and cost:
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

### Provisional Recommendation And Reasons
...

### Why This Is Easy To Miss
...

### Relevant Mature Domains And Transferable Mechanisms
- Source domain and term:
- Shared problem structure and mechanism:
- Applicability, limitations, and cost:

### Relevant Options
1. ...
2. ...

### Trade-Off
...

### Evidence That Would Change The Recommendation
...

### One Question
...
```

### Unclassified Output

```md
## Unclassified Blind Spot: <name>

### Main Finding And Decision Impact
...

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

### Recommendation
- Recommended path (provisional if needed):
- Main supporting reasons:
- Why this fits the current stage:
- Scope to retain or defer:
- Critical uncertainty:

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
- Main supporting reasons:
- Why this fits the current stage:
- Alternatives rejected and trade-offs:
- Key evidence, assumptions, and remaining uncertainty:
- Acceptance criteria:
- Suggested tests:
- Documentation updates:
- Deferred risks:
```
