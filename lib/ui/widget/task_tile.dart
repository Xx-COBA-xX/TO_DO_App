import 'package:flutter/material.dart';
import 'package:to_do/ui/size_config.dart';

import '../../models/task.dart';
import '../theme.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({super.key, required this.task});
  final Task task;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.only(top: 12, right: SizeConfig.orientation == Orientation.landscape? 10 : 0),
      width: SizeConfig.orientation == Orientation.landscape ? SizeConfig.screenWidth/2 : SizeConfig.screenWidth,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: task.color ==0 ? primaryClr : task.color ==1 ? pinkClr: orangeClr,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(task.title!, style: titleStyle.copyWith(fontSize: 20),),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_alarm_rounded,color: white, size: 23),
                        const SizedBox(
                          width: 4,
                        ),
                        Text("${task.startTime} - ${task.endTime}", style: subTitleStyle.copyWith(fontSize: 16),)
                      ],
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(task.note!, style: descStyle.copyWith(fontSize: 16),),
                  ],
                ),
              ),
            ),
            Container(
              height: 60,
              width: 0.5,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              color: Colors.white,
            ),
             RotatedBox(
              quarterTurns: 3,
              child: Text(task.isCompleted == 0? "TODO": "COMPLETED", style: subTitleStyle.copyWith(fontSize: 12),),
            )
          ],
        ),
      ),
    );
  }
}
