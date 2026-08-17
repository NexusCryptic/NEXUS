export function createFieldState(overrides = {}) {
  return {
    version: "0.2.0",
    frame: 0,
    timestamp: performance?.now?.() ?? Date.now(),
    field: {
      kind: "sdf",
      expression: "sqrt(x*x+y*y+z*z)-1",
      dimension: 3,
      parameters: { scale: 1, audio: 0, gesture: 0 }
    },
    rotor: {
      representation: "phase-vector",
      phase: 0,
      amplitude: 1,
      coupling: 0.5,
      axis: [0, 1, 0]
    },
    streams: { audio: {}, gesture: {}, solver: {} },
    branches: [],
    certificate: { status: "unverified", method: null, residual: null, proof: null },
    ...overrides
  };
}

export function cloneBranch(state, id) {
  const next = structuredClone(state);
  next.branches = [...(next.branches || []), id];
  next.frame += 1;
  return next;
}

export function applyFieldMutation(state, mutation) {
  const next = structuredClone(state);
  next.frame += 1;
  next.timestamp = performance?.now?.() ?? Date.now();
  if (mutation.field) next.field = { ...next.field, ...mutation.field };
  if (mutation.rotor) next.rotor = { ...next.rotor, ...mutation.rotor };
  if (mutation.streams) next.streams = { ...next.streams, ...mutation.streams };
  if (mutation.certificate) next.certificate = { ...next.certificate, ...mutation.certificate };
  return next;
}

export function sdfSphere(x, y, z, radius = 1) {
  return Math.hypot(x, y, z) - radius;
}

export function fieldResidual(state, sample = [0, 0, 0]) {
  const [x, y, z] = sample;
  if (state.field.kind === "sdf") {
    const r = state.field.parameters?.scale ?? 1;
    return sdfSphere(x, y, z, r);
  }
  return NaN;
}
