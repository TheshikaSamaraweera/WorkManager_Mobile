import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:workapp/style/app_style.dart';

import '../home_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    //BusinessPage(),
    //SchoolPage(),
    //SchoolPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              AppStyle.homeIcon,
              colorFilter: const ColorFilter.mode(
                AppStyle.primarySwatch,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(AppStyle.homeIcon),
            label: 'Home',
          ),


          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              AppStyle.eventIcon,
              colorFilter: const ColorFilter.mode(
                AppStyle.primarySwatch,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(AppStyle.eventIcon),
            label: 'To-Do',
          ),


          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              AppStyle.reportIcon,
              colorFilter: const ColorFilter.mode(
                AppStyle.primarySwatch,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(AppStyle.reportIcon),
            label: 'Attendance',
          ),


          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(
              AppStyle.notificationsIcon,
              colorFilter: const ColorFilter.mode(
                AppStyle.primarySwatch,
                BlendMode.srcIn,
              ),
            ),
            icon: SvgPicture.asset(AppStyle.notificationsIcon),
            label: 'Notifications',
          ),


        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 12, 46, 71),
        onTap: _onItemTapped,
      ),
    );
  }
}
