# Engineering Design Review

Engineering Design Review is a Codex skill for finding engineering blind spots and turning them into design trade-off discussions.

It is intended for feature proposals, workflow automation, architecture changes, APIs, webhooks, data sync, reporting, AI agent workflows, caching, releases, and migrations.

## What It Does

- Scans for unknown unknowns before implementation.
- Explains the mature engineering domain and common terminology behind each risk.
- Compares practical design options and trade-offs.
- Guides clarification one question at a time by default.
- Converts decisions into acceptance criteria, tests, Spectra tasks, ADR notes, or implementation notes.

## Repository Shape

```txt
engineering-design-review/
├── README.md
├── LICENSE
├── docs/
│   └── architecture-plan.md
├── scripts/
│   └── install.sh
└── skills/
    └── engineering-design-review/
        ├── SKILL.md
        ├── agents/
        │   └── openai.yaml
        └── references/
```

The installable Codex skill lives under `skills/engineering-design-review`. The repository root contains only public packaging, planning, and install support.

## Install

```bash
./scripts/install.sh
```

The installer copies the skill to `~/.codex/skills/engineering-design-review` and backs up an existing installed copy before replacing it.

Restart Codex after installation so the skill is discovered.

## Example Prompts

```txt
Use engineering-design-review to scan this LINE webhook design for unknown unknowns.
```

```txt
Use engineering-design-review in discuss mode. Ask one question at a time while we compare retry, rate-limit gate, and queue throttling.
```

```txt
Use engineering-design-review to turn this reporting design decision into acceptance criteria and tests.
```
