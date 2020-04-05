import 'package:flutter/material.dart' hide Theme;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocfirebase/src/blocs/stopwatch/stopwatch_bloc.dart';
import 'package:flutterblocfirebase/src/data/themes_data.dart';
import 'package:flutterblocfirebase/src/pages/theme_selector_page.dart';

import 'blocs/counter_bloc.dart';
import 'blocs/preferences/preferences_bloc.dart';
import 'pages/counter_with_global_state_page.dart';
import 'pages/home_page.dart';
import 'pages/stopwatch_with_global_state_page.dart';
import 'repositories/preferences_repository.dart';
import 'models/theme.dart';

class App extends StatelessWidget {
  final PreferencesRepository preferencesRepository;
  final PreferencesBloc preferencesBloc;

  const App({
    Key key,
    @required this.preferencesRepository,
    @required this.preferencesBloc
  }) : assert(preferencesRepository != null),
       assert(preferencesBloc != null),
       super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<PreferencesRepository>.value(
          value: preferencesRepository,
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<PreferencesBloc>.value(value: preferencesBloc),
          BlocProvider<CounterBloc> (builder: (context) => CounterBloc()),
          BlocProvider<StopwatchBloc>(builder: (context) => StopwatchBloc(),)
        ],
        child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (context, state) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state is PreferencesLoaded
                ? themesData[state.theme]
                : themesData[Theme.dark],
              initialRoute: HomePage.routeName,
              routes: {
                HomePage.routeName: (BuildContext context) => HomePage(),
                CounterWithLocalStatePage.routeName: (BuildContext context) => CounterWithLocalStatePage(),
                CounterWithGlobalStatePage.routeName: (BuildContext context) => CounterWithGlobalStatePage(),
                StopwatchWithGlobalStatePage.routeName: (BuildContext context) => StopwatchWithGlobalStatePage(),
                StopwatchWithLocalStatePage.routeName: (BuildContext context) => StopwatchWithLocalStatePage(),
                ThemeSelectorPage.routeName: (BuildContext context) => ThemeSelectorPage()
              },
            );
          },
        )
      ),
    );
  }
}
