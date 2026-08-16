# NEXUS — Mathematical Field Runtime

> A research runtime that treats mathematics, implicit geometry, solver state, audio/gesture streams, and rendering as coordinated views of a shared Mathematical Field Intermediate Representation (Field IR).

## v0.2 integration pass

This iteration turns the earlier architecture into an executable integration boundary.

The central idea is:

```text
problem
  -> mathematical profiler
  -> exact/approximate strategy selection
  -> Mathematical Field IR
  -> field/rotor evolution
  -> GPU/browser rendering
  -> observation + residuals
  -> certificate
  -> strategy update
  -> next field state
```

The field is the common interface. The renderer does not merely display a solver result; both consume the same versioned state representation.

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

The architecture accommodates specialized exact and approximate strategies rather than pretending one algorithm solves every problem:

- algebraic: factorization, resultants, Gröbner bases, CAD, root isolation
- Diophantine: HNF/lattice methods, Pell, Thue, modular filters, continued fractions
- transcendence: Hermite, Lindemann–Weierstrass, Gelfond–Schneider, Baker, Mahler, Siegel–Shidlovsky patterns
- approximation: Padé, rational approximation, continued fractions, lattice reduction
- geometry: exponential/logarithmic maps, differential geometry, Riemannian coordinates
- representation: SDF, implicit fields, neural implicit fields, multiresolution grids

Exact symbolic/certificate results remain authoritative. Numeric and neural layers are approximation or visualization layers.

## Rotor controller

The rotor is a classical adaptive strategy controller. Its state can contain phase, amplitude, coupling, and representation metadata. A rotor does **not** claim quantum computation or quantum advantage; it is a mathematical state-space abstraction for selecting and blending computational strategies.

For geometric transformations the intended hierarchy is:

```text
scalar -> vector -> complex -> quaternion -> Clifford rotor
```

with quaternions serving as a compact spatial fallback and Clifford rotors providing the generalized geometric-algebra representation.

## Real-time field rendering

`desktop/electron/renderer/index.html` demonstrates the shared-field boundary in a browser renderer.

The renderer currently provides:

- continuous SDF-derived field state
- pointer/gesture input
- microphone amplitude/spectrum input when permission is granted
- frame state progression
- two state branches derived from a common snapshot
- live residual display
- browser Canvas rendering

The architecture is intentionally asynchronous. A difficult symbolic computation should not block rendering. Target frame budgets depend on actual hardware and pipeline load; this is not a zero-latency claim.

## Electron runtime

`desktop/electron/` provides a dedicated desktop browser shell prepared for the field runtime.

### Download/configure/run

```bash
cd desktop/electron
npm install
npm run electron:version
npm start
```

The first `npm install` downloads the pinned Electron major-version runtime declared in `package.json`.

For a bootstrap that installs Electron when missing and launches with the runtime flags:

```bash
./launch-field-runtime.sh
```

Useful variants:

```bash
npm run start:debug
npm run start:software
```

The shell uses an isolated preload bridge (`contextIsolation: true`, `nodeIntegration: false`, sandboxing) and requests GPU/WebGPU-related Chromium features where supported by the host build. Actual acceleration remains hardware/driver dependent.

## Runtime branching

A state can be forked:

```text
S0
├── branch-A: geometry/visual evolution
├── branch-B: solver-guided evolution
└── branch-C: audio/gesture evolution
```

Each branch receives the same state boundary and can evolve independently. Later versions can add deterministic merge operators and state-difference metrics.

## Offscreen/mirror architecture

The next rendering layer can maintain:

```text
Field State
   |
   +--> Renderer A
   |
   +--> Offscreen Renderer B
   |
   +--> Transformed Mirror C
   |
   +--> Neural/implicit approximation D
            |
            +--> compositor
```

The important unit is the state snapshot rather than the pixels. This allows branches to become separate computational runtimes and makes streamed data pipelines composable.

## Audio and gesture as forcing functions

A future audio layer can map spectral bands into field parameters:

`A_k(t) = |FFT(x(t))_k|`

and construct a field such as:

`f_audio = f_base + A_bass S_scale + A_mid S_rotation + A_high S_detail`

Gesture can similarly be represented as a vector/time state containing position, velocity, acceleration, confidence, and optional externally supplied measurements.

These mappings are visualization/control mechanisms, not medical diagnostic systems.

## Self-reference without uncontrolled self-modification

The intended self-restructuring model is:

`S_(n+1) = Q(S_n, E_n)`

where `E_n` is verified evidence. The source/runtime should not arbitrarily rewrite executable code. Instead, the evolving object is a declarative strategy/field state that can be compiled into deterministic runtime components.

The durable loop is:

```text
State
 -> compute
 -> observe
 -> verify
 -> record evidence
 -> update strategy graph
 -> produce next state
```

This preserves provenance and keeps approximation separate from proof.

## Examples

- `examples/01-diophantine-rotor.wl` — exact Wolfram Diophantine reduction wrapped in rotor strategy state.
- `examples/02-audio-reactive-sdf.html` — browser field demonstration with microphone-driven modulation.
- `examples/03-mirror-branch-field.html` — branch/mirror visualization model.
- `examples/04-self-reference-ledger.py` — evidence-driven self-reference ledger.

## Electron CI

`.github/workflows/electron-runtime.yml` downloads the Electron runtime with npm, verifies the Electron executable version, and syntax-checks the desktop main/preload sources on pushes and pull requests affecting the runtime.

## Roadmap

### v0.3

- WebGPU compute path
- structured field-buffer layout
- shared worker/render-worker protocol
- deterministic branch IDs
- streamed solver state ingestion
- exact Wolfram result serialization into Field IR

### v0.4

- offscreen compositor graph
- triple-frame temporal field analysis
- SDF ray marcher
- audio FFT worker
- gesture worker
- residual/error feedback into rotor weights

### v0.5

- strategy graph persistence
- certificate ledger
- neural implicit field adapter
- multiresolution hash-grid adapter
- CUDA/native compute bridge where available

### v1.0 target

A reproducible, branchable Mathematical Field Operating Environment in which exact mathematical reasoning, approximate numerical exploration, heterogeneous compute, and real-time visualization share a versioned state protocol.

## Scope boundary

This is a research architecture. It does not claim universal decidability of Diophantine/transcendence problems, zero-latency computation, or quantum computation. It explicitly distinguishes exact certificates from numerical/neural approximations.
