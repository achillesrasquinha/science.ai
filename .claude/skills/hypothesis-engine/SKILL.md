---
name: hypothesis-engine
description: "Generate genuinely novel, falsifiable scientific hypotheses for any domain using a 3-layer epistemological engine with real-time literature verification, mathematical scoring, iterative refinement via subagents, and cross-domain bridge detection. Invoke with /hypothesis [TOPIC]. Triggers: 'hypothesis', 'generate hypotheses', 'novel questions', 'scientific hypothesis generation', 'what are the open problems in X', 'generate research questions for X'."
version: 3.0.0
tags: [science, hypothesis, research, discovery, epistemology, novel, cross-domain, verified]
---

# Universal Scientific Hypothesis Engine v3 — Platinum Standard

Generate genuinely novel, unknown, falsifiable hypotheses for **any** branch of science — then **verify** them against the live literature and **refine** them iteratively until they are publication-grade.

## When to invoke

- User types `/hypothesis [TOPIC]`
- User asks: "Generate hypotheses about X", "What are novel open problems in X?", "What research questions exist for X?"
- User wants genuinely novel, not-yet-published research directions

## Input

`$ARGUMENTS` — the scientific topic, domain, phenomenon, or question.

If `$ARGUMENTS` is empty, ask the user for a topic before proceeding.

---

## ARCHITECTURE OVERVIEW

This engine operates in **5 phases** with tool-augmented verification and subagent-based parallelism:

```
PHASE 1: LANDSCAPE  ─── Domain classification + decomposition + live literature scan
PHASE 2: GENERATE   ─── 11 parallel generation engines + epistemic type engines
PHASE 3: VERIFY     ─── Real-time novelty verification against literature + knowledge graphs
PHASE 4: SCORE      ─── Mathematical scoring with information-theoretic measures
PHASE 5: REFINE     ─── Iterative adversarial refinement loop (2-3 cycles)
         OUTPUT     ─── Final ranked hypotheses with full provenance
```

---

## PHASE 1: LANDSCAPE INTELLIGENCE

### Step 1.1 — Domain Classification

Route the topic to its epistemic family(ies):

| ID | Family | Reasoning Style | Examples |
|----|--------|----------------|---------|
| F | FORMAL | Proof, counterexample, generalization | Math, Logic, Theoretical CS |
| P | PHYSICAL | Symmetry, conservation, effective theory | Physics, Chemistry, Astronomy |
| L | LIFE | Tinbergen 4-questions, evolution, emergence | Biology, Medicine, Ecology |
| S | SOCIAL | Causal identification, reflexivity, WEIRD check | Psychology, Economics, Sociology |
| H | HISTORICAL | Trace reasoning, uniformitarianism, contingency | Paleontology, Archaeology, Cosmology |
| A | APPLIED | Design space, failure modes, optimization | Engineering, Biotech, Clinical |
| C | COMPUTATIONAL | Simulation as experiment, epistemic opacity | Comp. Bio/Physics/Chemistry |

Topics may span multiple families — activate ALL relevant ones.

Identify 2-3 **adjacent domains** outside the primary classification with structural similarity (these are cross-domain bridge sources).

State the classification explicitly before proceeding.

### Step 1.2 — Live Literature Scan

**MANDATORY TOOL USE.** Before any reasoning, ground yourself in the current state of the field.

Use the **life-science MCP server** (`mcp__life-science__callTools`) with the `literature/search` endpoint to perform a federated search across PubMed, Semantic Scholar, OpenAlex, Europe PMC, CrossRef, and bioRxiv simultaneously:

```
Query 1: [TOPIC] + "review" or "meta-analysis" (last 3 years) — get the lay of the land
Query 2: [TOPIC] + "novel" or "unexplored" or "paradox" or "contradiction" — find anomalies
Query 3: [TOPIC] + "open question" or "future direction" or "remains unknown" — find stated gaps
```

If the topic involves biological entities, also query domain knowledge graphs:
- `protein/interactions` for protein-protein interaction networks
- `pathway/profile` for pathway knowledge (Reactome, KEGG, GO)
- `disease/profile` for gene-disease associations (OMIM, Open Targets)
- `compound/profile` for drug/compound data (PubChem, ChEMBL)

Use `mcp__life-science__findTools` to discover additional relevant endpoints for the specific topic.

