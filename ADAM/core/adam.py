"""ADAM 0.0.0: deterministic convergence kernel.

The kernel is intentionally provider-neutral. Providers are adapters; ADAM owns
state, provenance, routing, validation, and controlled evolution proposals.
"""
from __future__ import annotations
from dataclasses import dataclass, field, asdict
from hashlib import sha256
from pathlib import Path
import json, time

ORIGIN = (0, 0, 0)
SERIES = "The Ethernet"
IDENTITY = 'GaiaSSoul AN — "The CrypticNexus of Adam"'

@dataclass
class Event:
    kind: str
    payload: dict
    timestamp: float = field(default_factory=time.time)
    digest: str = ""
    def seal(self) -> str:
        body = json.dumps({"kind": self.kind, "payload": self.payload,
                           "timestamp": self.timestamp}, sort_keys=True)
        self.digest = sha256(body.encode()).hexdigest()
        return self.digest

@dataclass
class AdamState:
    origin: tuple = ORIGIN
    series: str = SERIES
    identity: str = IDENTITY
    generation: int = 0
    providers: dict = field(default_factory=dict)
    capabilities: set = field(default_factory=set)
    events: list = field(default_factory=list)

    def emit(self, kind: str, **payload) -> Event:
        event = Event(kind, payload)
        event.seal()
        self.events.append(asdict(event))
        self.generation += 1
        return event

    def propose(self, capability: str, reason: str, evidence: list[str] | None = None) -> Event:
        return self.emit("evolution.proposal", capability=capability,
                         reason=reason, evidence=evidence or [])

    def register_provider(self, name: str, endpoint: str = "") -> None:
        self.providers[name] = {"endpoint": endpoint, "enabled": True}
        self.emit("provider.registered", provider=name)

    def snapshot(self) -> dict:
        data = asdict(self)
        data["capabilities"] = sorted(self.capabilities)
        return data

    def save(self, path: Path) -> None:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(json.dumps(self.snapshot(), indent=2), encoding="utf-8")

def bootstrap() -> AdamState:
    state = AdamState()
    for provider in ("openai", "gemini", "huggingface", "ollama", "wolfram", "github"):
        state.register_provider(provider)
    state.capabilities.update({
        "provenance", "pathing", "ledger", "plugin-routing", "field-ir",
        "symbolic-solve", "numeric-solve", "sdf", "raymarch", "quaternion",
        "exponential-map", "neural-implicit", "android-operator", "git-automation",
        "controlled-evolution", "multilingual-interface"
    })
    state.emit("adam.bootstrap", origin=ORIGIN, series=SERIES)
    return state

if __name__ == "__main__":
    bootstrap().save(Path(".adam/state.json"))
