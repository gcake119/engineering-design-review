# Open-Source Architecture Plan

## Positioning

This repository packages a reusable Codex skill for engineering design review. The skill focuses on blind-spot discovery and trade-off discussion before or during implementation.

It is not a general code review tool, security scanner, or architecture decision generator. It complements those workflows by helping the user notice hidden engineering risks and make deliberate choices.

## Design Principles

1. Keep the skill prompt small and reusable.
2. Keep public packaging separate from the installable skill.
3. Prefer progressive clarification over long questionnaires.
4. Ask one key question at a time in discussion mode.
5. Explain mature engineering domains and terms before recommending custom design.
6. Convert design discussion into acceptance criteria, tests, or decision notes.
7. Avoid pretending that all blind spots have equal risk.

## Skill Modes

- `scan`: find unknown unknowns and hidden risks.
- `discuss`: discuss one blind spot at a time and compare relevant trade-offs.
- `decide`: summarize the chosen approach and produce follow-up artifacts.

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

Forward-test with realistic prompts after the first installed version is usable.
