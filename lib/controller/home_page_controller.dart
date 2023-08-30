import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/task_model.dart';

class HomePageController extends GetxController {
  //紀錄未完成任務
  RxList<TaskModel> TaskList =
      [TaskModel(false, '喝水'), TaskModel(false, '完成今日復盤')].obs;
  //紀錄完成任務
  RxList<TaskModel> DoneTaskList =
      [TaskModel(true, '喝水'), TaskModel(true, '完成今日復盤')].obs;
  @override
  void onInit() {
    // TODO: implement onInit

    super.onInit();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
  }
  //切換任務完成狀態
  void changeTaskDone(int index, bool isdone) {
    if (isdone) {
      DoneTaskList[index].done = !isdone;
      TaskList.add(DoneTaskList[index]);
      DoneTaskList.removeAt(index);
    } else {
      TaskList[index].done = !isdone;
      DoneTaskList.add(TaskList[index]);
      TaskList.removeAt(index);
    }
  }
  //刪除任務
  void removeTask(int index, bool isdone) {
    if (isdone) {
      print('delete');
     DoneTaskList.removeAt(index);
    } else {
     TaskList.removeAt(index);
    }
  }
  //增加任務
  void addTask(int index,String taskName, bool isdone){
    TaskList.add(TaskModel(isdone,taskName));
  }
}
