import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocfirebase/src/blocs/preferences/preferences_bloc.dart';
import 'package:flutterblocfirebase/src/models/theme.dart';

class ThemeSelectorPage extends StatelessWidget {
  static final routeName = 'themeSelector';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme'),
      ),
      body: BlocBuilder<PreferencesBloc, PreferencesState>(
        builder: (context, state) {
          if (state is PreferencesLoaded) {
            return ListView.builder(
              itemCount: Theme.values.length,
              itemBuilder: (context, index) {
                return RadioListTile<Theme>(
                  onChanged: (theme) => BlocProvider.of<PreferencesBloc>(context)
                    .dispatch(UpdateTheme(theme)),
                  value: Theme.values[index],
                  groupValue: state.theme,
                  title: Text(_themeToString(Theme.values[index])),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  String _themeToString(Theme theme) {
    switch (theme) {
      case Theme.light:
        return 'Light';
      case Theme.dark:
        return 'Dark';
    }
    return null;
  }
}
