import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zeotap_sheets_1/utils/data_quality.dart';
import 'package:zeotap_sheets_1/utils/formulas.dart';

class Spreadsheetscreen extends StatefulWidget {
  const Spreadsheetscreen({super.key});

  @override
  State<Spreadsheetscreen> createState() => _SpreadsheetscreenState();
}

class _SpreadsheetscreenState extends State<Spreadsheetscreen> {
  List<List<String>> data = List.generate(26, (_) => List.generate(26, (_) => ''));
  TextEditingController formulaController = TextEditingController();
  int? selectedRow;
  int? selectedCol;
  Map<String, TextStyle> cellStyles = {};
  double defaultFontSize = 14;
  Color defaultFontColor = Colors.black;
  List<Color> colors = [Colors.black, Colors.white, Colors.red, Colors.blue, Colors.green, Colors.yellow, Colors.purple];
  Color selectedColor = Colors.black;

  void calculateFormula() {
    setState(() {
      formulaController.text = FormulaEvaluator.evaluate(formulaController.text, data);
    });
  }

  void removeDuplicates() {
    setState(() {
      data = DataQualityFunctions.removeDuplicates(data);
    });
  }

  void findAndReplace(String find, String replace) {
    setState(() {
      data = DataQualityFunctions.findAndReplace(data, find, replace);
    });
  }

  //     bool isValidCell(String value) {
  //   return RegExp(r'^[0-9]+\$').hasMatch(value) || RegExp(r'^[a-zA-Z]+\$').hasMatch(value);
  // }

  Future<void> exportToCSV() async {
    String csvData = const ListToCsvConverter().convert(data);
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/spreadsheet_data.csv';
    final file = File(path);
    await file.writeAsString(csvData);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CSV exported to: $path')));
  }

  Future<void> importFromCSV() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['csv']);
    if (result != null) {
      File file = File(result.files.single.path!);
      String fileContent = await file.readAsString();
      List<List<dynamic>> csvTable = const CsvToListConverter().convert(fileContent);
      setState(() {
        data = csvTable.map((row) => row.map((cell) => cell.toString()).toList()).toList();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('CSV imported successfully')));
    }
  }

  void _handleDrag(int row, int col) {
    if (selectedRow != null && selectedCol != null) {
      setState(() {
        data[row][col] = data[selectedRow!][selectedCol!];
      });
    }
  }

  void updateCellStyle(TextStyle Function(TextStyle) modifier) {
    if (selectedRow != null && selectedCol != null) {
      String key = '$selectedRow-$selectedCol';
      setState(() {
        cellStyles[key] = modifier(cellStyles[key] ?? TextStyle(fontSize: defaultFontSize, color: defaultFontColor));
      });
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sheets'),
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
              icon: Icon(Icons.format_bold),
              onPressed: () => updateCellStyle((style) => style.copyWith(fontWeight: style.fontWeight == FontWeight.bold ? FontWeight.normal : FontWeight.bold))),
          IconButton(
              icon: Icon(Icons.format_italic),
              onPressed: () => updateCellStyle((style) => style.copyWith(fontStyle: style.fontStyle == FontStyle.italic ? FontStyle.normal : FontStyle.italic))),
          IconButton(
              icon: Icon(Icons.text_fields),
              onPressed: () => updateCellStyle((style) => style.copyWith(fontSize: style.fontSize! + 2))),
          DropdownButton<Color>(
            dropdownColor: Colors.blue[100],
            menuWidth: 80,
            value: selectedColor,
            onChanged: (Color? newColor) {
              if (newColor != null) {
                setState(() {
                  selectedColor = newColor;
                });
                updateCellStyle((style) => style.copyWith(color: selectedColor));
              }
            },
            items: colors.map((Color color) {
              return DropdownMenuItem<Color>(
                value: color,
                child: Container(width: 24, height: 24, color: color),
              );
            }).toList(),
          ),
          IconButton(
                icon: Icon(Icons.format_size),
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < data.length; i++) {
                      for (int j = 0; j < data[i].length; j++) {
                        data[i][j] = DataQualityFunctions.upper(data[i][j]);
                      }
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.format_align_left),
                onPressed: () {
                  setState(() {
                    for (int i = 0; i < data.length; i++) {
                      for (int j = 0; j < data[i].length; j++) {
                        data[i][j] = DataQualityFunctions.lower(data[i][j]);
                      }
                    }
                  });
                },
              ),
          IconButton(
            icon: Icon(Icons.cleaning_services),
            onPressed: removeDuplicates,
          ),
          IconButton(icon: Icon(Icons.file_upload), onPressed: exportToCSV),
          IconButton(icon: Icon(Icons.file_download), onPressed: importFromCSV),
        ],
      bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: formulaController,
                    decoration: InputDecoration(
                      hintText: 'Enter formula (e.g., SUM(A1:A10))',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: calculateFormula,
                  child: Text('Calculate',style: TextStyle(color: Colors.white),),
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.purple),
                  ),
                ),
              ],
            ),
          ),
        ),),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            border: TableBorder.all(width: 1),
            headingRowColor: WidgetStatePropertyAll(Colors.green),
            columns: [
              DataColumn(label: Center(child: Text('#', style: TextStyle(fontWeight: FontWeight.bold)))),
              for (int i = 0; i < 26; i++) DataColumn(label: Center(child: Text(String.fromCharCode(65 + i), style: TextStyle(fontWeight: FontWeight.bold))))
            ],
            rows: List.generate(26, (row) =>
              DataRow(cells: [
                DataCell(Text('${row + 1}', style: TextStyle(fontWeight: FontWeight.bold))),
                for (int col = 0; col < 26; col++)
                  DataCell(
                    Draggable(
                      data: {'row': row, 'col': col},
                      feedback: Material(
                        child: Text(data[row][col], style: TextStyle(fontSize: 16, color: Colors.black)),
                      ),
                      childWhenDragging: Container(),
                      child: DragTarget<Map<String, int>>(
                        onAccept: (dragData) {
                          _handleDrag(row, col);
                        },
                        builder: (context, candidateData, rejectedData) => GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRow = row;
                              selectedCol = col;
                            });
                          },
                          child: Container(
                            child: TextFormField(
                              initialValue: data[row][col],
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                setState(() {
                                  // if (!isValidCell(value)) {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(content: Text('Cell must contain only numbers or only letters')),
                                  //   );
                                  // } else {
                                    data[row][col] = value;
                                  //}
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ]),
            ),
          ),
        ),
      ),

    );
  }
}