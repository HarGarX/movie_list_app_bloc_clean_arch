import 'package:flutter/material.dart';

import '../../features/bottom_nav_bar/presentation/pages/bottom_nav_bar_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import 'route_consts.dart';

//7222081370170714044
class RouteGenerator {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      // case RouteConsts.SPLASH_ROUTE:
      //   return MaterialPageRoute(builder: (context) => SplashScreen());
      //!!!
      case RouteConsts.TABS_ROUTE:
        return MaterialPageRoute(
          builder: (context) => const BottomNavBarPage(),
        );
      case RouteConsts.HOME_ROUTE:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );

      //!!!
      default:
        return errorRoute();
    }
  }

  static Route<dynamic> errorRoute() {
    return MaterialPageRoute(
      builder: (BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 20.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Material(
                      child: InkWell(
                        onTap: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: const Icon(Icons.arrow_back),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'Error Route',
                      style: TextStyle(color: Colors.black),
                    ),
                    const Spacer(),
                    Container(),
                  ],
                ),
              ),
              const Center(
                child: Text(
                  'ERROR: UNKNOWN ROUTE',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
