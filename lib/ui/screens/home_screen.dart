// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do/controller/task_controller.dart';
import 'package:to_do/ui/screens/add_task_screen.dart';
import 'package:to_do/ui/size_config.dart';
import 'package:to_do/ui/theme.dart';
import 'package:to_do/ui/widget/my_button.dart';
import 'package:to_do/ui/widget/task_tile.dart';
import '../../models/task.dart';
import '../../services/notification_services.dart';
import '../../services/theme_services.dart';
import '../widget/build_app_bar_widget.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NotificationHelper notificationHelper;
  final _taskController = TaskController();

  @override
  void initState() {
    super.initState();
    notificationHelper = NotificationHelper();
    notificationHelper.requestAndroidPermission();
    notificationHelper.initializationNotification();
    _taskController.getTasks();
  }

  var _selestedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: context.theme.colorScheme.background,
      appBar: buildAppBar(
        "",
        () {
          ThemeServices().switchThemeMode();
          notificationHelper.displayNotification(
              title: "Theme Changed", body: 'body');
        },
        Get.isDarkMode
            ? Icons.wb_sunny_outlined
            : Icons.nightlight_round_outlined,
        context,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(
            SizeConfig.orientation == Orientation.landscape ? 6 : 20,
          ),
        ),
        child: Column(
          children: [
            _addTaskBar(),
            const SizedBox(
              height: 10,
            ),
            _datePicker(),
            const SizedBox(
              height: 15,
            ),
            _showTask(),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    ));
  }

  _addTaskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMMd().format(DateTime.now()),
              style: titleStyle.copyWith(
                color: Get.isDarkMode ? white : Colors.grey[900],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              "Today",
              style: titleStyle.copyWith(
                color: Get.isDarkMode ? white : Colors.grey[900],
              ),
            ),
          ],
        ),
        MyButton(
          label: "+ Add Task",
          onPressed: () async {
            await Get.to(() => const AddTaskScreen());
            _taskController.getTasks();
          },
        )
      ],
    );
  }

  _datePicker() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: DatePicker(
        DateTime.now(),
        initialSelectedDate: DateTime.now(),
        width: 70,
        height: 90,
        selectionColor: primaryClr,
        dayTextStyle:
            subTitleStyle.copyWith(fontSize: 14, color: Colors.grey[600]),
        dateTextStyle:
            titleStyle.copyWith(fontSize: 25, color: Colors.grey[600]),
        monthTextStyle:
            subTitleStyle.copyWith(fontSize: 14, color: Colors.grey[600]),
        onDateChange: (newDate) {
          setState(() {
            _selestedDate = newDate;
          });
        },
      ),
    );
  }

  Future<void> _onRefresh() async {
    _taskController.getTasks();
  }

  _showTask() {
    return Expanded(
      child: Obx(() {
        if (_taskController.taskList.isEmpty) {
          return _noTask();
          // ignore: curly_braces_in_flow_control_structures
        } else {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              scrollDirection: SizeConfig.orientation == Orientation.landscape
                  ? Axis.horizontal
                  : Axis.vertical,
              itemCount: _taskController.taskList.length,
              itemBuilder: (context, index) {
                var task = _taskController.taskList[index];
                if (task.repeat == "Dayle" ||
                    task.date == DateFormat.yMd().format(_selestedDate) ||
                    (task.repeat == "Weekly" &&
                        _selestedDate
                                    .difference(
                                        DateFormat.yMd().parse(task.date!))
                                    .inDays %
                                7 ==
                            0) ||
                    (task.repeat == "Mounthly" &&
                        DateFormat.yMd().parse(task.date!).day ==
                            _selestedDate.day)) {
                  var date = DateFormat.jm().parse(task.startTime!);
                  var myTime = DateFormat("HH:mm").format(date);

                  notificationHelper.scheduledNotification(
                    int.parse(myTime.toString().split(':')[0]),
                    int.parse(myTime.toString().split(':')[1]),
                    task,
                  );
                  return AnimationConfiguration.staggeredList(
                    position: index,
                    duration: const Duration(milliseconds: 700),
                    child: SlideAnimation(
                      horizontalOffset: 300,
                      child: FadeInAnimation(
                        child: GestureDetector(
                          onTap: () {
                            showBottomSheet(context, task);
                          },
                          child: TaskTile(task: task),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
        }
      }),
    );
  }

  _noTask() {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          child: RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              child: Wrap(
                direction: SizeConfig.orientation == Orientation.landscape
                    ? Axis.horizontal
                    : Axis.vertical,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6,
                        )
                      : const SizedBox(
                          height: 160,
                        ),
                  SvgPicture.asset(
                    "images/task.svg",
                    color: primaryClr.withOpacity(0.5),
                    height: 100,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "You don't have any task yet!\nTry to add new task to mangment your time",
                    style: subTitleStyle.copyWith(
                        color: Get.isDarkMode ? white : Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizeConfig.orientation == Orientation.landscape
                      ? const SizedBox(
                          height: 6,
                        )
                      : const SizedBox(
                          height: 320,
                        ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  showBottomSheet(BuildContext context, Task task) {
    return Get.bottomSheet(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              task.isCompleted == 1
                  ? Container()
                  : _buildBottomSheet(
                      label: "Completed Task",
                      onTap: () {
                        NotificationHelper().closeNotification(task);
                        _taskController.markTaskCompleted(task.id!);
                        Get.back();
                      },
                      clr: Get.isDarkMode
                          ? Colors.grey[200]!
                          : Colors.grey[900]!),
              task.isCompleted == 1
                  ? Container()
                  : Divider(
                      color: Get.isDarkMode ? Colors.grey[200] : darkGreyClr,
                    ),
              _buildBottomSheet(
                  label: "Delete Task",
                  onTap: () {
                    NotificationHelper().closeNotification(task);
                    _taskController.deleteTask(task);
                    Get.back();
                  },
                  clr: Colors.red),
              Divider(
                color: Get.isDarkMode ? Colors.grey[200] : darkGreyClr,
              ),
              _buildBottomSheet(
                  label: "Cancel",
                  onTap: () {
                    Get.back();
                  },
                  clr: Get.isDarkMode ? Colors.grey[200]! : Colors.grey[900]!),
            ],
          ),
        ),
      ),
      backgroundColor: context.theme.colorScheme.background,
      elevation: 5,
    );
  }

  _buildBottomSheet(
      {required String label,
      required Function() onTap,
      bool isClose = false,
      required Color clr}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: SizeConfig.screenWidth * 0.9,
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Center(
          child: Text(
            label,
            style: isClose
                ? titleStyle.copyWith(color: Colors.red)
                : titleStyle.copyWith(color: clr, fontSize: 19),
          ),
        ),
      ),
    );
  }
}
