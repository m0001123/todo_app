import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/services/service.dart';
import 'package:todo_app/services/theme_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/ui/page/add_task/add_task.dart';
import 'package:todo_app/ui/page/home/component/addtask_bottom_sheet.dart';
import 'package:todo_app/utils/app_theme.dart';
import '../../../controller/home_page_controller.dart';
import 'component/task_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final homepageController = Get.find<HomePageController>();

  final _textfieldController = TextEditingController();
  void addtaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: AddTaskBottomSheet(
                  controller: _textfieldController,
                  addfn: () {
                    if(_textfieldController.text.isNotEmpty){
                      homepageController.addTask(
                           _textfieldController.text, );
                      homepageController.getTask();
                      _textfieldController.clear();
                    }
                  }),
            ));
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addtaskBottomSheet(context);
        },
        backgroundColor: AppTheme.appblue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          weight: 300,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Column(
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  Text('Today',
                      style: GoogleFonts.acme(
                          fontSize: 30.sp,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold)),
                  Text(
                    DateFormat.EEEE().format(DateTime.now()),
                    style: GoogleFonts.acme(
                        fontSize: 18.sp,
                        color: Theme.of(context).colorScheme.onPrimary),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).colorScheme.onPrimary, width: 2),
                  borderRadius: BorderRadius.circular(15.r)),
              child: Container(
                  padding: EdgeInsets.only(
                      top: 20.h, bottom: 20.h, right: 10.w, left: 10.w),
                  child: Obx(() => ListView(
                        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        children: [
                          ExpansionTile(
                              title: Text(
                                '未完成',
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              initiallyExpanded: true,
                              shape: Border.all(color: Colors.transparent),
                              childrenPadding: EdgeInsets.only(left: 10.w,right: 10.w),
                              children: homepageController.TaskList.value
                                  .asMap()
                                  .entries
                                  .map((e) => Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: TaskWidget(
                                          taskName: e.value.taskName,
                                          done: e.value.isdone,
                                          fn: () =>
                                              homepageController.changeTaskDone(
                                                  e.value),
                                          deletefn: (context) =>
                                              homepageController.removeTask(
                                                  e.value),
                                        ),
                                      ))
                                  .toList()),
                          ExpansionTile(
                              title: Text(
                                '今日已完成',
                                style: GoogleFonts.notoSans(
                                  textStyle: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.5,
                                  ),
                                ),
                              ),
                              initiallyExpanded: true,
                              shape: Border.all(color: Colors.transparent),
                              childrenPadding: EdgeInsets.only(left: 10.w,right: 10.w),
                              children: homepageController.DoneTaskList.value
                                  .asMap()
                                  .entries
                                  .map((e) => Padding(
                                        padding: EdgeInsets.only(top: 10.h),
                                        child: TaskWidget(
                                          taskName: e.value.taskName,
                                          done: e.value.isdone,
                                          fn: () =>
                                              homepageController.changeTaskDone(
                                                 e.value),
                                          deletefn: (context) =>
                                              homepageController.removeTask(
                                                  e.value),
                                        ),
                                      ))
                                  .toList()),
                        ],
                      ))),
            )),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
