import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../home/presentation/pages/home_page.dart';
import '../../../watch/presentation/pages/watch_page.dart';

class BottomNavBarPage extends StatefulWidget {
  const BottomNavBarPage({Key? key}) : super(key: key);

  @override
  State<BottomNavBarPage> createState() => _BottomNavBarPageState();
}

class _BottomNavBarPageState extends State<BottomNavBarPage> {
  late PersistentTabController bottomTabscontroller;

  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const WatchPage(),
      const HomePage(),
      const HomePage(),
    ];
  }

  final items = [
    {
      "title": "Dashboard",
      "icon": Icons.grid_view,
    },
    {
      "title": "watch",
      "icon": Icons.smart_display,
    },
    {
      "title": "Media Library",
      "icon": Icons.video_library,
    },
    {
      "title": "More",
      "icon": Icons.format_list_bulleted,
    },
  ];

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      ...items.map(
        (e) {
          return PersistentBottomNavBarItem(
              icon: Icon(
                e['icon'] as IconData,
                color: Colors.white,
              ),
              inactiveIcon: Icon(
                e['icon'] as IconData,
                color: const Color(0xff827D88),
              ),
              contentPadding: 0.0,
              title: e['title'] as String,
              textStyle: GoogleFonts.poppins(
                color: const Color.fromARGB(255, 184, 184, 210),
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                fontStyle: FontStyle.normal,
                letterSpacing: 0,
              ),
              activeColorPrimary: Colors.white);
        },
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    bottomTabscontroller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return PersistentTabView(
        context,
        controller: bottomTabscontroller,
        screens: _buildScreens(),
        items: _navBarsItems(),
        confineInSafeArea: true,
        navBarHeight: MediaQuery.of(context).orientation == Orientation.portrait
            ? 100.h * 0.10
            : 100.h *
                0.2, // 738 Screen Height in Figma & 75 Nav Tabs Height === %10 FROM Screen
        backgroundColor: const Color(0xFF2E2739),
        // padding: NavBarPadding.all(0.0),
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        decoration: const NavBarDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(27),
            topRight: Radius.circular(27),
          ),
          colorBehindNavBar: Colors.white,
        ),
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        navBarStyle: NavBarStyle.style6,
      );
    });
  }
}
