class DataQualityFunctions {
  static String trim(String text) {
    return text.replaceAll(RegExp(r'\s+'), ' ').trim();
  }

  static String upper(String text) {
    return text.toUpperCase();
  }

  static String lower(String text) {
    return text.toLowerCase();
  }

  static List<List<String>> removeDuplicates(List<List<String>> data) {
    return data.toSet().toList();
  }

  static List<List<String>> findAndReplace(List<List<String>> data, String find, String replace) {
    return data.map((row) => row.map((cell) => cell.replaceAll(find, replace)).toList()).toList();
  }
}