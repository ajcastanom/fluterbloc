import 'package:flutterblocfirebase/src/models/theme.dart';
import 'package:flutterblocfirebase/src/repositories/preferences_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesRepositoryImpl implements PreferencesRepository {
  static const String _themeIndexKey = 'themeIndex';

  @override
  Future<Theme> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeIndexKey);

    if (index != null) {
      return Theme.values[index];
    } else {
      return null;
    }
  }

  @override
  Future<void> setTheme(Theme theme) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeIndexKey, theme.index);
  }

}
