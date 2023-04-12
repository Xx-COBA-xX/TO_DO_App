import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/db/db_helper.dart';
import 'package:to_do/models/task.dart';

class TaskController extends GetxController {
  // ignore: prefer_final_fields
  final RxList<Task> taskList = <Task>[].obs;
  // this func add new items to data base after that the app can use him
 Future<int> addTasks({Task? task}) {
   return DBHelpler.insert(task);
  }

  // this func get task from data base
  Future<void> getTasks() async {
    final List<Map<String, dynamic>> tasks = await DBHelpler.query();
    taskList.assignAll(tasks.map((data) => Task.fromJson(data)).toList());
  }

  // this func delete item from app and data base
  // we use getTast() here because you make change some think in data base so you should to refrsh the data base
  void deleteTask(Task task) async {
    await DBHelpler.delete(task);
    getTasks();
  }

  // this func make task is completed
  // ==
  void markTaskCompleted(int id) async {
    await DBHelpler.update(id);
    getTasks();
  }
}

// Task(
//         color: 0,
//         endTime: "20:10",
//         startTime: "10:20",
//         isCompleted: 0,
//         note: "Haider you are stroing countinue you can do it",
//         title: "Haider Habeeb"),
//     Task(
//         color: 2,
//         endTime: "20:10",
//         startTime: "10:20",
//         isCompleted: 1,
//         note: "Haider you are stroing countinue you can do it",
//         title: "Haider Habeeb"),
//     Task(
//         color: 1,
//         endTime: "20:10",
//         startTime: "10:20",
//         isCompleted: 0,
//         note: "Haider you are stroing countinue you can do it",
//         title: "Haider Habeeb"),
//     Task(
//         color: 2,
//         endTime: "20:10",
//         startTime: "10:20",
//         isCompleted: 1,
//         note: "Haider you are stroing countinue you can do it",
//         title: "Haider Habeeb"),
//     Task(
//         color: 1,
//         endTime: "20:10",
//         startTime: "10:20",
//         isCompleted: 0,
//         note: "Haider you are stroing countinue you can do it",
//         title: "Haider Habeeb"),
