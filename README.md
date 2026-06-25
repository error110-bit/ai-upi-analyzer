# AI UPI Analyzer

AI UPI Analyzer is a Flutter application that automatically imports UPI transaction SMS, categorizes expenses, provides spending analytics, and generates AI-powered financial insights.

## Features

*  Import UPI transactions directly from SMS
*  Track income and expenses
*  Interactive spending analytics with pie charts
*  AI-generated spending insights
*  Transaction history management
*  Delete transactions
*  Local SQLite storage
*  Modular architecture using Flutter BLoC

## Tech Stack

* Flutter
* Dart
* flutter_bloc
* SQLite
* fl_chart
* permission_handler
* flutter_sms_inbox

## Architecture

The application follows a layered architecture:

* Presentation Layer (Flutter UI)
* Business Logic Layer (BLoC)
* Repository Layer
* Services Layer
* Local SQLite Database

The SMS parsing logic is implemented as a separate reusable Dart package (`upi_sms_parser`).

## Project Structure

```text
lib/
├── features/
│   ├── analytics/
│   ├── insights/
│   ├── home/
│   └── transactions/
└── main.dart
```

The application follows a feature-based architecture. Each feature encapsulates its own UI, business logic (BLoC), services, models, and widgets, making the codebase modular and easier to maintain. The SMS parsing logic is extracted into a separate reusable package, `upi_sms_parser`.


## Getting Started

1. Clone the repository.
2. Run:

```bash
flutter pub get
```

3. Connect an Android device.

4. Launch the application:

```bash
flutter run
```

## Permissions

The application requests SMS permission to securely import transaction messages. No SMS data is transmitted externally; all processing is performed locally on the device.

## Future Improvements

* Export transaction reports
* Budget tracking
* Cloud synchronization
* Advanced AI recommendations

## Package

The SMS parsing functionality is published separately as the `upi_sms_parser` package.

## License

MIT License.
