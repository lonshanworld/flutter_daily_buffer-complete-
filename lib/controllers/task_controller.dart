import "package:get/get.dart";
import 'package:to_do_app_2/db/db_Helpers.dart';

import '../models/task.dart';

class TaskController extends GetxController{
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  final RxList<Task> taskList = List<Task>.empty().obs;

  Future<void> addTask({required Task task}) async {
    await DBhelper.insert(task);
  }

  void getTasks() async{
    List<Map<String, dynamic>> tasks = await DBhelper.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  void delete(Task task){
    DBhelper.delete(task);
    getTasks();
  }

  void markTaskCompleted (int id)async {
    await DBhelper.update(id);
    getTasks();
  }

  void markTaskUndo (int id)async {
    await DBhelper.undoUpdate(id);
    getTasks();
  }
}