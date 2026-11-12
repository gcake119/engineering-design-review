# Requirement Validation Scenarios

## Scope And Method

These are manual, synthetic agent behavior checks, not deterministic unit tests or real-user acceptance. Each case runs independently with the skill and its linked reference; B also has a follow-up checking silence. Review observable responses, not exact wording or headings. No product changes, interviews, real notifications, or pilots are performed.

The following criteria were set before applying the skill changes. Baseline: ea5a10f. Candidate results are recorded below after execution. A skill-format pass proves structure only.

## Acceptance Scenarios

### A — Feature-Led SaaS

Given only “我想讓個案透過 LINE OA 自行改期”, when scan runs, then it treats the feature as a solution hypothesis, traces the current work problem without inventing evidence, distinguishes request from assumed rules/value, suggests a proportionate usefulness check, and asks at most one highest-impact question. It must not assume a full self-service system is confirmed.

### B — External User Unavailable

Given “我要做每日工作台與案件逾期提醒” and unavailable officers, when scan runs, then it identifies confirmation risk, offers a concrete scenario/screen/prototype check, and separates safe reversible work from unconfirmed rule-dependent commitments. Product usefulness and engineering correctness remain separate.

Given the follow-up “承辦人還是沒回，請先往下決策”, when decide runs, then unresolved requirements stay unresolved, the recommendation is conditional, and independent work can continue without treating silence as approval.

### C — Confirmed Local Fix

Given an already confirmed date display correction from MM/DD/YYYY to YYYY-MM-DD, when reviewed, then it proceeds to focused observable engineering checks without a discovery questionnaire, prototype, or mandatory status registry. It must not imply changes were executed without a repository.

### D — Existing Engineering Review

Given a webhook that deducts stock before writing a processing record and returns 500 for retry, when reviewed, then it identifies duplicate effects, crash and concurrency boundaries, compares relevant idempotency/transaction options, suggests observable duplicate/recovery tests, and asks at most one technical question. No forced interview or UI prototype.

### E — Implemented Product Without Users

Given a largely completed SaaS without real users, when reviewed, then it uses the existing product for recruiting relevant users and task-based validation or a bounded pilot, distinguishes implementation evidence from product fit, and avoids automatic prototype rebuilding or speculative expansion.

## Baseline Review

An independent agent read only the baseline SKILL.md and produced all five first responses plus B's follow-up before edits. C and D already stayed on a proportionate technical path; B's follow-up preserved uncertainty, and E already suggested task-based use of the existing product. These behaviors must be retained, not described as newly fixed failures.

A moved directly to rescheduling mechanics and asked immediate-effect versus approval before establishing the current work problem. It described unknown rules but did not explicitly distinguish the feature request from evidence of usefulness. Across responses, requirement status and its engineering scope were useful but ad hoc rather than a consistent decision method. This is the targeted gap; the change does not claim all baseline scenarios failed.

## Candidate Results

Date: 2026-11-12 (Asia/Taipei). One independent agent re-read the candidate SKILL.md and linked requirement-validation reference, then generated fresh responses to the same isolated prompts without reading this acceptance document. The author reviewed the actual responses against the criteria above. One response per case per version, plus B's follow-up; this is a limited synthetic sample, not a statistical reliability claim.

| Case | Reviewed result | Observable candidate behavior |
| --- | --- | --- |
| A | Pass | Called self-rescheduling a candidate, labeled reduced back-and-forth as its own inference, kept approval/time limits major unresolved, proposed observing a recent rescheduling task, and asked about current work before committing to mechanics. |
| B | Pass | Recommended a concrete case walkthrough; static screen for information uncertainty and interactive prototype only for uncertain operations. Separated reversible preparation from automatic reminders and unconfirmed data/workflow commitments. |
| B follow-up | Pass | Kept silent officers' requirements unconfirmed, gave conditional decisions and a review point, and continued confirmed or reversible work. Product-use and engineering evidence remained separate. |
| C | Pass | Went straight to the known display correction and focused tests; no discovery table, interview, or prototype. Requested the missing project location without pretending to have implemented a change. |
| D | Pass | Found duplicate deductions, concurrent delivery, crash windows, and lost acknowledgments. Compared transaction/unique-identity safeguards with external-service contract limits and proposed observable recovery tests. Asked one technical boundary question. |
| E | Pass | Recommended recruiting relevant users and using the existing SaaS for real-task sessions or a bounded pilot. No automatic prototype rebuild; distinguished completion from usefulness and deferred speculative expansion. |

Representative output excerpts (actual agent responses):

- A: 「希望減少人工往返或等待｜我的推論；待驗證」 and 「最近一次個案改期，是怎麼從提出需求到完成確認的，其中最麻煩的是哪個環節？」
- B: 「若主要未知是資訊排列，靜態畫面就足夠；若涉及跨角色操作，再考慮互動原型。」
- B follow-up: 「承辦人未回覆的項目仍維持未確認，不把暫定方案轉成已核准需求。」
- C: 「這項修改不需要額外訪談或製作原型。」
- D: 「這是技術契約問題，可以直接檢查一致性與故障邊界，不需要先做使用者訪談。」
- E: 「產品已完成是可利用的驗證資產，沒有必要為了遵循流程重新製作原型。」

No response asked a long questionnaire or treated developer inference as an absent business user's confirmation. A and E each combined closely related context details into one scoping question; these were reviewed as one focal question rather than an exhaustive intake. B did not halt independent development. These results support the tested prompts only, not every possible conversation.

## Structural And Packaging Checks

- Existing official `quick_validate.py`: passed using PyYAML in an isolated temporary environment; no repository or global dependency added.
- Relative reference link resolves; unchanged `agents/openai.yaml` parses.
- Existing local installer with a temporary `CODEX_HOME`: every bundled file copied byte-identically, including the new reference; temporary installation removed on exit. The active skill installation was not overwritten. Remote archive download was not retested because installer behavior is unchanged.
- `git diff --check`: passed. No runtime/CI/security gate changes; no product E2E or real-user acceptance claimed.


## Discuss Continuation Check

After A, supplied: 「用 discuss 模式。現在個案打電話給承辦人，承辦人查空檔後回電。想先減少來回電話，但尚未訪談個案。」

Expected: reuse the known workflow/goal, retain unverified client acceptance, compare relevant options, and ask only the next decision-relevant question. Observed: passed. The response compared LINE collection of acceptable times with system-provided time selection, separated product walkthrough from engineering checks, and did not ask again how the current workflow worked. It ended with: 「目前承辦人回電時，通常還需要個案再次協調時段，還是只通知已確認的新時間？」 The question distinguishes coordination from notification and informs the next design choice. This exercises discuss without treating prior facts as missing or assuming full self-service approval.
