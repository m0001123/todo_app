import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/services/theme_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              onTap: (){
                ThemeService().switchTheme();
              },
              child: Icon(
                Icons.dark_mode,
                size: 30.sp,
                color: Theme.of(context).iconTheme.color,
              ),
            ),
          )
        ],
      ),
      body: Container(),
    );
  }
}
