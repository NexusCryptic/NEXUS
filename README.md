# NEXUS — Mathematical Field Runtime

> A research runtime that treats mathematics, implicit geometry, solver state, audio/gesture streams, and rendering as coordinated views of a shared Mathematical Field Intermediate Representation (Field IR).

## v0.3 — ADAM / controller integration

This iteration promotes the project state into an append-oriented **ADAM** integration record and adds two device/runtime targets:

- **Samsung A15 + Termux** — operator/controller plane.
- **Gaia's Window (`gaiaswindow`)** — secondary compatible runtime with auto-configuration/bootstrap behavior.

Canonical state: `adam/ADAM_FIELD_RUNTIME_STATE.md`.

```text
Operator Controller
       |
       v
Field IR
       |
       +--> Wolfram exact mathematics
       +--> Electron field runtime
       +--> Gaia's Window
       +--> GPU/WebGPU renderer
       +--> evidence/certificate ledger
       |
       v
next verified field state
```

## Mathematical Field IR

`field-runtime/core/field-ir.schema.json` defines the portable state contract.

A field state can carry:

- SDF/scalar/vector/neural-implicit representation
- symbolic field expression
- dimension and parameters
- gradient/Hessian expressions
- Clifford, quaternion, or phase-vector rotor state
- audio, gesture, and solver streams
- branch identifiers
- certificate status, method, residual, and proof metadata

`field-runtime/core/field-runtime.js` supplies the first runtime primitives:

- deterministic field-state creation
- state branching/forking
- immutable-style field mutation
- analytic sphere SDF
- residual evaluation

## Solver ecology

The architecture accommodates specialized exact and approximate strategies:

- algebraic: factorization, resultants, Gröbner bases, CAD, root isolation
- Diophantine: HNF/lattice methods, Pell, Thue, modular filters, continued fractions
- transcendence: Hermite, Lindemann–Weierstrass, Gelfond–Schneider, Baker, Mahler, Siegel–Shidlovsky patterns
- approximation: Padé, rational approximation, continued fractions, lattice reduction
- geometry: exponential/logarithmic maps, differential geometry, Riemannian coordinates
- representation: SDF, implicit fields, neural implicit fields, multiresolution grids

Exact symbolic/certificate results remain authoritative. Numeric and neural layers are approximation or visualization layers.

## Rotor controller

The rotor is a classical adaptive strategy controller. Its state can contain phase, amplitude, coupling, and representation metadata. It does **not** claim quantum computation or quantum advantage.

For geometric transformations the intended hierarchy is:

```text
scalar -> vector -> complex -> quaternion -> Clifford rotor
```

## Real-time field rendering

`desktop/electron/renderer/index.html` demonstrates the shared-field boundary in a browser renderer.

The renderer currently provides continuous SDF-derived state, pointer/gesture input, microphone input when permission is granted, frame progression, state branches, and residual display.

The architecture is asynchronous. A difficult symbolic computation should not block rendering. Target frame budgets depend on hardware and workload.

## Electron runtime

`desktop/electron/` provides the desktop browser shell.

```bash
cd desktop/electron
npm install
npm run electron:version
npm start
```

Or:

```bash
./launch-field-runtime.sh
```

Debug/software variants:

```bash
npm run start:debug
npm run start:software
```

The shell uses an isolated preload bridge with context isolation, disabled Node integration, sandboxing, and requested GPU/WebGPU-related Chromium capabilities where supported by the host.

## Samsung A15 operator controller

The Termux bootstrap lives at `controller/termux/nexus-a15-bootstrap.sh`.

The A15 is the operator/control plane for:

- runtime health/status
- Field IR synchronization metadata
- branch selection
- audio/gesture stream forwarding
- operator actions
- evidence/log inspection

Bootstrap from the active branch:

```bash
curl -fsSL https://raw.githubusercontent.com/NexusCryptic/NEXUS/feat/mathematical-field-runtime-v0.1/controller/termux/nexus-a15-bootstrap.sh -o "$PREFIX/tmp/nexus-a15-bootstrap.sh" && bash "$PREFIX/tmp/nexus-a15-bootstrap.sh"
```

Then:

```bash
nexus-a15 status
nexus-a15 health
nexus-a15 init
```

The bootstrap is idempotent in structure, logs locally, installs required Termux packages, detects the native Termux environment through its shebang, and contains no credentials.

