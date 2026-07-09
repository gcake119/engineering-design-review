# Engineering Design Review／工程設計審查

Engineering Design Review 是一個 Codex skill，用來找出工程設計中的盲區，並把這些盲區轉成可討論的設計取捨。

Engineering Design Review is a Codex skill for finding engineering blind spots and turning them into design trade-off discussions.

它適用於功能提案、Workflow Automation、架構變更、API、Webhook、資料同步、報表、AI Agent workflow、快取、版本發布與資料遷移。

It is intended for feature proposals, workflow automation, architecture changes, APIs, webhooks, data sync, reporting, AI agent workflows, caching, releases, and migrations.

## 功能／What It Does

- 在實作前掃描 unknown unknowns，也就是一開始容易沒意識到的工程盲區。
- Scans for unknown unknowns before implementation.
- 說明每個風險所屬的成熟工程領域與常見術語。
- Explains the mature engineering domain and common terminology behind each risk.
- 比較可行的設計方案、工程成本與取捨。
- Compares practical design options and trade-offs.
- 預設一次只釐清一個關鍵問題，避免一次丟出過長問卷。
- Guides clarification one question at a time by default.
- 將決策整理成驗收條件、測試案例、Spectra tasks、ADR notes 或 implementation notes。
- Converts decisions into acceptance criteria, tests, Spectra tasks, ADR notes, or implementation notes.

## Repo 結構／Repository Shape

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

可安裝的 Codex skill 位於 `skills/engineering-design-review`。Repo root 只保留公開包裝、架構規劃與安裝支援。

The installable Codex skill lives under `skills/engineering-design-review`. The repository root contains only public packaging, planning, and install support.

## 安裝／Install

```bash
curl -fsSL https://cdn.jsdelivr.net/gh/gcake119/engineering-design-review@main/scripts/install.sh | bash
```

安裝腳本會從 GitHub 下載 skill，複製到 `~/.codex/skills/engineering-design-review`，並在替換前備份既有版本。

The installer downloads the skill from GitHub, copies it to `~/.codex/skills/engineering-design-review`, and backs up an existing installed copy before replacing it.

如果你已經 clone 這個 repo，也可以在 repo root 執行：

If you have already cloned this repo, you can also run this from the repo root:

```bash
./scripts/install.sh
```

安裝後請重啟 Codex，讓 Codex 重新載入 skill。

Restart Codex after installation so the skill is discovered.

## 其他 Agent 支援／Other Agent Support

本專案目前是 Codex-first：只有 `skills/engineering-design-review` 是正式維護與測試的版本。

The project is currently Codex-first: only `skills/engineering-design-review` is actively maintained and tested.

這套工程設計審查方法本身是 agent-portable。其他 agent 的 prompt、rules、workflow 或 adapter 歡迎透過 PR 貢獻。

The review framework itself is agent-portable. Prompts, rules, workflows, or adapters for other agents are welcome via PRs.

如果你要新增其他 agent 支援，請在 PR 中包含：

If you add support for another agent, please include:

- adapter 放置位置與使用方式。
- Where the adapter lives and how to use it.
- 該 agent 的實際驗證方式。
- How you verified it with that agent.
- 至少一個可重現的使用範例。
- At least one reproducible usage example.
- 如果尚未完整支援，請明確標註限制。
- Any known limitations if support is partial.

## 使用範例／Example Prompts

```txt
Use engineering-design-review to scan this LINE webhook design for unknown unknowns.
```

```txt
Use engineering-design-review in discuss mode. Ask one question at a time while we compare retry, rate-limit gate, and queue throttling.
```

```txt
Use engineering-design-review to turn this reporting design decision into acceptance criteria and tests.
```
