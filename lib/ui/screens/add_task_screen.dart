// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/controller/task_controller.dart';
import 'package:to_do/models/task.dart';
import 'package:to_do/ui/widget/input_feild.dart';

import '../../services/theme_services.dart';
import '../size_config.dart';
import '../theme.dart';
import '../widget/build_app_bar_widget.dart';
import '../widget/my_button.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String _endTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();

  int _selecteRemender = 0;
  List<int> remenderList = [5, 10, 15, 20];
  List<String> repeterList = ['None', 'Dayle', 'Weekly', 'Mounthly'];
  String _selectedRepeat = "None";
  int _selectedColor = 0;

  final TaskController _taskController = TaskController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        appBar: buildAppBar(
          "Add Task",
          () {
            setState(() {
              Get.back();
            });
          },
          Icons.arrow_back_ios,
          context,
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Add Task",
                  style: titleStyle.copyWith(
                      color: Get.isDarkMode ? white : Colors.grey[900]),
                ),
                InputFormF(
                  title: "Title",
                  hint: "Enter title here ",
                  controller: _titleController,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFormF(
                  title: "Note",
                  hint: "Enter note here ",
                  controller: _noteController,
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFormF(
                  title: "Date",
                  hint: DateFormat.yMd().format(_selectedDate).toString(),
                  widget: IconButton(
                      onPressed: () => _getUserDate(),
                      icon: const Icon(
                        Icons.calendar_today_outlined,
                      ),
                      color: Get.isDarkMode ? white : Colors.grey[900]),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InputFormF(
                        title: "Start Time",
                        hint: _startTime,
                        widget: IconButton(
                            onPressed: () => _getUserTime(isStartTime: true),
                            icon: const Icon(Icons.access_time_outlined),
                            color: Get.isDarkMode ? white : Colors.grey[900]),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InputFormF(
                        title: "End Time",
                        hint: _endTime,
                        widget: IconButton(
                            onPressed: () => _getUserTime(isStartTime: false),
                            icon: const Icon(
                              Icons.access_time_outlined,
                            ),
                            color: Get.isDarkMode ? white : Colors.grey[900]),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFormF(
                  title: "Remind",
                  hint: "$_selecteRemender minutes early",
                  widget: DropdownButton(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    dropdownColor: Colors.grey,
                    underline: Container(height: 0),
                    iconSize: 35,
                    style: subTitleStyle,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selecteRemender = int.parse(newValue!);
                      });
                    },
                    items: remenderList
                        .map<DropdownMenuItem<String>>(
                            (int element) => DropdownMenuItem<String>(
                                  value: element.toString(),
                                  child: Text(
                                    '$element',
                                    style: subTitleStyle!
                                        .copyWith(color: Colors.white),
                                  ),
                                ))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InputFormF(
                  title: "Repeat",
                  hint: _selectedRepeat,
                  widget: DropdownButton(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(8),
                    icon: const Icon(Icons.keyboard_arrow_down_sharp),
                    dropdownColor: Colors.grey,
                    underline: Container(height: 0),
                    iconSize: 35,
                    style: subTitleStyle,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedRepeat = newValue!;
                      });
                    },
                    items: repeterList
                        .map<DropdownMenuItem<String>>(
                            (String element) => DropdownMenuItem<String>(
                                  value: element.toString(),
                                  child: Text(
                                    element,
                                    style: subTitleStyle!
                                        .copyWith(color: Colors.white),
                                  ),
                                ))
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Color",
                          style: subTitleStyle.copyWith(
                              color: Get.isDarkMode ? white : Colors.grey[900],
                              fontSize: 22),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        _buildColor(),
                      ],
                    ),
                    MyButton(
                      label: "Add Task",
                      onPressed: () {
                        _validateData();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  _validateData() {
    if (_titleController.text.isNotEmpty && _noteController.text.isNotEmpty) {
      _addTaskToDb();
      Get.back();
    } else if (_titleController.text.isEmpty || _noteController.text.isEmpty) {
      Get.snackbar(
        "Requierd",
        "All fileds are requierd",
        backgroundColor: Get.isDarkMode ? white : darkGreyClr,
        colorText: Get.isDarkMode ? darkGreyClr : white,
        icon: Icon(
          Icons.warning_amber_rounded,
          color: Colors.red[900],
          size: 25,
        ),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  _addTaskToDb() async {
    try {
      int value = await _taskController.addTasks(
        task: Task(
            title: _titleController.text,
            note: _noteController.text,
            isCompleted: 0,
            color: _selectedColor,
            date: DateFormat.yMd().format(_selectedDate),
            endTime: _endTime,
            startTime: _startTime,
            remind: _selecteRemender,
            repeat: _selectedRepeat),
      );
      print("the id of item is : $value");
    } catch (e) {
      print(e);
    }
  }

  _buildColor() {
    return Row(
      children: List.generate(
        3,
        (index) => GestureDetector(
          onTap: () {
            setState(() {
              _selectedColor = index;
            });
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: CircleAvatar(
                radius: 15,
                backgroundColor: index == 0
                    ? primaryClr
                    : index == 1
                        ? pinkClr
                        : orangeClr,
                child: _selectedColor == index
                    ? const Icon(
                        Icons.done,
                        size: 20,
                        color: white,
                      )
                    : null),
          ),
        ),
      ),
    );
  }

  _getUserTime({required bool isStartTime}) async {
    TimeOfDay? _pickedTime = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(
                const Duration(minutes: 15),
              ),
            ),
    );
    String _formatTime = _pickedTime!.format(context);
    if (_pickedTime != null) {
      setState(() {
        if (isStartTime) {
          _startTime = _formatTime;
        } else if (!isStartTime) {
          _endTime = _formatTime;
        } else {
          print("There is someone warring!");
        }
      });
    }
  }

  _getUserDate() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2014),
      lastDate: DateTime(2030),
    );
    if (_pickedDate != null) {
      setState(() {
        _selectedDate = _pickedDate;
      });
    }
  }
}
