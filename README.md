# 🏏 Hand Cricket Game - Flutter App

A fun and interactive 1v1 Hand Cricket game built using Flutter, where the user plays against a bot. The game follows classic hand cricket rules with innings, scoring, and win/loss outcomes. Developed with production-ready architecture using BLoC, clean UI, animations, and game state management.

---

## 🚀 Features

- 🎮 1v1 Hand Cricket gameplay (User vs Bot)
- 🔁 6-ball innings or until the user is out
- ⏱️ Countdown timer (10s) for each move
- 🤖 Smart bot with number generation
- 🏆 Real-time score tracking and win/loss dialogs
- 🧠 Rive animations for interactive player moves
- 💡 Clean architecture (Model → Repository → BLoC → UI)
- ✨ Responsive UI and organized widgets
- 🌐 Constants and localization-ready strings

---

## 🛠️ Tech Stack

- **Flutter** (Stable channel)
- **BLoC Pattern** for state management
- **Provider** for DI
- **Rive** for animations
- **Dart** (Null safety)
- **Clean Code Structure** with separation of concerns

---
lib/
│
├── constants/              # App-wide constants (assets, strings)
├── models/                 # Data models (e.g., HandCricketGame)
├── blocs/                  # BLoC logic and state management
├── presentation/
│   ├── widgets/            # Reusable UI widgets
│   ├── screens/            # App screens (main game)
├── main.dart               # App entry point

---
---
## ✅ How to Run

1. **Clone the repo**
   ```bash
   git clone https://github.com/yourusername/hand-cricket-flutter.git
   cd hand-cricket-flutter

2 **Get the Dependencies**
   ```bash
    flutter pub get
---