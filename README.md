# React-Native-decoder

A multi-SDK decoder project containing React Native, iOS (Swift/Obj-C), and Android (Kotlin/Java) implementations as submodules.

## Quick Start

### Clone with all submodules

**Option 1: Clone and initialize in one go**
```bash
git clone --recurse-submodules https://github.com/skanda-srikanta/react-native-decoder.git
cd React-Native-decoder
```

**Option 2: Clone first, then initialize submodules**
```bash
git clone https://github.com/skanda-srikanta/react-native-decoder.git
cd React-Native-decoder
```

Then run the setup script:

**macOS / Linux:**
```bash
chmod +x setup.sh
./setup.sh
```

**Windows (PowerShell):**
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope Process
.\setup.ps1
```

### What gets initialized

- `react-native-test-app` — React Native test application
- `react-native-sdk` — React Native SDK (TypeScript)
- `ios-sdk` — iOS SDK (Swift/Obj-C)
- `android-sdk` — Android SDK (Kotlin/Java)

View initialized submodules:
```bash
git submodule status
```

## Updating Submodules

### Pull latest from all submodules
```bash
git submodule foreach git pull origin main
```

### Update submodule pointer in parent repo
```bash
git add .
git commit -m "Update submodule pointers to latest"
git push
```

### Clone an existing repo with submodules
**If you forgot `--recurse-submodules` during clone:**
```bash
git submodule update --init --recursive
```

## Project Structure

```
React-Native-decoder/
├── react-native-test-app/    (React Native test app)
├── react-native-sdk/         (React Native SDK)
├── ios-sdk/                  (iOS SDK)
├── android-sdk/              (Android SDK)
├── .gitmodules              (submodule configuration)
├── setup.sh                 (setup script for macOS/Linux)
├── setup.ps1                (setup script for Windows)
└── README.md                (this file)
```

## Contributing

When working on a submodule:
1. Make changes inside the submodule folder
2. Commit to the submodule branch
3. Push submodule changes to its origin
4. Return to parent repo and update pointer: `git add <submodule-path>`
5. Commit and push in parent repo

## Troubleshooting

**Submodules not updating?**
```bash
git pull origin main
git submodule update --init --recursive
```

**Need to point submodule to a different branch?**
```bash
cd <submodule-path>
git checkout <branch-name>
cd ..
git add <submodule-path>
git commit -m "Update submodule to branch: <branch-name>"
git push
```

## Support

For issues or questions, refer to each submodule's README.
