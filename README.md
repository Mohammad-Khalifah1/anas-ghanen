# 🍽️ Restaurant Waitlist

A Flutter application for managing a restaurant waiting list.

The app allows restaurant staff to add customer groups to a waiting list, assign sequential ticket numbers, track the queue, seat groups, and cancel waiting groups.

## ✨ Features

* Add a customer group to the waiting list
* Enter group name in Arabic or English
* Enter party size
* Automatic ticket number generation
* Daily ticket number reset
* FIFO waiting queue
* Show how many groups are ahead
* Mark a group as seated
* Cancel a waiting group
* Local data persistence using Hive
* Clean Architecture
* Provider state management

## 🛠️ Technologies

* **Flutter**
* **Dart**
* **Provider** — state management
* **Hive** — local storage
* **Hive Flutter** — Flutter integration
* **UUID** — unique group IDs

## 🏗️ Architecture

The project follows **Feature-First + Clean Architecture**.

```text
lib/
├── core/
│   ├── di/
│   ├── error/
│   └── usecase/
│
├── features/
│   └── waiting_list/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
├── app.dart
└── main.dart
```

### Layers

**Domain**

* Entities
* Repository contracts
* Use cases

**Data**

* Models
* Local data source
* Repository implementations

**Presentation**

* Pages
* Widgets
* Providers

## 🚀 Getting Started

### Requirements

Make sure you have the following installed:

* Flutter SDK
* Dart SDK
* Android Studio or VS Code
* Android Emulator or a physical Android device

Check your Flutter installation:

```bash
flutter doctor
```

## 📥 Installation

Clone the repository:

```bash
git clone https://github.com/YOUR_USERNAME/restaurant-waitlist.git
```

Navigate to the project:

```bash
cd restaurant-waitlist
```

Install dependencies:

```bash
flutter pub get
```

## ▶️ Run the Application

First, make sure an emulator is running or connect a physical device.

Check available devices:

```bash
flutter devices
```

Then run the application:

```bash
flutter run
```

### Run on Android

```bash
flutter run -d android
```

### Run on Chrome

```bash
flutter run -d chrome
```

## 🔍 Code Analysis

Run Flutter analyzer:

```bash
flutter analyze
```

## 🧪 Run Tests

Run the test suite:

```bash
flutter test
```

## 📦 Build

### Android APK

```bash
flutter build apk
```

The generated APK will be located in:

```text
build/app/outputs/flutter-apk/app-release.apk
```

### Android App Bundle

```bash
flutter build appbundle
```

## 📱 Screenshots

<img width="314" height="681" alt="Screenshot 2026-10-07 170946" src="https://github.com/user-attachments/assets/cc3b32b5-d1d5-4e49-85c2-b7bd5bdc374c" />
<img width="319" height="686" alt="Screenshot 2026-10-07 171045" src="https://github.com/user-attachments/assets/4ae2445b-0044-4a3b-807e-100806a68069" />
<img width="313" height="684" alt="Screenshot 2026-10-07 171022" src="https://github.com/user-attachments/assets/4c8df82e-b946-4e6f-97ae-4c9cb3c8f107" />
<img width="305" height="708" alt="Screenshot 2026-10-07 171008" src="https://github.com/user-attachments/assets/034bbbe5-b1d7-4160-8a17-09ab05b77e96" />

## 🔮 Future Improvements

* Customer-facing queue tracking
* Backend synchronization
* Firebase integration
* Notifications when the table is ready
* Restaurant account/login system
* Multiple restaurant branches
* Waiting time estimation
* Customer QR code
* Online queue joining

## 📄 License

This project is licensed under the MIT License.
