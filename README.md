# Engineering Design Review／工程設計審查

Engineering Design Review 是一個 Codex skill，用來找出工程設計中的盲區，並把這些盲區轉成可討論的設計取捨。

Engineering Design Review is a Codex skill for finding engineering blind spots and turning them into design trade-off discussions.

它適用於功能提案、Workflow Automation、架構變更、API、Webhook、資料同步、報表、AI Agent workflow、快取、版本發布與資料遷移。

It is intended for feature proposals, workflow automation, architecture changes, APIs, webhooks, data sync, reporting, AI agent workflows, caching, releases, and migrations.

## 怎麼運作／How It Works

先釐清問題，再找盲點與可借用的解法，最後把建議說清楚。

Clarify the problem, uncover blind spots, explore proven approaches, then explain the recommendation.

1. **第一性原理分析：先問「真正要解決什麼？」** 從目標、已知事實與限制出發，分清楚哪些有證據、哪些只是假設，再拆解流程與可能失敗的地方。
   **First-principles analysis:** Start with the goal, known facts, and constraints. Separate evidence from assumptions, then examine the workflow and possible failures.
2. **跨成熟領域解法探索：看看別的領域怎麼處理類似問題。** 例如工作是否完成不明，可以參考分散式系統的確認回覆，也能借用會計對帳的核對思路。說明可借用的部分、適用條件、限制與成本，再確認是否適合目前專案。
   **Cross-domain solution discovery:** Look for established ways to solve similar problems in other fields. For uncertain task completion, consider acknowledgments from distributed systems or reconciliation from accounting. Explain what transfers, its conditions, limits, and costs, then check whether it fits the project.
3. **逐題討論：一次處理一個關鍵問題。** 依風險與影響排序，比較相關方案，也考慮保留或改善現有做法；資訊不足時先給暫定建議。
   **Discuss one question at a time:** Prioritize by risk and impact, compare relevant options, and consider keeping or improving the current approach. Keep recommendations provisional when information is missing.
4. **金字塔原理報告：先講結論，再說理由與證據。** 最後列出下一步；需要時整理成驗收條件、測試建議或決策紀錄，讓團隊知道如何確認方案有效。
   **Pyramid-principle reporting:** Lead with the conclusion, followed by reasons and evidence, then next steps. When useful, turn decisions into acceptance criteria, test suggestions, or decision records so the team can verify the result.

未指定模式時，先做盲點掃描（`scan`），再進入方案討論（`discuss`）；條件釐清後才收斂決策（`decide`）。它協助設計判斷，仍需搭配程式碼審查、安全審查與實際測試。

By default, start with a blind-spot scan (`scan`), then discuss options (`discuss`), and converge on a decision once constraints are clear (`decide`). The skill supports design judgment alongside code review, security review, and actual tests.

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
