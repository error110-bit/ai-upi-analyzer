# upi_sms_parser

A lightweight Dart package for parsing UPI and bank transaction SMS into structured transaction data.

## Features

* Parse UPI and bank transaction SMS
* Extract transaction amount
* Detect income and expense transactions
* Extract merchant or recipient information
* Return structured transaction objects
* Pure Dart package with no Flutter dependency

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  upi_sms_parser: ^1.0.0
```

Then run:

```bash
dart pub get
```

or

```bash
flutter pub get
```

## Usage

```dart
import 'package:upi_sms_parser/upi_sms_parser.dart';

void main() {
  const sms =
      'Rs 250 paid to Swiggy via UPI';

  final transaction =
      UpiParser.parse(
    sms,
    DateTime.now(),
  );

  if (transaction != null) {
    print(transaction.amount);
    print(transaction.merchant);
    print(transaction.type);
  }
}
```

## Parsed Fields

The parser extracts:

* Amount
* Merchant / Recipient
* Timestamp
* Transaction Type (Income or Expense)

## Supported Transaction Keywords

Expense:

* paid
* debited
* sent
* spent

Income:

* received
* credited

## Limitations

The parser recognizes supported SMS patterns and returns `null` for unsupported or ambiguous messages. Additional SMS formats can be added by extending the parsing logic.

## License

MIT License.
