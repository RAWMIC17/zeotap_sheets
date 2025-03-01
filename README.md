# Sheets

## Overview
Sheets is a Flutter-based spreadsheet application that allows users to create, edit, format, and manage tabular data, similar to Google Sheets. The application supports basic text formatting, CSV import/export, and data validation features.

## Features
- **Spreadsheet Grid**: A 26x26 grid for entering and editing data.
- **Data Validation**: Ensures that cells contain either numbers or letters only.
- **Text Formatting**: Options to bold, italicize, change font size, and modify font colors.
- **CSV Export/Import**: Save and load spreadsheet data in CSV format.
- **User-friendly UI**: Easy-to-use interface for seamless interaction.

## Installation

### Prerequisites
Ensure you have Flutter installed. If not, install it by following the official [Flutter installation guide](https://flutter.dev/docs/get-started/install).

### Steps
1. Clone the repository:
   ```sh
   git clone https://github.com/RAWMIC17/zeotap_sheets
   cd sheets
   ```
2. Install dependencies:
   ```sh
   flutter pub get
   ```
3. Run the application:
   ```sh
   flutter run
   ```

## Usage
- Tap on a cell to edit its content.
- Use the toolbar to apply formatting (bold, italic, font size, color change).
- Click the import/export buttons to manage CSV files.
- Rows are indexed numerically, and columns are labeled alphabetically.

## Technologies Used
- **Flutter**: UI framework for cross-platform development.
- **Dart**: Programming language for Flutter.
- **math_expressions**: For handling mathematical expressions.
- **file_picker**: To browse and pick files for import.
- **path_provider**: To store and retrieve files from the device.
- **csv**: For CSV file processing.

## Contribution
Contributions are welcome! Feel free to fork the repository, make changes, and submit a pull request.

## Acknowledgments
Special thanks to the Flutter community for providing valuable resources and support.

---
Happy Coding! 🚀