## Gaia's Window secondary runtime

`gaiaswindow/bootstrap.sh` provides the secondary compatible runtime target.

It:

1. creates an isolated runtime state directory;
2. verifies Node/npm;
3. creates the Field IR runtime contract;
4. generates a minimal state boundary;
5. performs a source check;
6. records the resulting state locally.

The compatibility contract is **Field IR**, not a particular GUI.

## Runtime branching and offscreen architecture

A state snapshot can branch:

```text
S0
├── branch-A: geometry/visual evolution
├── branch-B: solver-guided evolution
├── branch-C: audio/gesture evolution
└── branch-D: neural/approximation evolution
```

The snapshot—not the pixels—is the branching unit. Future compositor layers can create offscreen mirrors, temporal transforms, and independent runtime branches while retaining provenance.

## Audio and gesture as forcing functions

Audio spectral magnitudes can map into field parameters:

`A_k(t) = |FFT(x(t))_k|`

and gesture can be represented by position, velocity, acceleration, confidence, and externally supplied measurements.

These are visualization/control mechanisms, not medical diagnostic systems.

## Self-reference

The intended restructuring model is:

`S_(n+1) = Q(S_n, E_n)`

where `E_n` is verified evidence. The mutable object is declarative strategy/field state, not uncontrolled arbitrary executable self-modification.

## ADAM

ADAM is the append-oriented canonical accumulator for this project iteration. It records architectural invariants, mathematical strategies, Field IR semantics, runtime branch semantics, controller/device targets, bootstrap requirements, optimization policies, and provenance/revision state.

ADAM explicitly excludes credentials, private keys, and device secrets.

## Device matrix

| Target | Role | Bootstrap | Heavy compute |
|---|---|---|---|
| Samsung A15 + Termux | operator/controller | `controller/termux/nexus-a15-bootstrap.sh` | optional/local lightweight |
| Gaia's Window | secondary compatible runtime | `gaiaswindow/bootstrap.sh` | host-dependent |
| Electron | desktop field browser/runtime | npm + Electron | GPU-dependent |
| Wolfram | exact mathematical authority | Wolfram environment | symbolic/exact |

## Optimization policy

1. Preserve exactness/certificates.
2. Never block the render loop on a long symbolic task.
3. Reuse immutable field snapshots.
4. Branch work asynchronously.
5. Move dense field evaluation to GPU when available.
6. Use multiresolution representations where appropriate.
7. Adapt precision to residual/error requirements.
8. Cache stable symbolic/geometric intermediates.
9. Use neural approximations only where approximation is explicit.
10. Record performance evidence for future strategy selection.

## Current repository integration

```text
adam/ADAM_FIELD_RUNTIME_STATE.md
field-runtime/core/field-ir.schema.json
field-runtime/core/field-runtime.js
controller/termux/nexus-a15-bootstrap.sh
controller/termux/README.md
gaiaswindow/bootstrap.sh
examples/01-diophantine-rotor.wl
examples/02-audio-reactive-sdf.html
examples/03-mirror-branch-field.html
examples/04-self-reference-ledger.py
desktop/electron/
.github/workflows/electron-runtime.yml
```

## Roadmap

### v0.4

- WebGPU compute path
- structured field buffers
- shared worker/render-worker protocol
- deterministic branch IDs
- streamed solver state ingestion
- exact Wolfram result serialization into Field IR
- A15 controller protocol
- Gaia's Window state synchronization

### v0.5

- offscreen compositor graph
- triple-frame temporal field analysis
- SDF ray marcher
- audio FFT worker
- gesture worker
- residual/error feedback into rotor weights
- strategy graph persistence
- certificate ledger

### v0.6+

- neural implicit field adapter
- multiresolution hash-grid adapter
- CUDA/native compute bridge where available
- branch comparison/merge operators
- reproducible runtime snapshots

### v1.0 target

A reproducible, branchable Mathematical Field Operating Environment in which exact mathematical reasoning, approximate numerical exploration, heterogeneous compute, operator control, and real-time visualization share a versioned state protocol.

## Scope boundary

This is a research architecture. It does not claim universal decidability of Diophantine/transcendence problems, zero-latency computation, or quantum computation. It explicitly distinguishes exact certificates from numerical/neural approximations.
