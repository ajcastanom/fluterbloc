import 'package:equatable/equatable.dart';
import 'package:flutterblocfirebase/src/models/theme.dart';

abstract class PreferencesEvent extends Equatable {
}

class LoadPreferences extends PreferencesEvent {
  @override
  List<Object> get props => null;

}

class UpdateTheme extends PreferencesEvent {
  final Theme theme;

  UpdateTheme(this.theme);

  @override
  List<Object> get props => [Theme];

  @override
  String toString() => '$runtimeType { $theme }';
}
