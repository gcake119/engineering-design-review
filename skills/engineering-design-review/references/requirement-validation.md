# Requirement Discovery And Validation

Read for feature-led proposals or uncertainty about real work, business rules, users, or feedback. This extends the existing first-principles analysis and scan/discuss/decide modes; it is not a separate product-management or research process.

## Work Backward From The Feature

1. **What feature is proposed?** Record the solution hypothesis, known constraints, and design premises. Keep the user's feature-led starting point.
2. **What work problem should it solve?** Identify who uses it, in what situation, the job to complete, the current workaround, its difficulty, and why this feature might improve it. Derive tentative answers from supplied evidence; label missing answers instead of inventing needs.
3. **How will we know it is useful?** Identify the assumption that most changes the investment decision, an observable outcome, and the cheapest sufficient way to learn. Ask only the highest-impact unresolved question now, reusing prior answers rather than repeating an intake questionnaire.

An explicit request for a self-rescheduling feature is evidence of the request. It does not establish that clients want it, that approval is unnecessary, or that cancellation, payment, and availability rules are agreed.

## Track Evidence Separately From Status

For material items, keep a compact note or table: **claim/requirement | evidence kind and source | confirmation status | decision impact**. Scale this to the task; do not create a mandatory registry.

Evidence kinds:

- Observed fact: supplied records or observed behavior, with its context and limits.
- Explicit user request/confirmation: what the relevant person actually requested or approved, and for which role/scope. A developer can state their own goal without representing an absent business user's approval.
- Developer/AI inference: a plausible interpretation, clearly attributed and still open to correction.
- Unvalidated business assumption: a belief about workflow, rules, or value without sufficient supporting evidence.

Confirmation states:

- **Confirmed:** sufficient relevant evidence or confirmation from the necessary user/decision owner for the stated scope. Explain the basis; technical correctness alone does not establish usefulness.
- **Pending validation:** mainly inference, limited evidence, or a solution whose usefulness remains uncertain.
- **Major unresolved:** different plausible answers materially change workflow, architecture, or data design. Identify the affected decision and who or what can resolve it.

A major unresolved item remains unresolved when the owner is silent. In decide mode, record a conditional recommendation, reversible experiment, or explicit deferral; do not turn silence into an approved specification. New relevant evidence may revise a previous status.

## Match Validation To The Unknown

**Product validation** asks whether a feature solves a real work problem. **Engineering verification** asks whether implementation behaves correctly and reliably against its specification. Plan and report them separately; neither substitutes for the other.

| Unknown or situation | Proportionate next step | Evidence sought |
| --- | --- | --- |
| Current work/problem unclear | Workflow conversation or observe current tools | Actual tasks, workarounds, exceptions, and pain |
| Information layout or wording unclear | Static screen with a concrete work scenario | Can the user interpret it and choose the next action? |
| New interaction, multi-role handoff, or uncertain operation | Interactive prototype and task-based walkthrough | Can relevant roles complete realistic tasks and handle exceptions? |
| Workflow value or operational fit uncertain | Bounded pilot or actual-use observation | Whether it helps in real work, including burden and failure recovery |
| Product already implemented, no real users yet | Recruit relevant trial users and use the existing product for task-based sessions or a bounded pilot | Real workflow fit and remaining product assumptions; rebuild a prototype only for a specific gap |
| Confirmed requirement, local low-risk fix, or technical-only contract review | Proceed with focused engineering design and verification | Correct observable behavior or contract; no compulsory discovery cycle |

Choose depth from new workflow exposure, unconfirmed rules, multiple roles, interaction uncertainty, cost of a wrong design, existing real-use evidence, and reversibility. High uncertainty plus expensive rework favors a cheap prototype or work-scenario check first. The number of roles alone is not a reason to demand a prototype if adequate evidence already exists.

For the selected check, say which assumption it tests, whose task/context matters, the observable success or failure signal, and how the result changes the decision. Avoid arbitrary sample sizes or claiming a simulated walkthrough is real user evidence. A polished interface is not evidence of value.

## Bound Engineering Investment

- Confirmed requirements with sufficient evidence: proceed with normal engineering review and relevant tests.
- Pending validation: recommend the smallest learning step and reversible implementation boundary. Separate safe independent work from assumption-dependent work.
- Major unresolved: defer the affected costly or irreversible commitment; name the dependency and what would unblock it. Continue unrelated confirmed work.
- When external users are unavailable: prepare a concrete scenario, screen/prototype or existing-product session for their next opportunity. Mark proxy feedback as limited evidence, keep decisions conditional, and define a review point rather than silently treating them as accepted.
- Existing full implementation is an asset for validation, not proof of product fit. Avoid further speculative feature investment until evidence justifies it; do not require discarding or rebuilding working software.

## Fit The Existing Modes And Report

- **scan:** surface the proposed feature, likely work problem (mark inference), material evidence/status gaps, and a proportionate validation/investment recommendation alongside engineering blind spots. Cross-domain options remain candidates, not confirmed needs.
- **discuss:** explore one high-impact uncertainty at a time; compare only relevant validation or design choices. Do not repeat already supplied facts.
- **decide:** summarize supported decisions, conditional/deferred ones, product validation, engineering verification, and what can proceed. Convert confirmed observable behavior into acceptance criteria/tests; label exploratory criteria as provisional rather than approved requirements.

Lead with the recommendation and why. For requirement-sensitive work, show only the material evidence/status items, the two kinds of validation, the engineering scope/dependencies, and the next action or single question. Keep purely engineering reports on their existing path.
