import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/ui/share/addtask_bottom_sheet.dart';
import 'package:todo_app/ui/share/addtask_flat_button.dart';
import '../../../controller/home_page_controller.dart';
import '../../share/task_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final homepageController = Get.find<HomePageController>();

  final _textfieldController = TextEditingController();
  void addtaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r))),
        builder: (context) => Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              child: AddTaskBottomSheet(
                  controller: _textfieldController,
                  addfn: () {
                    if(_textfieldController.text.isNotEmpty){
                      homepageController.addTask(
                           _textfieldController.text, );
                      _textfieldController.clear();
                    }
                  }),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AddTaskFlatButton(onpress:()=> addtaskBottomSheet(context),),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 5,
        ),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  width: double.infinity,
                ),
                Text('Today',
                    style: TextStyle(fontSize: 30,
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold)),
                Text(
                  DateFormat.EEEE().format(DateTime.now()),
                  style: GoogleFonts.acme(
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.onPrimary),
                )
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
                child: Container(
                    padding: EdgeInsets.only(
                        top: 5.h, right: 5.w, left: 5.w),
                    child: Obx(() => ListView(
                          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                          children: [
                            ExpansionTile(
                                title: const Text(
                                  '未完成',
                                  style:TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),
                                initiallyExpanded: true,
                                shape: Border.all(color: Colors.transparent),
                                childrenPadding: EdgeInsets.only(left: 10.w,right: 10.w),
                                children: homepageController.TaskList
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
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w500,
                                    height: 1.5,
                                  ),
                                ),
                                initiallyExpanded: true,
                                shape: Border.all(color: Colors.transparent),
                                childrenPadding: EdgeInsets.only(left: 10.w,right: 10.w),
                                children: homepageController.DoneTaskList
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
                        )))),
          ],
        ),
      ),
    );
  }
}
