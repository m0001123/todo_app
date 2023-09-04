import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/calendar_page_controller.dart';
import 'package:todo_app/services/db_service.dart';
import '../model/task_model.dart';

class HomePageController extends GetxController {
  //紀錄未完成任務
  RxList<TaskModel> TaskList = <TaskModel>[].obs;
  //紀錄完成任務
  RxList<TaskModel> DoneTaskList = <TaskModel>[].obs;


  @override
  void onReady() {
      getTask();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  //獲取所有任務
  void getTask()async{
      List<Map<String, dynamic>> task = await DBService.queryDate(DateFormat('yyyy-MM-dd').format(DateTime.now()));
      List<TaskModel> tlist = task.map((e) => TaskModel.fromJson(e)).toList();
      DoneTaskList.value = tlist.where((element){return element.isdone ==1;}).toList();
      TaskList.value = tlist.where((element){return element.isdone ==0;}).toList();
  }

  //切換任務完成狀態
  void changeTaskDone(TaskModel task) async{
    task.isdone = task.isdone==1?0:1;
    await DBService.update(task.id!, task);
    getTask();
    syncRefresh();
  }
  //刪除任務
  void removeTask(TaskModel task) async{
      await DBService.delete(task.id!);
      getTask();
      syncRefresh();
  }
  //增加任務
  void addTask(String taskName,)async{
    await DBService.insert(TaskModel(id:null,taskName: taskName,isdone: 0,date: DateFormat('yyyy-MM-dd').format(DateTime.now())));
    getTask();
    syncRefresh();
  }

  void syncRefresh(){
    CalendarPageController c = Get.find<CalendarPageController>();
    c.getHaveTaskDate();
    if(DateFormat('yyyy-MM-dd').format(c.selectedday) ==DateFormat('yyyy-MM-dd').format(DateTime.now())) {
      c.getTaskOnDay(DateTime.now());
    }
  }
}
