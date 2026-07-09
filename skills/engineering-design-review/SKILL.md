---
name: engineering-design-review
description: Review feature proposals, workflows, architecture changes, APIs, webhooks, data sync, reporting, AI agent workflows, caching, releases, and migrations for engineering blind spots and unknown unknowns. Use when the user asks to find hidden risks, discuss design considerations, compare engineering trade-offs, review a plan before implementation, or turn blind spots into decisions, acceptance criteria, tests, Spectra tasks, or ADR notes.
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

1. Classify the work type: API, webhook, data sync, reporting, AI agent workflow, frontend state, cache, release, migration, security-sensitive surface, or other.
2. Identify boundaries: callers, callees, source of truth, external systems, side effects, state owners, and user-visible failure points.
3. Run the blind-spot scan using the categories below.
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

Use these categories as prompts, not as a rigid checklist.

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

## Domain Routing

- For webhooks and APIs, emphasize idempotency, signatures, retries, timeout budgets, duplicate events, and envelope consistency.
- For data sync and reporting, emphasize source of truth, incremental sync, deduplication, time zones, canonical pipelines, and reconciliation.
- For AI agent workflows, emphasize tool contracts, side effects, cost bounds, recovery, human confirmation points, and auditability.
- For frontend state, emphasize lifecycle, stale request handling, loading/error/empty states, accessibility, and edit-state correctness.
- For releases and migrations, emphasize generated artifacts, install/upgrade paths, data migration, backward compatibility, and rollback.
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
