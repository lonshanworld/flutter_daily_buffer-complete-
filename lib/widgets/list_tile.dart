import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:to_do_app_2/ui/dimensions.dart';

import '../models/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  const TaskTile(this.task, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.oneUnitWidth * 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: Dimensions.oneUnitHeight * 12),
      child: Container(
        padding: EdgeInsets.all( Dimensions.oneUnitHeight * 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.oneUnitHeight * 16),
          color: _getBGClr(task.color!),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title!,
                  style:TextStyle(
                        fontSize: Dimensions.oneUnitHeight * 16,
                        fontWeight: FontWeight.bold,
                        color: context.theme.primaryColor,
                    fontFamily: "Cabin",
                  ),
                ),
                SizedBox(
                  height: Dimensions.oneUnitHeight * 5,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: context.theme.primaryColor,
                      size:Dimensions.oneUnitWidth * 20,
                    ),
                    SizedBox(width: Dimensions.oneUnitWidth * 4),
                    Text(
                      "${task.startTime} - ${task.endTime}",
                      style: TextStyle(
                        fontSize: Dimensions.oneUnitHeight * 13,
                        color: context.theme.primaryColor,
                        fontFamily: "RobotoCondensed"
                      ),
                    ),
                    SizedBox(width: Dimensions.oneUnitWidth * 10,),
                    Container(
                      padding: EdgeInsets.all(Dimensions.oneUnitHeight * 3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: Dimensions.oneUnitWidth * 1,
                          color: context.theme.primaryColor,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 5)),
                      ),
                      child: Text(
                        "Repeat : ${task.repeat}",
                        style: TextStyle(
                            fontSize: Dimensions.oneUnitHeight * 13,
                            color: context.theme.primaryColor,
                            fontFamily: "Cabin",
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Dimensions.oneUnitHeight * 5,),
                Container(
                  padding: EdgeInsets.all(Dimensions.oneUnitHeight * 3),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: Dimensions.oneUnitWidth * 1,
                      color:context.theme.primaryColor,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 5)),
                  ),
                  child: Text(
                    "Notify ${task.remind} Mins earlier",
                    style: TextStyle(
                      fontSize: Dimensions.oneUnitHeight * 13,
                      color: context.theme.primaryColor,
                      fontFamily: "Cabin",
                    ),
                  ),
                ),
                SizedBox(height:Dimensions.oneUnitHeight *  12),
                Text(
                  task.note!,
                  style: TextStyle(
                    fontSize: Dimensions.oneUnitHeight * 13,
                    color: context.theme.primaryColor,
                    fontFamily: "Cabin",
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: Dimensions.oneUnitWidth * 10),
            height: Dimensions.oneUnitHeight * 100,
            width: Dimensions.oneUnitWidth * 1,
            color: context.theme.primaryColor.withOpacity(0.7),
          ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted == 1 ? "COMPLETED" : "TODO",
              style: TextStyle(
                  fontSize: Dimensions.oneUnitHeight * 13,
                  fontWeight: FontWeight.bold,
                  color: context.theme.primaryColor,
                fontFamily: "Cabin",
              ),
            ),
          ),
        ]),
      ),
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.yellow.shade600;
      case 2:
        return Colors.blue.shade800;
      case 3:
        return Colors.red.shade800;
      case 4:
        return Colors.purple;
      case 5:
        return Colors.orange.shade700;
    }
  }
}