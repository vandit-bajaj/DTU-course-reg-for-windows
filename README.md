# DTU Course Registrar (Windows & macOS)

<p align="center">
  <img src="assets/dtulogo.png" alt="DTU Course Registrar Logo" width="110" height="110" />
</p>

<p align="center">
  <b>High-speed automated elective course seat sniper & registrar for Delhi Technological University students.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Platform-Windows%20%7C%20macOS-0078D6?style=flat-square&logo=windows&logoColor=white" alt="Platform Windows and macOS" />
  <img src="https://img.shields.io/badge/Architecture-x64%20%7C%20ARM64-555555?style=flat-square" alt="Architecture" />
  <img src="https://img.shields.io/badge/Node.js-≥18.0.0-339933?style=flat-square&logo=node.js&logoColor=white" alt="Node.js" />
  <img src="https://img.shields.io/badge/Electron-v34-47848F?style=flat-square&logo=electron&logoColor=white" alt="Electron" />
  <img src="https://img.shields.io/badge/Response%20Time-~30ms-orange?style=flat-square" alt="Speed" />
  <img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square" alt="License MIT" />
</p>

---

## 📖 About the Project

**DTU Course Registrar** is an automated desktop application built for **Delhi Technological University (DTU)** students running **Windows** or **macOS**. It continuously monitors the official DTU ExamSetu course registration portal (`exam-setu.dtu.ac.in`) and automatically snipes target elective courses the millisecond a seat becomes vacant.

### The Problem
During DTU course registration windows (DEC, GEC, SEC, VAC electives), thousands of students attempt to register simultaneously:
- Popular elective seats vanish within seconds.
- The university server experiences heavy load, leading to slow page loads, gateway timeouts, and broken sessions.
- In-browser manual refreshing and clicking is humanly too slow to compete when only 1 or 2 dropped seats open up.

### The Solution
DTU Course Registrar bypasses the browser rendering pipeline entirely. It directly communicates with the registration backend over optimized HTTP connections, polling seat availability with ETag validation and firing registration payloads in **under 100ms** — faster than any human can react.

### ✨ Key Features

- 🪟 **Auto-Login & Open Portal (Manual Mode)**: Opens an isolated Chromium window directly on `exam-setu.dtu.ac.in/student/login`, retries login automatically until you reach your dashboard, then hands full manual control over to you for course CAPTCHAs and selection.
- 🔁 **502/504 Host Error Auto-Retry**: Automatically reloads Cloudflare / DTU origin error pages (`502`, `503`, `504`, `520–524`) every 4 seconds without dropping your session.
- 🛡️ **CAPTCHA & Invalid Credential Guard**: Stops auto-login immediately if a security challenge/CAPTCHA or invalid-credential alert appears, letting you complete it manually in the portal window.
- ⚡ **Sub-100ms Seat Polling**: Connects directly to `exam-setu.dtu.ac.in` over persistent Keep-Alive HTTPS connections with MD5/ETag content caching to minimize overhead.
- 🔄 **Session Recovery**: Automatically re-authenticates if the DTU portal invalidates your session cookie.
- 🔔 **Native Audio & Bell Alerts**: Plays distinct system audio chimes for each automation event on both Windows and macOS:
  - 🔔 **Start**: Crisp bell ding (`Windows Ding.wav` on Windows / `Tink` on macOS).
  - 🛎️ **Login Success**: Resonant crystal bell (`chimes.wav` on Windows / `Glass` on macOS).
  - 🎉 **Course Registered**: Triumphant fanfare (`tada.wav` on Windows / `Hero` on macOS).
  - ⚠️ **Error Stopped**: Alert tone (`chord.wav` on Windows / `Basso` on macOS).
  - ✋ **Prompt / CAPTCHA**: Prompt chime (`notify.wav` on Windows / `Sosumi` on macOS).
  - ⏹️ **User Stop**: Clean stop sound (`Windows Navigation Start.wav` on Windows / `Pop` on macOS).
  - *Includes an in-app toggle to easily enable or mute audio alerts.*
- 📢 **Native Desktop Notifications**: Real-time notifications on Windows 10/11 Action Center (with AppUserModelId branding) and macOS Notification Center.
- 📝 **Dual Course Input**: Add courses individually through interactive inputs or paste full batches using the built-in JSON editor.
- 🔒 **Zero Disk Footprint**: Credentials and session tokens are strictly kept in volatile memory and are never written to disk or transmitted to third parties.

<br>

## ⚙️ How It Works

1. **Authentication**: Authenticates directly with `exam-setu.dtu.ac.in` using your Roll Number and Password to establish a secure session (`connect.sid`).
2. **Table Scraping**: Parses elective tables and course hashes required for registration.
3. **High-Frequency Polling**: Periodically requests seat counts (~900ms interval).
4. **Instant Registration**: When a seat opens (`available > 0`), it immediately dispatches the registration payload.
5. **Confirmation & Alert**: Validates registration success, logs the confirmation timestamp, and triggers a native desktop notification and celebratory sound.

<br>

## 💻 Requirements

