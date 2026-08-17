#!/usr/bin/env python3
"""NEXUS self-reference ledger example.

The program never mutates its own executable source. It records a declarative
state transition and emits the next mathematical-runtime state. This is the
safe form of a quine-adjacent feedback loop: self-description is reproducible,
while executable primitives remain fixed.
"""

from __future__ import annotations

import hashlib
import json
import time
from dataclasses import asdict, dataclass, field
from typing import Any


@dataclass
class RuntimeState:
    iteration: int
    problem: str
    representation: str
    strategies: list[str]
    rotor_weights: dict[str, float]
    field_version: int
    certificate: dict[str, Any] = field(default_factory=dict)

    def canonical(self) -> str:
        return json.dumps(asdict(self), sort_keys=True, separators=(",", ":"))

    def digest(self) -> str:
        return hashlib.sha256(self.canonical().encode()).hexdigest()


def restructure(state: RuntimeState, evidence: dict[str, Any]) -> RuntimeState:
    """Produce a new declarative state from verified evidence."""
    weights = dict(state.rotor_weights)
    for method, gain in evidence.get("strategy_gain", {}).items():
        weights[method] = max(0.0, min(1.0, weights.get(method, 0.5) + gain))

    ordered = sorted(state.strategies, key=lambda m: weights.get(m, 0.0), reverse=True)
    return RuntimeState(
        iteration=state.iteration + 1,
        problem=state.problem,
        representation=evidence.get("next_representation", state.representation),
        strategies=ordered,
        rotor_weights=weights,
        field_version=state.field_version + 1,
        certificate={
            "previous_digest": state.digest(),
            "verified": bool(evidence.get("verified", False)),
            "timestamp": time.time(),
        },
    )


initial = RuntimeState(
    iteration=0,
    problem="x^2 - 2 y^2 == 1",
    representation="integer-polynomial",
    strategies=["ExactReduce", "Pell", "ContinuedFractions", "LatticeReduction"],
    rotor_weights={"ExactReduce": 1.0, "Pell": 0.9, "ContinuedFractions": 0.7, "LatticeReduction": 0.5},
    field_version=0,
    certificate={"verified": True, "authority": "exact solver"},
)

evidence = {
    "verified": True,
    "strategy_gain": {"Pell": 0.08, "ContinuedFractions": 0.03},
    "next_representation": "integer-polynomial + pell-orbit-field",
}

next_state = restructure(initial, evidence)
print(json.dumps({"state": asdict(next_state), "digest": next_state.digest()}, indent=2, sort_keys=True))