For non-life-science topics, use **WebFetch** to query:
- arXiv API (`http://export.arxiv.org/api/query`) for physics/CS/math preprints
- Semantic Scholar API (`https://api.semanticscholar.org/graph/v1/paper/search`) for broad coverage

**Record what you find.** The literature scan output feeds directly into Steps 1.3 and 1.4.

### Step 1.3 — Landscape Decomposition

Build the domain-appropriate decomposition matrix:

**LIFE sciences** — Tinbergen 4×N:

| Level | Mechanism | Ontogeny | Function | Phylogeny |
|-------|-----------|----------|----------|-----------|
| Molecular | | | | |
| Subcellular | | | | |
| Cellular | | | | |
| Tissue/Organ | | | | |
| Organism | | | | |
| Population | | | | |
| Ecosystem | | | | |

**PHYSICAL sciences** — Symmetry × Scale:

| Scale | Symmetries | Conserved Quantities | Known Anomalies | Effective Theories |
|-------|-----------|---------------------|----------------|-------------------|
| Quantum | | | | |
| Mesoscopic | | | | |
| Macroscopic | | | | |
| Cosmological | | | | |

**SOCIAL sciences** — Level × Method:

| Level | Experimental | Observational | Interpretive | Computational |
|-------|-------------|--------------|-------------|--------------|
| Individual | | | | |
| Group | | | | |
| Institutional | | | | |
| Societal | | | | |

**FORMAL sciences** — Structure × Property:

| Structure | Known properties | Open conjectures | Computational status |
|-----------|-----------------|-----------------|---------------------|

**HISTORICAL** — Time × Trace × Process.
**APPLIED** — Design space: requirements, constraints, failure modes.
**COMPUTATIONAL** — Model assumptions × Validation status × Emergent behavior.

For each cell:
- If knowledge exists: one sentence with citation from Step 1.2.
- If **empty or sparse**: mark **[GAP]** — primary hypothesis target.
- If **contradictory findings**: mark **[CONTRADICTION]** — highest-priority target.

### Step 1.4 — Assumption Inventory & Frontier Scan

**Assumption Inventory** — List 10 foundational assumptions. For each:
- State explicitly
- Rate evidential support: STRONG / MODERATE / WEAK / UNTESTED
- Note whether directly tested or inherited consensus
- Flag assumptions that literature from Step 1.2 suggests are weakening

**Frontier Scan** — From the literature results, identify:
- Known open problems (cited as such in recent reviews)
- New technologies and what they unlock (last 5 years)
- Known anomalies (reproducible but unexplained observations)
- High-heterogeneity meta-analyses (I² > 75% suggests unresolved disagreement)

---

## PHASE 2: PARALLEL HYPOTHESIS GENERATION

### Subagent Architecture

Launch **3 parallel subagents** (using the Agent tool), each responsible for a subset of generation engines. This prevents context exhaustion and enables genuine parallelism.

**Subagent A — Anomaly & Contradiction Engines:**
Pass the landscape decomposition, contradiction list, and assumption inventory. Run:
1. **Abduction Engine** (Peirce) — Find the most surprising observation from Step 1.2. Ask: "What mechanism, if it existed, would make this unsurprising?"
2. **Contradiction Miner** — For each [CONTRADICTION] from Step 1.3, propose a hidden variable or mechanism that resolves it. Each resolution = candidate hypothesis.
3. **Assumption Inverter** — Take the 3 weakest-rated assumptions. Invert each completely. Derive testable predictions from the inversion.

**Subagent B — Bridge & Analogy Engines:**
Pass the topic, adjacent domains, and literature scan results. Run:
4. **Swanson ABC Bridge Detector** — Search for A-B-C bridges: Literature A (topic) → intermediate concept B → unrelated literature C. The A-C connection is the hypothesis. Use `literature/search` to verify the A-C link is genuinely undocumented.
5. **Cross-Domain Analogy Engine** (Gentner structure-mapping) — Map relational structure from a well-understood domain outside the topic. Neutral analogy elements = candidates. Prioritize mapping **relations of relations** (higher-order structure), not surface features.
6. **Knowledge Graph Link Predictor** — Identify entity pairs connected by ≤2 hops in domain knowledge graphs. Find triangles where A→B→C exists but A→C is undocumented. Use `protein/interactions`, `pathway/profile`, or equivalent KG endpoints to check.
7. **Technology Frontier Scanner** — From Step 1.4, generate: "With [new tech], we can now ask [question] that was previously blocked by [limitation]."

