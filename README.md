# Talabaty

## Order Management Application

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-Framework-02569B?logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Language-Dart-0175C2?logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Storage-SharedPreferences-4A90E2" alt="SharedPreferences" />
  <img src="https://img.shields.io/badge/UI-Material%20Design-757575?logo=materialdesign&logoColor=white" alt="Material Design" />
</p>

**Talabaty (طلباتي)** is an Arabic Flutter application designed to help users organize customer orders and keep track of order information in one place. The app provides a dashboard for adding orders, viewing order summaries, managing saved records, and sharing order details as an image.

The interface is built with Arabic right-to-left (RTL) support and a dark visual theme.

## Key Features

- **Add Orders:** Record customer name, phone number, address, product, quantity, price, and notes.
- **Orders Dashboard:** View the total number of orders and the combined order value.
- **Order Management:** Browse saved orders, open their details, edit existing information, and delete orders.
- **Order Details:** View customer and product information, quantity, price, and calculated order total.
- **Share Orders as Images:** Generate a formatted order image and share it using the device's available sharing options.
- **Local Data Persistence:** Save and load order records locally using SharedPreferences.
- **Arabic RTL Interface:** Provide an Arabic-first interface with right-to-left layout.
- **Animated Splash Screen:** Display an animated introduction when the application launches.

## Tech Stack

| Technology | Purpose |
| --- | --- |
| Flutter | Cross-platform mobile application development |
| Dart | Application programming language |
| SharedPreferences | Local storage for order data |
| screenshot | Capture order details as an image |
| share_plus | Share generated order images |
| Material Design | Application UI components and styling |

## Project Structure

The project keeps the order model separate from the application screens:

```text
lib/
├── main.dart
├── models/
│   └── order.dart
└── screens/
    ├── SplashScreen.dart
    ├── home_screen.dart
    ├── orders_screen.dart
    └── details_screen.dart

assets/
└── talabatey.png
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- Dart SDK (included with Flutter)
- Android Studio or Visual Studio Code
- An Android emulator or a connected device

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/elghamry55/Talabaty.git
   ```

2. Navigate to the project directory:

   ```bash
   cd Talabaty
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## Developer

**Mahmoud Elghamry**  
Flutter Developer

- GitHub: [@elghamry55](https://github.com/elghamry55)

---

**Built with Flutter and Dart.**
