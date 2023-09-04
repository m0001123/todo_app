import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/ui/page/calendar/calendar_page.dart';
import 'package:todo_app/ui/page/home/home_page.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:get/get.dart';
import '../../services/theme_service.dart';

class BottomBarFrame extends StatefulWidget {
  const BottomBarFrame({super.key});

  @override
  State<BottomBarFrame> createState() => _BottomBarFrameState();
}

class _BottomBarFrameState extends State<BottomBarFrame> {
  int _seletbodyIndex = 1;
  final List<Widget> bodyList = [
    HomePage(),
    CalendarPage(),
    Container(),
  ];

  void _onBottomItemTap(int index) {
    setState(() {
      _seletbodyIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          size: 30.sp,
          color: Theme.of(context).iconTheme.color,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                ThemeService().switchTheme();
              },
              child: Icon(
                Get.isDarkMode ? Icons.dark_mode : Icons.sunny,
                size: 30.sp,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: _seletbodyIndex,
        children: bodyList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        currentIndex: _seletbodyIndex,
        elevation: 10,
        selectedFontSize: 12.0,
        selectedItemColor: Theme.of(context).colorScheme.onSecondary,
        onTap: (index) => _onBottomItemTap(index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.description_outlined),
            label: '任務',
            activeIcon: Icon(Icons.description_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: '日曆',
            activeIcon: Icon(Icons.calendar_month_rounded),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_outlined),
            label: '計時',
            activeIcon: Icon(Icons.access_time_filled_sharp),
          ),
        ],
      ),
    );
  }
}
