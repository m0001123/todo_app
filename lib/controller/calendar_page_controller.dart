import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/controller/home_page_controller.dart';

import '../model/task_model.dart';
import '../services/db_service.dart';

class CalendarPageController extends GetxController{

  DateTime today =  DateTime.now();
  DateTime selectedday =  DateTime.now();
  //未完成任務
  RxList<TaskModel> TaskList = <TaskModel>[].obs;
  //紀錄完成任務
  RxList<TaskModel> DoneTaskList = <TaskModel>[].obs;
  List alltaskDate= [];

  @override
  void onReady() {
    // TODO: implement onInit

    getHaveTaskDate();
    getTaskOnDay(DateTime.now());
    super.onReady();
  }

  void onDaySelected(DateTime selectday,DateTime focus){
    selectedday = selectday;
    today = focus;
    getTaskOnDay(selectedday);
    update();
  }

  void getHaveTaskDate()async{
    List date = await  DBService.queryHaveTaskDate();
    List datelist = date.map((e){return e['date'];}).toList();
    alltaskDate.assignAll(datelist);
    update();
  }
  void getTaskOnDay(DateTime date)async{
    List<Map<String, dynamic>> task = await DBService.queryDate(DateFormat('yyyy-MM-dd').format(date));
    List<TaskModel> tlist = task.map((e) => TaskModel.fromJson(e)).toList();
    DoneTaskList.value = tlist.where((element){return element.isdone ==1;}).toList();
    TaskList.value = tlist.where((element){return element.isdone ==0;}).toList();
  }

  //切換任務完成狀態
  void changeTaskDone(TaskModel task) async{
    task.isdone = task.isdone==1?0:1;
    await DBService.update(task.id!, task);
    getTaskOnDay(selectedday);
    syncRefresh();
  }
  //增加任務
  void addTask(String taskName,)async{
    await DBService.insert(TaskModel(id:null,taskName: taskName,isdone: 0,date: DateFormat('yyyy-MM-dd').format(selectedday)));
    getHaveTaskDate();
    getTaskOnDay(selectedday);
    syncRefresh();
  }

  //刪除任務
  void removeTask(TaskModel task) async{
    await DBService.delete(task.id!);
    getTaskOnDay(selectedday);
    getHaveTaskDate();
    syncRefresh();
  }

  void syncRefresh(){
    if(DateFormat('yyyy-MM-dd').format(selectedday) ==DateFormat('yyyy-MM-dd').format(DateTime.now())){
      HomePageController h = Get.find<HomePageController>();
      h.getTask();
    }
  }


}