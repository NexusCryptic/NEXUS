# NEXUS device bootstrap layer

## Samsung A15 / Termux

The Samsung A15 is the operator/controller plane. It owns control, status, synchronization metadata, streams, and operator actions; it is not required to perform the heaviest symbolic or GPU work.

Bootstrap:

```bash
curl -fsSL https://raw.githubusercontent.com/NexusCryptic/NEXUS/feat/mathematical-field-runtime-v0.1/controller/termux/nexus-a15-bootstrap.sh -o "$PREFIX/tmp/nexus-a15-bootstrap.sh" && bash "$PREFIX/tmp/nexus-a15-bootstrap.sh"
```

After bootstrap:

```bash
nexus-a15 status
nexus-a15 health
nexus-a15 init
```

The bootstrap is designed to be rerunnable, logs locally, detects the Termux environment through its shebang, and does not contain credentials.

## Gaia's Window

`gaiaswindow/bootstrap.sh` is the secondary compatible runtime bootstrap. It creates an isolated runtime state, verifies Node/npm, creates the Field IR state boundary, and runs a source check.

The shared contract is:

```text
field-ir-v0.3
```

This prevents the controller and secondary runtime from becoming coupled to one GUI implementation.

## Device relationship

```text
Samsung A15 / Termux
       |
       | operator state / control / streams
       v
NEXUS Field IR
       |
       +---- Wolfram exact solver
       +---- Electron field runtime
       +---- Gaia's Window secondary runtime
       +---- GPU/WebGPU field renderer
       +---- evidence/certificate ledger
```
