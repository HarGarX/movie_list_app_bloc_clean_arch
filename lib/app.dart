import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/route_consts.dart';
import 'core/routes/route_generator.dart';
import 'core/service_locator/service_locator.dart';
import 'features/bottom_nav_bar/presentation/bloc/bottom_nav_bar_bloc.dart';
import 'features/home/presentation/bloc/home_bloc.dart';
import 'features/watch/presentation/bloc/watch_bloc.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white.withOpacity(1.0),
      ),
    );

    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<BottomNavBarBloc>(
          create: (context) => locator<BottomNavBarBloc>(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => locator<HomeBloc>(),
        ),
        BlocProvider<WatchBloc>(
          create: (context) => locator<WatchBloc>(),
        ),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteGenerator.onGenerateRoute,
          initialRoute: RouteConsts.TABS_ROUTE),
    );
  }
}
