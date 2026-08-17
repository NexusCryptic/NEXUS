const { app, BrowserWindow, session } = require('electron');
const path = require('node:path');

const FIELD_FLAGS = [
  '--enable-gpu-rasterization',
  '--enable-zero-copy',
  '--ignore-gpu-blocklist',
  '--enable-features=Vulkan,WebGPU'
];

for (const flag of FIELD_FLAGS) {
  const [name, value] = flag.slice(2).split('=');
  if (value === undefined) app.commandLine.appendSwitch(name);
  else app.commandLine.appendSwitch(name, value);
}

app.commandLine.appendSwitch('enable-features', 'Vulkan,WebGPU');
app.commandLine.appendSwitch('disable-features', 'CalculateNativeWinOcclusion');

function createWindow() {
  const win = new BrowserWindow({
    width: 1600,
    height: 1000,
    backgroundColor: '#050509',
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: true,
      webgl: true,
      webviewTag: false
    }
  });

  win.loadFile(path.join(__dirname, 'renderer', 'index.html'));
  return win;
}

app.whenReady().then(() => {
  session.defaultSession.setPermissionRequestHandler((_webContents, permission, callback) => {
    callback(['media'].includes(permission));
  });

  createWindow();
  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});
