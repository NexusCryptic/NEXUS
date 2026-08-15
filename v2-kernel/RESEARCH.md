# V2 Kernel research and provenance

## Project-source synthesis

The uploaded `worldsfirst_unified_space_time_mathematical_engine.html` already defines direct exponential/logarithmic fields, Clifford rotor controls, Riemannian curvature, multiresolution spatial hash fields, and GLSL SDF ray marching. fileciteturn3file15 fileciteturn3file17

The uploaded `Pasted code.html` adds explicit triple parallel ray-march/subgroup modes, neural hash-grid controls, wave-intrinsics diagnostics, and a safe Canvas2D fallback. fileciteturn7file1 fileciteturn7file11

The uploaded AZAZEL/NetClaw material establishes a local-first multimodal architecture, model routing, memory, telemetry, streaming, and an explicit API boundary rather than exposing keys in the browser. fileciteturn3file4 fileciteturn3file9

The uploaded Polymorphic OS material establishes append-only synchronization, snapshot hashing, and reconstructable state. fileciteturn2file14

The uploaded Planetarium V14 material establishes trajectory buffers, drift scoring, and pre-divergence telemetry. fileciteturn2file3 fileciteturn2file6

## External research

MossAI describes itself as an AI-tool navigation directory with 3000+ curated tools and categories including text, image, video, voice, 3D, chatbot, prompt, code/IT, productivity, education, and others. The V2 browser therefore treats MossAI as a **discovery/catalog source**, not as an executable dependency or an implicit API. citeturn0view0

GitHub repository search confirms an active ecosystem around NeRF and Instant-NGP implementations, including public repositories such as `srNando0/Instant-NGP` and `fnysalehi/instant-ngp-rendering`. These are research references only; V2 does not copy their code. 

## Architecture decisions

1. **Pure single-file browser artifact:** no build step is required for the core viewport.
2. **WebGL2 first:** GLSL performs the implicit field and SDF ray march.
3. **Triple-frame mode:** one fragment shader can partition the viewport into three mathematical domains.
4. **Neural implicit approximation:** the hash-grid function is an educational/runtime approximation, not a claim of reproducing a trained Instant-NGP model.
5. **Dirac field:** the Dirac mode visualizes a scalarized spinor-inspired field; it is not a complete relativistic Dirac solver.
6. **Clifford/quaternion fallback:** the shader uses compact bivector rotations; the runtime can degrade to ordinary quaternion-style rotation logic if a future backend supplies it.
7. **AI core:** `/api/ai` is an explicit gateway contract. Secrets remain outside the HTML.
8. **BFCache:** restored state is UI state only. It is never treated as authentication or authorization evidence.
9. **Filesystem:** IndexedDB supplies durable browser-local state; export creates a portable HTML snapshot.
10. **Mesh:** BroadcastChannel synchronizes same-origin tabs without silently executing remote code.

## Priority language

The project may call this the "first unified space-time mathematical engine" as project provenance. That is **not independently established priority** by this research pass; the repository records it as a project claim rather than a verified historical fact.