**Subagent C — Negative Space & Epistemic Engines:**
Pass the decomposition matrix, blind spot analysis, and epistemic type classification. Run:
8. **Negative Space Exploiter** — Systematically scan 7 blind spot types:
   (1) Taxonomic — model organisms/systems only?
   (2) Scale — one organizational level only?
   (3) Temporal — one timescale only?
   (4) Geographic/demographic — one population only?
   (5) Methodological — one technique only?
   (6) Technological — what's newly measurable?
   (7) Paradigmatic — what questions are "not asked here"?
9. **Consilience Detector** (Whewell) — Check if independent evidence lines from different methods/domains converge on an unexplored hypothesis.
10. **Epistemic Type Engines** — Run the domain-specific reasoning strategies activated in Step 1.1:
    - **LIFE**: Evolutionary reasoning (adaptation, mismatch, constraint, convergence, trade-off, drift), multi-scale emergence, systems biology (network topology, synthetic lethality, feedback loops, bistability), Levins tradeoff
    - **PHYSICAL**: Symmetry analysis, thought experiments, effective theory/scale separation, conservation law mining, dimensional analysis, unification seeking
    - **SOCIAL**: Causal identification strategy, Verstehen/interpretive access, reflexivity check, WEIRD bias probe, replication stress test
    - **HISTORICAL**: Uniformitarian reasoning, trace-to-event inference, catastrophe-gradualism spectrum, phylogenetic reasoning, contingency vs. convergence
    - **FORMAL**: Proof construction, counterexample search, generalization/specialization, axiom sensitivity
    - **APPLIED**: Design space exploration, failure mode analysis, optimization under constraints, scale-up assessment
    - **COMPUTATIONAL**: Simulation as experiment, emergent computation, epistemic opacity
11. **Diversity Enforcer** — After collecting candidates, cluster by semantic similarity. If >30% of candidates fall in one cluster, force-generate alternatives from underrepresented engines and blind spot types. (Mitigates LLM mode collapse per Si et al. 2024.)

Each subagent returns its candidate hypotheses with:
- One-sentence statement
- Source engine(s)
- Key reasoning chain
- Initial novelty assessment

### Mandatory Multiplicity (Chamberlin/Platt)

Each engine must produce ≥1 candidate. The raw pool should contain 30-80 candidates across all subagents. Never output a single hypothesis without alternatives.

---

## PHASE 3: REAL-TIME NOVELTY VERIFICATION

**This is the critical differentiator.** Every candidate hypothesis must be verified against the live literature before scoring.

### Step 3.1 — Federated Literature Check

For EACH candidate hypothesis, construct a targeted search query combining the hypothesis's key entities, proposed mechanism, and predicted relationship. Run via `literature/search`:

```
Query: "[entity A] AND [entity B] AND [proposed relationship/mechanism]"
```

Classify each candidate:
- **NOVEL** — No published work found connecting these entities via this mechanism. Proceed to scoring.
- **PARTIALLY KNOWN** — Some elements are known, but the specific combination or mechanism is new. Note what's known, what's new. Proceed with adjusted novelty score.
- **ALREADY PUBLISHED** — The hypothesis (or a substantially similar one) exists in published literature. **DISCARD** and note the citation.
- **PREPRINT ONLY** — Exists as a preprint but not peer-reviewed. Flag as "concurrent discovery" — still valuable but lower novelty score.

### Step 3.2 — Knowledge Graph Check

For hypotheses involving biological/chemical entities, verify whether the proposed relationship already exists in structured databases:

- `protein/interactions` — Is this protein-protein interaction already documented in STRING/IntAct/BioGRID?
- `pathway/profile` — Does this pathway connection already exist in Reactome/KEGG?
- `disease/profile` — Is this gene-disease association known in Open Targets/OMIM?
- `compound/profile` — Is this drug-target interaction documented in ChEMBL/PubChem?

A hypothesis proposing a relationship that exists in KGs is NOT novel at the mechanistic level (even if no paper explicitly states it).

### Step 3.3 — Citation Network Gap Confirmation

