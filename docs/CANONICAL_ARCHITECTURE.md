<!--
Copyright © 2026 CrypticNews LLC. All rights reserved.
This provenance header does not replace the repository's applicable license.
-->

# Canonical Architecture

## Root

`NexusCryptic/NEXUS_Protocol` is the normative root for interfaces and governance. `NexusCryptic/NEXUS_CORE` is the intended implementation target. `NexusCryptic/The-Ledger` records evidence and lineage.

## Runtime graph

```text
                         ◈ NEXUS PROTOCOL
                                │
                                ▼
                         OMNIKERNEL⁹ CORE
                                │
       ┌────────────────────────┼────────────────────────┐
       │                        │                        │
   MEMORY FABRIC           EVENT MESH              GOVERNANCE
       │                        │                        │
       ▼                        ▼                        ▼
   THE-LEDGER             AI GATEWAY              REVIEW GATES
       │                        │
       └──────────────┬─────────┘
                      ▼
                 LIVING SYSTEM
                      │
      ┌───────────────┼────────────────┐
      ▼               ▼                ▼
 CARTOGRAPHER     DREAM ENGINE      RUNTIME
      │               │                │
      ▼               ▼                ▼
 PLANETARIUM      ARTIFACTS       PWA/DESKTOP
                      │
                      ▼
                 PUBLIC NEXUS
```

## Module contract

```text
Identity → Capability → Communication → Persistence → Telemetry → Reflection → Governance
```

## Convergence policy

Historical repositories remain historical repositories. Prototype branches remain prototypes until explicitly promoted. External repositories remain external. The architecture unites **interfaces and lineage**, not ownership claims or unrelated code.

## Current integration boundary

The connected GitHub account exposes a repository inventory containing private and public project repositories. The initial convergence pass has been intentionally limited to repositories that can be confidently associated with the main project structure. Repositories that are demo or unclassified are excluded until reviewed.

The connected Hugging Face account is used as a research boundary. Its current integration is read-oriented and does not silently publish project artifacts.