### Windows
- **Operating System**: Windows 10 / 11 (64-bit)
- **Node.js**: [Node.js](https://nodejs.org/) ≥ 18  
  *Install via PowerShell:*
  ```powershell
  winget install OpenJS.NodeJS.LTS
  ```

### macOS
- **Operating System**: macOS (Apple Silicon M1/M2/M3/M4 or Intel)
- **Node.js**: [Node.js](https://nodejs.org/) ≥ 18  
  *Install via Homebrew:*
  ```bash
  brew install node
  ```

<br>

## 🚀 Setup & Launch

### Windows Quick Start

#### Option A: One-Click Batch Launchers
1. Double-click `setup.bat` to verify Node.js and install all dependencies.
2. Double-click `start.bat` to launch the application.

#### Option B: PowerShell / Command Prompt
```powershell
# 1. Clone repository
git clone https://github.com/vandit-bajaj/DTU-course-reg-for-mac.git
cd DTU-course-reg-for-mac

# 2. Install dependencies
npm install

# 3. Start the application
npm start
```

### macOS Quick Start
```bash
# 1. Clone repository
git clone https://github.com/vandit-bajaj/DTU-course-reg-for-mac.git
cd DTU-course-reg-for-mac

# 2. Install dependencies
npm install

# 3. Start the application
npm start
```

<br>

## 📋 Usage Guide

### Mode A: Auto-Login & Open Portal (Recommended when CAPTCHA is active)
1. **Enter Credentials**: Fill in your DTU Roll Number and Password (no course codes needed yet).
2. Click **`Auto-Login & Open Portal (Manual Mode)`**.
3. The app opens `exam-setu.dtu.ac.in/student/login` in a fresh browser window, logs in automatically (retrying `502`/`504` errors every 4s), notifies you with a sound once your dashboard opens, and hands full manual control over to you for clicking **Course Registration** and completing course CAPTCHAs.

### Mode B: Automated Course Seat Monitoring
1. **Enter Credentials**: Fill in your DTU Roll Number and Password.
2. **Add Courses to Track**:
   - Click **Add Course** to manually enter Course Code (e.g. `HU317`) and Slot (e.g. `E2`).
   - Or click the **`</>`** button to paste a JSON batch:
     ```json
     [
       { "code": "HU317", "slot": "E2" },
       { "code": "SE427", "slot": "E1" }
     ]
     ```
3. **Auto Login**: Keep **Auto Login on Session Expiry** enabled for seamless re-authentication if the session drops.
4. **Start Automation**: Click **Start Automation**.

<br>

## 📦 Building Standalone Distributables

### Building for Windows (`.exe` Installer & `.zip`)
To package a standalone Windows NSIS installer and portable zip:
```powershell
npm run dist:win
```
The output binaries will be created in the `dist/` directory:
- `DTU Course Registrar Setup <version>.exe` (NSIS Installer)
- `DTU Course Registrar <version>-win.zip` (Portable ZIP)

> **Windows SmartScreen Note**: When launching an unsigned locally-built executable for the first time, Windows Defender SmartScreen may display a warning dialog. Click **More info** and then **Run anyway**.

### Building for macOS (`.dmg` & `.zip`)
To package a macOS Apple Silicon / Intel application:
```bash
npm run dist:mac
```
Output binaries will be generated inside the `dist/` directory.

> **macOS Gatekeeper Note**:
> ```bash
> xattr -cr /Applications/DTU\ Course\ Registrar.app
> ```

<br>

## 📂 Project Structure

```
DTU-course-reg-for-mac/
├── main.js              # Electron main process (lifecycle, portal handoff, audio, IPC)
├── preload.js           # Secure context bridge between renderer and Node.js
├── renderer.js          # UI controller (form handling, JSON modal, event listeners)
├── automation.js        # Core automation engine (cross-platform headers, auth, polling)
├── index.html           # Application interface layout
├── styles.css           # Cross-platform responsive UI styling
├── start.bat            # Windows one-click launcher
├── setup.bat            # Windows one-click dependency installer
├── run_tests.bat        # Windows one-click test runner
├── scripts/
│   └── afterPack.js     # Build hook (macOS codesigning & Windows pack confirmation)
├── assets/
│   ├── dtulogo.ico      # Windows application multi-resolution icon (16x16 to 256x256)
│   ├── dtulogo.png      # High-resolution PNG logo
│   └── dtulogo.icns     # macOS bundle icon
├── test_comprehensive_audit.js # Live backend & table simulation audit suite
├── test_reliability_stress.js  # Stress and failure scenario test suite
└── package.json         # Dependencies, scripts, and build configuration
```

<br>

## 🛠️ Tech Stack

| Layer | Technology | Purpose |
|---|---|---|
| **Desktop Framework** | [Electron 34](https://www.electronjs.org/) | Cross-platform desktop runtime on Chromium & Node.js |
| **HTTP Client** | [got v14](https://github.com/sindresorhus/got) | High-performance, lightweight HTTP requests with Keep-Alive & timeout control |
| **HTML Parser** | [Cheerio](https://cheerio.js.org/) | Fast server-side DOM parsing and selector extraction |
| **Notifications** | [node-notifier](https://github.com/mikaelbr/node-notifier) | Windows Action Center & macOS Notification Center integration |
| **Code Editor** | [CodeMirror 5](https://codemirror.net/) | Syntax-highlighted JSON batch editor |
| **Audio Engine** | Windows Media & macOS Sound APIs | Native event-specific audio feedback |

<br>

## 🔒 Security & Privacy Notes

- **Official Portal Domain**: Connects directly to `https://exam-setu.dtu.ac.in` over HTTPS.
- **In-Memory Only**: Your credentials and authentication cookies remain strictly in memory during the execution lifecycle. No secrets are ever stored in `localStorage`, cache, or on-disk databases.
- **Respects CAPTCHAs**: Never attempts to solve or bypass CAPTCHAs or Cloudflare security verifications — automatically pauses and hands control to you in the visible portal window.

<br>

## 👤 Author

**Vandit Bajaj**  
GitHub: [@vandit-bajaj](https://github.com/vandit-bajaj)

<br>

## 📄 License

This project is open-source and licensed under the [MIT License](LICENSE).
