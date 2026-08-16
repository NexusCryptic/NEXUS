const { contextBridge } = require('electron');

contextBridge.exposeInMainWorld('nexusRuntime', {
  version: '0.2.0',
  capabilities: ['webgl', 'webgpu-request', 'offscreen-canvas', 'audio-input', 'field-branches']
});
