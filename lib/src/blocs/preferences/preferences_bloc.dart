import 'package:bloc/bloc.dart';
import 'package:flutterblocfirebase/src/models/theme.dart';
import 'package:meta/meta.dart';
import 'package:flutterblocfirebase/src/blocs/preferences/preferences_event.dart';
import 'package:flutterblocfirebase/src/blocs/preferences/preferences_state.dart';
import 'package:flutterblocfirebase/src/repositories/preferences_repository.dart';

export 'package:flutterblocfirebase/src/blocs/preferences/preferences_event.dart';
export 'package:flutterblocfirebase/src/blocs/preferences/preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  final PreferencesRepository _preferencesRepository;

  PreferencesBloc({
    @required PreferencesRepository preferencesRepository
  }) : assert(preferencesRepository != null),
       _preferencesRepository = preferencesRepository;

  @override
  PreferencesState get initialState => PreferencesNotLoaded();

  @override
  Stream<PreferencesState> mapEventToState(PreferencesEvent event) async* {
    if (event is LoadPreferences) {
      yield* _mapLoadPreferencesToState();
    } else if (event is UpdateTheme) {
      yield* _mapUpdateThemeToState(event);
    }
  }

  Stream<PreferencesState> _mapUpdateThemeToState(UpdateTheme event) async* {
    _preferencesRepository.setTheme(event.theme);
    yield PreferencesLoaded(theme: event.theme);
  }

  Stream<PreferencesState> _mapLoadPreferencesToState() async* {
    final theme = (await _preferencesRepository.getTheme());

    if (theme == null) {
      dispatch(UpdateTheme(Theme.dark));
    } else {
      yield PreferencesLoaded(theme: theme);
    }
  }
}
