/*
class TaskModel {
  static const String collectionName = "Tasks";
  String? id;
  String? title;
  String? description;
  bool? isDone;
  int? dateTime;

  //DateTime? dateTime;

  TaskModel(
      {this.id, this.title, this.description, this.isDone, this.dateTime});

  TaskModel.fromFireStore(Map<String, dynamic> json)
      : this(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    isDone: json['isDone'],
    dateTime: json['dateTime'],
    //dateTime: DateTime.fromMillisecondsSinceEpoch(json['dateTime']),
  );

  Map<String, dynamic> toFireStore() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'dateTime': dateTime,
      //'dateTime': dateTime?.millisecondsSinceEpoch,
    };
  }
}
*/
class TaskModel {
  static const String collectionName = "TasksCollection";
  String? id;
  String? uid;
  String title = " ";
  String description = " ";
  DateTime selectedDate = DateTime.now();
  bool isDone = false;

  TaskModel(
      {required this.title,
        this.id,
        this.uid,
        required this.description,
        required this.selectedDate,
        this.isDone = false});

  TaskModel.init();
  TaskModel.set(TaskModel taskModel){
    id = taskModel.id;
    uid = taskModel.uid;
    title = taskModel.title;
    description = taskModel.description;
    selectedDate = taskModel.selectedDate;
    isDone = taskModel.isDone;
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "uid": uid,
      "title": title,
      "description": description,
      "selectedDate": selectedDate.millisecondsSinceEpoch,
      "isDone": isDone,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json["id"],
      uid: json["uid"],
      title: json["title"],
      description: json["description"],
      selectedDate: DateTime.fromMillisecondsSinceEpoch(json["selectedDate"]),
      isDone: json["isDone"],
    );
  }
}