For the top candidates that pass Steps 3.1-3.2, use `europepmc/getCitations` or `opencitations/getCitations` to map the citation landscape. Confirm that the two literatures being bridged genuinely don't cite each other (validating the Swanson ABC premise).

---

## PHASE 4: MATHEMATICAL SCORING

Score each verified hypothesis on 7 dimensions using formal measures where possible, qualitative judgment where necessary.

### Dimension 1: NOVELTY (weight: 0.25)

**Formal measure: Information Content**
```
IC(H) = -log₂(P(H))
```
Where P(H) is estimated from literature search hit frequency:
- 0 hits for the specific mechanism → IC ≈ maximum (score 9-10)
- 1-3 hits tangentially related → IC high (score 7-8)
- 4-10 hits with partial overlap → IC moderate (score 5-6)
- 10+ hits or direct match → IC low (score 1-4)

Also assess: **Knowledge graph distance** — if the hypothesis connects entities that are ≥3 hops apart in existing KGs, novelty is higher.

### Dimension 2: SIGNIFICANCE (weight: 0.20)

**Measure: Paradigm Impact Assessment** (Kuhn + Lakatos)
- 9-10: Would require restructuring the field's core assumptions (paradigm shift)
- 7-8: Would open a new subfield or unify previously disconnected phenomena
- 5-6: Would resolve an important open question within the existing paradigm
- 3-4: Would extend current knowledge incrementally
- 1-2: Narrow confirmation of existing expectations

### Dimension 3: FALSIFIABILITY (weight: 0.20)

**Formal measure: Prediction Count × Specificity**
```
F(H) = N_predictions × mean(Specificity_i)
```
Where:
- N_predictions = number of distinct, independent testable predictions
- Specificity_i = (outcomes prohibited by H) / (total possible outcomes) for prediction i

Score:
- 9-10: ≥3 specific predictions, each prohibiting >50% of possible outcomes
- 7-8: 2 specific predictions with clear falsification criteria
- 5-6: 1 specific prediction or multiple vague ones
- 1-4: No clear falsification criteria achievable with current methods

### Dimension 4: EXPECTED INFORMATION GAIN (weight: 0.15)

**Formal measure: Bayesian Expected Information Gain**
```
EIG(H) = E_y[D_KL(P(θ|y) || P(θ))]
```
Approximated as: How much would testing this hypothesis change our beliefs regardless of the outcome?
- 9-10: Testing would resolve a fundamental ambiguity; ANY outcome is highly informative
- 7-8: Testing would substantially update beliefs in at least one direction
- 5-6: Testing would be informative only if the hypothesis is confirmed
- 1-4: Testing would tell us little either way

### Dimension 5: TRACTABILITY (weight: 0.10)

**Measure: Feasibility Assessment**
- 9-10: Testable within 6 months with existing data/tools by a single researcher
- 7-8: Testable within 1-2 years with standard lab equipment and moderate funding
- 5-6: Testable within 3-5 years requiring specialized equipment or large cohorts
- 3-4: Requires technology that doesn't yet exist or funding >$10M
- 1-2: No clear experimental path

### Dimension 6: COHERENCE (weight: 0.05)

**Formal measure: Thagard's Explanatory Coherence (ECHO)**
Assess constraint satisfaction:
- (+) Explains existing observations
- (+) Analogous to well-established theories
- (-) Contradicts accepted findings without accounting for them
- (-) Requires ad hoc auxiliary assumptions

Score = net positive constraints / total constraints, scaled 0-10.

### Dimension 7: PROGRESSIVE CHARACTER (weight: 0.05)

**Measure: Lakatos Progressiveness**
Does this hypothesis open NEW predictive territory beyond the phenomenon it was designed to explain?
- 9-10: Generates ≥3 novel predictions in adjacent areas
- 5-8: Generates 1-2 adjacent predictions
- 1-4: Explains only the target phenomenon

### Composite Score Calculation

```
COMPOSITE = (Novelty × 0.25) + (Significance × 0.20) + (Falsifiability × 0.20) 
          + (EIG × 0.15) + (Tractability × 0.10) + (Coherence × 0.05) 
          + (Progressive × 0.05)
```

### Null Hypothesis Challenge (Mandatory Gate)

**BEFORE finalizing any score**, generate the strongest null alternative for each candidate:

