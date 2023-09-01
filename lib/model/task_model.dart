class TaskModel {
  TaskModel({
    required this.id,
    required this.taskName,
    required this.isdone,
    required this.date,
  });
  int isdone;
  String taskName;
  int? id;
  String date;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'],
      taskName: json['taskName'],
      isdone: json['isdone'],
      date: json['date']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['taskName'] = taskName;
    data['isdone'] = isdone;
    data['date'] = date;
    return data;
  }
}
