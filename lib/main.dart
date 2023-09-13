import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:todo_app/controller/calendar_page_controller.dart';
import 'package:todo_app/controller/home_page_controller.dart';
import 'package:todo_app/controller/timing_page_controller.dart';
import 'package:todo_app/services/db_service.dart';
import 'package:todo_app/services/service.dart';
import 'package:todo_app/services/theme_service.dart';
import 'package:todo_app/ui/page/bottom_bar_frame.dart';
import 'package:todo_app/ui/page/home/home_page.dart';
import 'package:todo_app/ui/page/timing/start_timing_page.dart';
import 'package:todo_app/utils/app_theme.dart';
import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';

import 'controller/start_timing_page_controller.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DBService.initDb();
  await GetStorage.init();
  //notifyService.initalizeNotifyService();
  //notifyService.requestIOSPermissions();
  Get.lazyPut(() => HomePageController());
  Get.lazyPut(()=> CalendarPageController());
  Get.lazyPut(()=> TimingPageController());

  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (_,child){
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          initialRoute: '/',
          getPages: [
            GetPage(name: '/', page: ()=>BottomBarFrame()),
            GetPage(name: '/startTiming', page: ()=>StartTimingPage()),
          ],
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeService().theme,
        );
      },
    );
  }
}