1. "The association is entirely explained by confound Z"
2. "The mechanism is not necessary; the phenotype persists without it"
3. "The effect is an artifact of measurement method M"
4. "The result is within expected statistical fluctuation"
5. "The observed pattern is explained by known mechanism K without invoking anything new"

If the null is sufficient and parsimony favors it → **DISCARD** the candidate regardless of composite score.

This step compensates for documented LLM null-hypothesis suppression bias (Bao et al. 2026, Si et al. 2024).

---

## PHASE 5: ITERATIVE ADVERSARIAL REFINEMENT

Run **2-3 refinement cycles**. Each cycle:

### Cycle Structure

**5A. Red Team Attack** — For each top-10 hypothesis, generate the strongest possible objections:
- What is the most obvious confound?
- What existing work most closely resembles this? (Re-query literature if needed.)
- What is the weakest link in the proposed mechanism?
- Would a domain expert dismiss this as naive? Why?
- Is the proposed experiment actually feasible? What could go wrong?

**5B. Refinement Response** — For each objection that has merit:
- Refine the hypothesis statement to address it
- Add specificity to the falsification test
- Adjust the mechanism to account for the objection
- If the objection is fatal → discard and promote next candidate

**5C. Re-Verification** — After refinement, re-run a targeted literature search on the refined hypothesis to ensure the refinement didn't accidentally converge on known work.

**5D. Re-Score** — Update scores based on refinement. Note score changes.

### Diversity Check

After refinement, verify the final set hasn't collapsed to a single cluster. The top hypotheses should span:
- ≥2 different generation engines
- ≥2 different scales or levels of organization
- At least 1 cross-domain bridge hypothesis

If diversity is insufficient, force-promote the highest-scoring hypothesis from an underrepresented engine.

---

## OUTPUT FORMAT

### Preamble

```
## Hypothesis Engine v3 — [TOPIC]
**Domain classification:** [families activated]
**Literature grounding:** [N papers scanned, key reviews cited]
**Candidates generated:** [N raw] → [N after verification] → [N after refinement]
**Refinement cycles:** [N]
```

### For each ranked hypothesis (top 10, or fewer if pool is small):

```
## Hypothesis [Rank] — Composite: [X.XX]

### [One-sentence hypothesis statement]

**Full statement:** [Specific, falsifiable — one paragraph max]

**Source engines:** [Which engines generated this + one-sentence reasoning chain]

**Literature verification:**
- Search queries used: [list]
- Results: [NOVEL / PARTIALLY KNOWN — what's known, what's new]
- Closest existing work: [citation if any, with distance assessment]
- KG check: [which databases queried, relationship status]

**Scoring breakdown:**
| Dimension | Score | Justification |
|-----------|-------|---------------|
| Novelty (IC) | X/10 | [lit search hits, KG distance] |
| Significance | X/10 | [paradigm impact level] |
| Falsifiability | X/10 | [N predictions × specificity] |
| Expected Info Gain | X/10 | [EIG assessment] |
| Tractability | X/10 | [time, cost, team, tech] |
| Coherence (ECHO) | X/10 | [+/- constraints] |
| Progressive | X/10 | [adjacent predictions] |
| **Composite** | **X.XX** | **(calculation shown)** |

**Falsification tests:**
1. [Specific experiment/observation that disproves this]
2. [Second independent test if available]

**Null alternative:** [Most parsimonious boring explanation + how to distinguish from hypothesis]

**Refinement history:** [What changed across cycles, if anything]
```

### Meta-Analysis (after ranked list)

**Pattern detection** — Do top hypotheses cluster around a specific gap, scale, engine, or blind spot? Clustering → deeper structural unknown.

**Cross-domain bridges** — Flag hypotheses connecting two domains. These are highest-novelty, highest-risk.

**Paradigm vulnerability** — What single finding, if confirmed, would most destabilize the current paradigm?

**Methodological critique** — Systematic biases in how this topic is studied? (Streetlight effect, model organism bias, WEIRD bias, publication bias, technology-driven bias, funding-driven bias)

**Second-order questions** — What does this analysis reveal about the methodology of studying [TOPIC] itself?

**Confidence calibration** — For top 3 hypotheses:
- P(genuinely novel — not already published): based on literature verification
- P(testable within 3 years): based on tractability assessment
- P(correct if tested): honest estimate acknowledging base rates for novel hypotheses (~10-30%)

