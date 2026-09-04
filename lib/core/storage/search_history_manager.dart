import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryManager {
  static const String _historyKey = 'local_recent_searches_key';
  final SharedPreferences _sharedPrefs;

  SearchHistoryManager(this._sharedPrefs);

  /// Retrieves cached search queries cleanly from local device storage footprint
  List<String> getSearchHistory() {
    return _sharedPrefs.getStringList(_historyKey) ?? [];
  }

  /// Appends a query term safely to front of array stack without adding duplicates
  Future<List<String>> appendSearchTerm(String rawQuery) async {
    final cleanQuery = rawQuery.trim();
    if (cleanQuery.isEmpty) return getSearchHistory();

    final List<String> currentList = List.from(getSearchHistory());

    // Remove duplication to move term seamlessly to top of stack row
    currentList.remove(cleanQuery);
    currentList.insert(0, cleanQuery);

    // Limit footprint structure footprint size count to a maximum of 5 records
    if (currentList.length > 5) {
      currentList.removeLast();
    }

    await _sharedPrefs.setStringList(_historyKey, currentList);
    return currentList;
  }

  /// Clears out user local query histories entirely
  Future<void> clearHistory() async {
    await _sharedPrefs.remove(_historyKey);
  }
}
