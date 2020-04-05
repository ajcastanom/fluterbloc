import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutterblocfirebase/src/models/theme.dart';

abstract class PreferencesState extends Equatable {

}

class PreferencesNotLoaded extends PreferencesState {
  @override
  List<Object> get props => null;
}

class PreferencesLoaded extends PreferencesState {
  final Theme theme;

  PreferencesLoaded({
    @required this.theme
  });

  @override
  List<Object> get props => [theme];

  @override
  String toString() => '$runtimeType { $theme }';

}
