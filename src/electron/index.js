const {app, BrowserWindow} = require('electron')
const {NODE_ENV, OSJS_URI} = process.env;

let win;
const production = NODE_ENV === 'production';

const createWindow = () => {
  const url = OSJS_URI || 'http://localhost:8000';

  win = new BrowserWindow({
    width: 800,
    height: 600,
    fullscreen: production,
    kiosk: production,
    maximizable: !production,
    minimizable: !production
  });

  win.loadURL(url);

  if (!production) {
    win.webContents.openDevTools()
  }

  win.on('closed', () => (win = null));
};

app.on('ready', createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') {
    app.quit();
  }
});

app.on('activate', () => {
  if (win === null) {
    createWindow();
  }
});