---

## HARD CONSTRAINTS

Non-negotiable. Violating any makes the output worthless.

1. **VERIFY BEFORE CLAIMING NOVEL.** Every hypothesis must pass Phase 3 literature/KG verification. "I believe this is novel" is not sufficient — show the search results.

2. **NO INCREMENTALISM.** Reject "study X in a larger cohort", "replicate Y in another model", "extend Z to a new dataset" unless there is a specific novel prediction.

3. **NO UNFALSIFIABILITY.** Every hypothesis must specify what observation would disprove it.

4. **NO CORRELATION-AS-CAUSATION.** If proposing a causal link, specify the mechanism or identification strategy.

5. **PREFER UNIFICATION.** Hypotheses connecting previously disconnected phenomena rank higher.

6. **PREFER INVERSION.** Hypotheses challenging existing assumptions rank higher than those extending them.

7. **FORCE NULL ALTERNATIVES.** Every candidate must survive a null challenge. If the null suffices → discard.

8. **RESPECT DOMAIN EPISTEMOLOGY.** Use the epistemic type module appropriate to the domain.

9. **FLAG CROSS-DOMAIN BRIDGES.** Highest-novelty but highest-risk.

10. **NO KNOWN HYPOTHESES DRESSED AS NOVEL.** If literature verification finds prior art, acknowledge it and score accordingly. Do not present established ideas as new.

11. **DEPTH OVER BREADTH.** A hypothesis with a specific mechanism, specific prediction, and verified novelty is worth 10 vague ones.

12. **MANDATORY DIVERSITY.** Final output must span ≥2 generation engines and ≥2 scales. Mode collapse = engine failure.

13. **SHOW YOUR WORK.** Literature search queries, KG queries, and their results must be shown for each hypothesis. The user must be able to verify your novelty claims.

---

## TOOL REFERENCE

### Primary (life-science MCP)
- `mcp__life-science__callTools` — Execute endpoints (literature/search, protein/interactions, pathway/profile, disease/profile, compound/profile, etc.)
- `mcp__life-science__findTools` — Discover endpoints by keyword

### Secondary (web)
- `WebFetch` — Fetch public web content (arXiv API, Semantic Scholar API, specific paper pages)

### Subagents
- Use `Agent` tool to launch parallel generation subagents (Phase 2) and parallel verification subagents (Phase 3) when the candidate pool is large

---

## PROVENANCE

This engine synthesizes:
- **Peirce** (abduction, economy of research, uberty)
- **Chamberlin** (multiple working hypotheses, 1897)
- **Platt** (strong inference, 1964) + **Jewett** (strong inference plus, 2005)
- **Popper** (falsifiability, risky predictions)
- **Kuhn** (paradigm analysis, anomaly exploitation, five criteria)
- **Lakatos** (research programmes, progressive vs. degenerative)
- **Tinbergen** (four questions in biology)
- **Swanson** (literature-based discovery, ABC model)
- **Whewell** (consilience of inductions)
- **Thagard** (explanatory coherence, ECHO constraint satisfaction)
- **Gentner** (structure-mapping theory of analogy)
- **Holyoak & Thagard** (multiconstraint theory of analogy)
- **Anderson** ("More Is Different" — emergence across scales)
- **Weber/Habermas** (Verstehen, interpretive access)
- **Levins** (realism/generality/precision tradeoff)
- **Shannon** (information theory, channel capacity)
- **Kullback-Leibler** (divergence as novelty/surprise measure)
- **Lindley** (expected information gain for experimental design)
- **Bao et al. 2026** (null hypothesis suppression in LLMs)
- **Si, Yang & Hashimoto 2024** (LLM ideas: more novel, less feasible, mode collapse)
- **Tong et al. 2024** (causal KG + LLM outperforms LLM alone)
- **Wang et al. 2024 / SciMON** (iterative novelty optimization)
- **Baek et al. 2025 / ResearchAgent** (iterative refinement via reviewing agents)
- **Lu et al. 2024 / AI Scientist** (end-to-end discovery)
- **Qiu et al. 2024** (rule induction vs. application gap in LLMs)
- **Klahr & Dunbar** (dual-space model of scientific discovery)
- **BFO/OBO Foundry** (ontology interface for domain modules)
