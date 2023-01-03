import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:intl/intl.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';
import '../ui/dimensions.dart';


class HistoryScreen extends StatefulWidget {
  HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {


  DateTime curDate = DateTime.now().subtract(const Duration(days: 1));
  final _taskController = Get.put(TaskController());

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("History",style: TextStyle(color: context.theme.primaryColor),),
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(left: Dimensions.oneUnitWidth * 15.0),
            child: Icon(
              Icons.arrow_back_ios,
              size: Dimensions.oneUnitHeight * 25,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      body: Obx((){
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_,index){
            Task task = _taskController.taskList[index];
            DateTime historyDate = DateFormat.yMMMd().parse(task.date!);
            if(historyDate.isBefore(curDate)){
              return Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.oneUnitWidth * 20,vertical: Dimensions.oneUnitHeight * 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: Dimensions.oneUnitWidth * 5,
                                    color: _getBGClr(task.color!),
                                  ),
                                ),
                              ),
                              child: Text(
                                task.date!,
                                style: TextStyle(
                                  fontSize: Dimensions.oneUnitHeight * 18,
                                  color: _getBGClr(task.color!),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Cabin",
                                ),
                              ),
                            ),
                            SizedBox(height: Dimensions.oneUnitHeight * 15,),
                            Text(
                              task.title!,
                              style:TextStyle(
                                fontSize: Dimensions.oneUnitHeight * 16,
                                fontWeight: FontWeight.bold,
                                color: _getBGClr(task.color!),
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
                                  color: _getBGClr(task.color!),
                                  size:Dimensions.oneUnitHeight * 20,
                                ),
                                SizedBox(width: Dimensions.oneUnitWidth * 4),
                                Text(
                                  "${task.startTime} - ${task.endTime}",
                                  style: TextStyle(
                                      fontSize: Dimensions.oneUnitHeight * 14,
                                      color: _getBGClr(task.color!),
                                      fontFamily: "RobotoCondensed"
                                  ),
                                ),
                                SizedBox(width: Dimensions.oneUnitWidth * 10,),
                                Container(
                                  padding: EdgeInsets.all(Dimensions.oneUnitHeight * 3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: _getBGClr(task.color!),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 5)),
                                  ),
                                  child: Text(
                                    "Repeat : ${task.repeat}",
                                    style: TextStyle(
                                      fontSize: Dimensions.oneUnitHeight * 13,
                                      color: _getBGClr(task.color!),
                                      fontFamily: "Cabin",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.oneUnitHeight * 5,),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(Dimensions.oneUnitHeight * 3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: _getBGClr(task.color!),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 5)),
                                  ),
                                  child: Text(
                                    "Notify ${task.remind!} Mins earlier",
                                    style: TextStyle(
                                      fontSize: Dimensions.oneUnitHeight * 13,
                                      color: _getBGClr(task.color!),
                                      fontFamily: "Cabin",
                                    ),
                                  ),
                                ),
                                SizedBox(width: Dimensions.oneUnitWidth * 10,),
                                Container(
                                  padding: EdgeInsets.all(Dimensions.oneUnitHeight * 3),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: _getBGClr(task.color!),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 5)),
                                  ),
                                  child: Text(
                                    task.isCompleted! == 1 ? "Completed" : "Not Complete",
                                    style: TextStyle(
                                      fontSize: Dimensions.oneUnitHeight * 13,
                                      color: _getBGClr(task.color!),
                                      fontFamily: "Cabin",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Dimensions.oneUnitHeight * 12),
                            Text(
                              task.note!,
                              style: TextStyle(
                                fontSize: Dimensions.oneUnitHeight * 13,
                                color: _getBGClr(task.color!),
                                fontFamily: "Cabin",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: Dimensions.oneUnitWidth * 20,vertical: Dimensions.oneUnitHeight * 10),
                    child: Column(
                      children: [
                        Container(
                          width: Dimensions.screenWidth * 0.9,
                          height: Dimensions.oneUnitHeight * 2,
                          color: context.theme.primaryColor,
                        ),
                        SizedBox(height: Dimensions.oneUnitHeight * 3,),
                        Container(
                          width: Dimensions.screenWidth * 0.9,
                          height: Dimensions.oneUnitHeight * 2,
                          color: context.theme.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }else{
              return Container();
            }
          },
        );
      }),
    );
  }
}
