import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/controller/calendar_page_controller.dart';
import 'package:get/get.dart';
import '../../share/addtask_bottom_sheet.dart';
import '../../share/task_widget.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final _calendarpageController = Get.find<CalendarPageController>();

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
                  _calendarpageController.addTask(
                    _textfieldController.text, );
                  _textfieldController.clear();
                }
              }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            addtaskBottomSheet(context);
          },
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          child: const Icon(
            Icons.add,
            color: Colors.white,
            weight: 300,
          ),
        ),
        body: Padding(
          padding:  EdgeInsets.only(right: 8.w,left: 8.w,bottom: 8.h,),
          child: Column(
            children: [
              GetBuilder<CalendarPageController>(builder: (controller) {
                return TableCalendar(
                  calendarStyle: CalendarStyle(
                    markerDecoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary,shape: BoxShape.circle)
                  ),
                  rowHeight: 40.h,
                  locale: 'zh_CN',
                  focusedDay: _calendarpageController.today,
                  firstDay: DateTime.utc(2000, 01, 01),
                  lastDay: DateTime.utc(2100, 12, 31),
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) {
                    return isSameDay(_calendarpageController.selectedday, day);
                  },
                  onDaySelected: (selectday, focus) {
                    if (!isSameDay(
                        _calendarpageController.selectedday, selectday)) {
                      _calendarpageController.onDaySelected(selectday, focus);
                    }
                  },
                  eventLoader: (day) {
                    return _calendarpageController.alltaskDate
                        .where((element) =>
                            isSameDay(day, DateTime.parse(element)))
                        .toList();
                  },
                );
              }),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                height: 3,
                margin: EdgeInsets.only(top: 15.h,bottom: 10.h,left: 50.w,right: 50.w),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 5.h, right: 5.w, left: 5.w),
                  child: Obx(
                    () => ListView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        ExpansionTile(
                            title: Text(
                              '未完成',
                              style: GoogleFonts.notoSans(
                                textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            initiallyExpanded: true,
                            shape: Border.all(color: Colors.transparent),
                            childrenPadding:
                                EdgeInsets.only(left: 10.w, right: 10.w),
                            children: _calendarpageController.TaskList.value
                                .asMap()
                                .entries
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: TaskWidget(
                                        taskName: e.value.taskName,
                                        done: e.value.isdone,
                                        fn: () => _calendarpageController
                                            .changeTaskDone(e.value),
                                        deletefn: (context) =>
                                            _calendarpageController
                                                .removeTask(e.value),
                                      ),
                                    ))
                                .toList()),
                        ExpansionTile(
                            title: Text(
                              '已完成',
                              style: GoogleFonts.notoSans(
                                textStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.5,
                                ),
                              ),
                            ),
                            initiallyExpanded: false,
                            shape: Border.all(color: Colors.transparent),
                            childrenPadding:
                                EdgeInsets.only(left: 10.w, right: 10.w),
                            children: _calendarpageController.DoneTaskList.value
                                .asMap()
                                .entries
                                .map((e) => Padding(
                                      padding: EdgeInsets.only(top: 10.h),
                                      child: TaskWidget(
                                        taskName: e.value.taskName,
                                        done: e.value.isdone,
                                        fn: () => _calendarpageController
                                            .changeTaskDone(e.value),
                                        deletefn: (context) =>
                                            _calendarpageController
                                                .removeTask(e.value),
                                      ),
                                    ))
                                .toList()),
                      ],
                    ),
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
