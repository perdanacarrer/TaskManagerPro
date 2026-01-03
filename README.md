# TaskManagerPro

![Swift](https://img.shields.io/badge/Swift-6-orange)
![iOS](https://img.shields.io/badge/iOS-17%2B-blue)
![Xcode](https://img.shields.io/badge/Xcode-15.4-blue)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-green)
![Status](https://img.shields.io/badge/Status-Demo-success)

TaskManagerPro is an **offline-first task management iOS application** built with **SwiftUI**, **MVVM architecture**, and **modern Swift concurrency**.  
It demonstrates best practices in iOS development, including local persistence, reactive UI updates, and cloud synchronization.

---

## ✨ Features

- Create, read, update, and delete tasks
- Offline-first data persistence using Core Data
- Online sync with Firebase Firestore
- Search and filter tasks by priority, due date, and status
- SwiftUI-based modern UI
- Face ID security
- Home screen widgets (iOS 14+)
- Spotlight Search integration
- High unit & UI test coverage

---

## 🛠 Setup Instructions

### Prerequisites
- macOS with **Xcode 15.4 or later**
- iOS **17+** Simulator or device
- Swift **6+**
- Internet connection (only required for Firebase sync)

### Installation
1. Clone or unzip the repository:
   ```bash
   unzip TaskManagerPro.zip
   ```
2. Open the project:
   ```bash
   open TaskManagerPro/TaskManagerPro.xcodeproj
   ```
3. Select an iPhone simulator.
4. Build and run:
   ```
   Cmd + R
   ```

### Running Tests
- Unit Tests: `TaskManagerProTests`
- UI Tests: `TaskManagerProUITests`

Run all tests:
```
Cmd + U
```

---

## 🏗 Architecture Overview

TaskManagerPro follows the **MVVM (Model–View–ViewModel)** architecture to ensure clean separation of concerns and scalability.

```
SwiftUI Views
     ↓
ViewModels (Combine + async/await)
     ↓
Repositories / Services
     ↓
Core Data (Offline Storage)
     ↓
Firebase Firestore (Online Sync)
```

### Folder Structure

| Folder | Description |
|------|------------|
| App | App entry point and dependency setup |
| UI | SwiftUI screens and components |
| Core | Models, ViewModels, repositories |
| Services | Sync, persistence, and networking |
| Widgets | Home screen widgets |
| Spotlight | Spotlight Search integration |
| Tests | Unit and UI tests |

---

## 🧠 Key Design Decisions

### MVVM + SwiftUI
- Improves testability and maintainability
- Keeps UI declarative and lightweight

### Offline-First Design
- Core Data is the source of truth
- App works fully without internet access

### Combine & Swift Concurrency
- Combine for reactive state binding
- async/await for non-blocking async tasks

### Sync & Conflict Resolution
- Firestore sync when connectivity is available
- Conflict resolution uses **last-write-wins** strategy

### Modern Swift Features
- Property wrappers for state & DI
- Actors for thread-safe shared resources
- Result builders via SwiftUI

### Security & Platform Integrations
- Face ID protection
- Widgets for quick task access
- Spotlight Search for fast discovery

---

## ⚠️ Known Limitations

- Conflict resolution does not support manual merging
- Firebase auth setup is minimal
- Widgets are read-only
- No task recurrence support yet

---

## 🚀 Future Improvements

- Manual conflict resolution UI
- Task recurrence and reminders
- iCloud sync alternative
- Background sync with BGTaskScheduler
- Interactive widgets
- Localization & accessibility enhancements

---

## 📱 Compatibility

- iOS 17+
- Xcode 15.4
- Swift 6+
- iPhone & iPad supported

---

## 📄 License

This project is provided for evaluation and demonstration purposes.
