# Sheets

## Overview
Sheets is a Flutter-based spreadsheet application that allows users to create, edit, format, and manage tabular data, similar to Google Sheets. The application supports basic text formatting, CSV import/export, and data validation features.

## Features
- **Spreadsheet Grid**: A 26x26 grid for entering and editing data.
- **Data Validation**: Ensures that cells contain either numbers or letters only.
- **Text Formatting**: Options to bold, italicize, change font size, and modify font colors.
- **CSV Export/Import**: Save and load spreadsheet data in CSV format.
- **User-friendly UI**: Easy-to-use interface for seamless interaction.

## Usage
Run commands like: 
```sh
SUM(A1:A4)
```

```sh
AVERAGE(A1:A4)
```

```sh
MIN(A1:A4)
```

```sh
MAX(A1:A4)
```


- ## 📷 Screenshots
  ![sheets_1](https://github.com/user-attachments/assets/914b5bca-a159-4b70-8aaa-f1eceb13b478)
  ![sheets_2](https://github.com/user-attachments/assets/ce56d0c5-da64-4241-ba95-6e692c3cca0c)
  ![sheets_3](https://github.com/user-attachments/assets/645e06fc-af32-4742-829e-621614440fba)
  ![sheets_4](https://github.com/user-attachments/assets/a712cbf2-95d7-459d-bbda-cf4d9d133353)



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
   flutter pub add path_provider        file_picker csv math_expressions velocity_x
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


## Acknowledgments
Special thanks to the Flutter community for providing valuable resources and support.

---
Happy Coding! 🚀

