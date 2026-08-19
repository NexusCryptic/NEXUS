# ADAM 1000-Enhancement Matrix

The matrix is generated deterministically by `tools/generate_enhancement_matrix.py`.
It defines 1000 typed improvement slots across ten domains, five maturity levels,
and explicit verification/evidence requirements.

## Domains

1. provenance and continuity
2. repository and branch orchestration
3. path and artifact discovery
4. plugin and extension routing
5. local Android/Acode/Termux operation
6. provider adapters and model routing
7. symbolic/algebraic mathematics
8. field geometry/SDF/rendering
9. testing/verification/security
10. multilingual world-building and public applications

## Evolution contract

Every generated enhancement has:

`id → domain → objective → trigger → action → evidence → verification → rollback`

No enhancement may directly mutate production history without an explicit promotion step.

## Cycle

`pull → inspect → index → verify → propose → test → stage → commit → push → checkpoint → pull`

The cycle is bounded, idempotency-aware, and secret-free.
