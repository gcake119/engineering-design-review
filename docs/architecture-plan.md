# Open-Source Architecture Plan

## Positioning

This repository packages a reusable Codex skill for engineering design review. The skill focuses on blind-spot discovery and trade-off discussion before or during implementation. Requirement evidence now informs engineering investment within that same review, without turning the skill into a full product-management or user-research tool.

It is not a general code review tool, security scanner, or architecture decision generator. It complements those workflows by helping the user notice hidden engineering risks and make deliberate choices.

## Design Principles

1. Keep the skill prompt small and reusable.
2. Keep public packaging separate from the installable skill.
3. Prefer progressive clarification over long questionnaires.
4. Ask one key question at a time in discussion mode.
5. Explain mature engineering domains and terms before recommending custom design.
6. Convert design discussion into acceptance criteria, tests, or decision notes.
7. Avoid pretending that all blind spots have equal risk.
8. Treat the blind-spot taxonomy as a starting set of prompts, not as a closed checklist.

## Skill Modes

- `scan`: find unknown unknowns and hidden risks.
- `discuss`: discuss one blind spot at a time and compare relevant trade-offs.
- `decide`: summarize the chosen approach and produce follow-up artifacts.

## Requirement-Sensitive Routing

The existing first-principles workflow remains the entry point. For feature-led proposals, uncertain business rules, new work practices, or unavailable user feedback, SKILL.md routes to `references/requirement-validation.md` inside the installable skill. The reference supplies backward reasoning, evidence/status distinctions, validation selection, and engineering investment boundaries without duplicating the engineering taxonomy or adding another mode.

- scan surfaces material requirement uncertainty alongside technical blind spots.
- discuss keeps one high-impact question at a time.
- decide records supported, conditional, and deferred decisions; missing feedback is never confirmation.

Observed facts, explicit requests, developer/AI inferences, and unvalidated business assumptions are separate evidence kinds. Confirmation status is a separate judgment: confirmed, pending validation, or major unresolved, with source, scope, and decision impact. Product usefulness and engineering correctness require separate evidence.

Validation depth depends on uncertainty, consequence, existing evidence, and reversibility. Prototypes are optional; an existing product can provide realistic task validation. Confirmed local fixes and purely technical reviews retain the short engineering path. User unavailability limits affected commitments rather than halting independent work.

The installer copies the whole skill directory, so the reference ships without installer changes. UI metadata and automatic invocation remain unchanged. This is a document-only change: no new runtime dependencies, CI gates, research tooling, or installation side effects.

## Core Review Axes

- Boundary contracts
- Lifecycle and state transitions
- Cache invalidation
- Degraded mode
- Rate limiting
- Namespaced identity
- Canonical data pipelines
- Test isolation
- Build and generated artifacts
- Migration and compatibility paths
- Implementation strategy

## Taxonomy Evolution

The review axes should help reviewers notice common blind spots, but they should not prevent discovery outside the list.

When a risk does not fit the current axes, the skill should:

1. Mark it as unclassified.
2. Explore the system boundary, product consequence, reversibility, validation gap, and operational impact.
3. Identify the mature engineering or product domain, if one exists.
4. Ask one exploratory question at a time.
5. Decide whether the risk is a one-off concern, a variant of an existing axis, or a candidate for a new taxonomy category.

Add a new review axis only when the risk recurs across contexts, requires distinct review questions, and materially changes design decisions or acceptance criteria.

## Initial Scope

The first public version should stay focused on review and discussion behavior. It should not add scripts, checkers, or repository mutations beyond the installer.

Future references may split domain guidance into:

- `webhook-and-api.md`
- `data-sync-and-cache.md`
- `reporting-and-analytics.md`
- `ai-agent-workflows.md`
- `release-and-migration.md`
- `frontend-state-lifecycle.md`

Add these only after repeated usage shows that the core `SKILL.md` needs domain-specific detail.

## Installation Strategy

Use a conservative installer:

1. Resolve the repository root.
2. Copy `skills/engineering-design-review` into `~/.codex/skills/engineering-design-review`.
3. Back up an existing installed skill directory before replacement.
4. Do not modify user repositories automatically.
5. Tell the user to restart Codex after installation.

## Validation Strategy

Use the official skill validator:

```bash
python3 /Users/caiyijun/.codex/skills/.system/skill-creator/scripts/quick_validate.py skills/engineering-design-review
```

Forward-test with realistic prompts, checking observable responses rather than matching headings or source strings. The requirement-discovery regression scenarios and reviewed results are recorded in `docs/requirement-validation-scenarios.md`. These are synthetic agent behavior checks, not evidence from real business users. Keep them separate from format validation.

For packaging changes or new bundled references, use the existing installer with a temporary `CODEX_HOME` and confirm that the installed reference can be read through the SKILL.md link; never overwrite the active user installation for a PR test.
