import 'package:date_picker_timeline/date_picker_timeline.dart';
import "package:flutter/material.dart";
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import "package:get/get.dart";
import "package:intl/intl.dart";
import 'package:to_do_app_2/controllers/task_controller.dart';
import 'package:to_do_app_2/screens/add_task_page.dart';
import 'package:to_do_app_2/screens/history_screen.dart';
import 'package:to_do_app_2/ui/custom_theme.dart';
import 'package:to_do_app_2/widgets/bottomSheetButton.dart';
import 'package:to_do_app_2/widgets/custom_button.dart';
import 'package:to_do_app_2/widgets/list_tile.dart';

import '../models/task.dart';
import '../services/notification_service.dart';
import '../services/theme_service.dart';
import '../ui/dimensions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final _taskController = Get.put(TaskController());
  // DateTime startDate = DateTime.parse("2022-11-18");
  var notifyHelper;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    // print("height $height");
    // print("width $width");
    return Scaffold(
      appBar: _appbar(),
      body: Column(
            children: [
              SizedBox(height: Dimensions.oneUnitHeight * 15,),
              _addTaskBar(),
              _addDateBar(),
              _showTask(),
            ],
          ),
    );
  }


  _notifySchedule({required bool isStart,required String times,required Task task}){
    notifyHelper.scheduledNotification(
      isStart,
      int.parse(times.toString().split(":")[0]),
      int.parse(times.toString().split(":")[1]),
      task,
    );
  }

  _showTask(){
    return Expanded(
      child: Obx((){
        return ListView.builder(
          itemCount: _taskController.taskList.length,
          itemBuilder: (_, index){
            Task task = _taskController.taskList[index];
            // print(task.toJson());
            if(task.repeat == "Daily"){
              DateTime starttimefromdb = DateFormat.jm().parse(task.startTime.toString()).subtract(Duration(minutes: task.remind!));
              DateTime endtimefromdb = DateFormat.jm().parse(task.endTime.toString()).subtract(Duration(minutes: task.remind!));
              var myStartTime = DateFormat("HH:mm").format(starttimefromdb);
              var myEndtime = DateFormat("HH:mm").format(endtimefromdb);
              _notifySchedule(isStart: true, times: myStartTime, task: task);
              _notifySchedule(isStart: false, times: myEndtime, task: task);
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }else if(task.repeat == "Weekly"){
              DateTime dateFromDb = DateFormat.yMMMd().parse(task.date!);
              final dateDifference = _selectedDate.difference(dateFromDb).inDays;
              if(dateDifference == 0 || dateDifference % 7 == 0){
                DateTime currentDate = DateTime.now();
                final curDateDifference = currentDate.difference(dateFromDb).inDays;
                if(curDateDifference == 0 || curDateDifference % 7 ==0){
                  DateTime starttimefromdb = DateFormat.jm().parse(task.startTime.toString()).subtract(Duration(minutes: task.remind!));
                  DateTime endtimefromdb = DateFormat.jm().parse(task.endTime.toString()).subtract(Duration(minutes: task.remind!));
                  var myStartTime = DateFormat("HH:mm").format(starttimefromdb);
                  var myEndtime = DateFormat("HH:mm").format(endtimefromdb);
                  _notifySchedule(isStart: true, times: myStartTime, task: task);
                  _notifySchedule(isStart: false, times: myEndtime, task: task);
                }
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: (){
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }else if(task.repeat == "Monthly") {
              DateTime dateFromDb = DateFormat.yMMMd().parse(task.date!);
              DateTime currentDate = _selectedDate;
              final dateDifference = currentDate
                  .difference(dateFromDb)
                  .inDays;
              if (dateDifference == 0 || dateDifference % 30 == 0) {
                DateTime currentDate = DateTime.now();
                final curDateDifference = currentDate.difference(dateFromDb).inDays;
                if(curDateDifference == 0 || curDateDifference % 30 ==0){
                  DateTime starttimefromdb = DateFormat.jm().parse(task.startTime.toString()).subtract(Duration(minutes: task.remind!));
                  DateTime endtimefromdb = DateFormat.jm().parse(task.endTime.toString()).subtract(Duration(minutes: task.remind!));
                  var myStartTime = DateFormat("HH:mm").format(starttimefromdb);
                  var myEndtime = DateFormat("HH:mm").format(endtimefromdb);
                  _notifySchedule(isStart: true, times: myStartTime, task: task);
                  _notifySchedule(isStart: false, times: myEndtime, task: task);
                }
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }else if(task.repeat == "None"){
              DateTime dateFromDb = DateFormat.yMMMd().parse(task.date!);
              DateTime currentDate = _selectedDate;
              final dateDifference = currentDate.difference(dateFromDb).inDays;
              if (dateDifference == 0) {
                DateTime currentDate = DateTime.now();
                final curDateDifference = currentDate.difference(dateFromDb).inDays;
                if (curDateDifference == 0) {
                  DateTime starttimefromdb = DateFormat.jm().parse(task.startTime.toString()).subtract(Duration(minutes: task.remind!));
                  DateTime endtimefromdb = DateFormat.jm().parse(task.endTime.toString()).subtract(Duration(minutes: task.remind!));
                  var myStartTime = DateFormat("HH:mm").format(starttimefromdb);
                  var myEndtime = DateFormat("HH:mm").format(endtimefromdb);
                  _notifySchedule(isStart: true, times: myStartTime, task: task);
                  _notifySchedule(isStart: false, times: myEndtime, task: task);
                }
                return AnimationConfiguration.staggeredList(
                  position: index,
                  child: SlideAnimation(
                    child: FadeInAnimation(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              _showBottomSheet(context, task);
                            },
                            child: TaskTile(task),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            }

            if(task.date ==  DateFormat.yMMMd().format(_selectedDate)){
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            _showBottomSheet(context, task);
                          },
                          child: TaskTile(task),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }else{
              return Container();
            }
          },
        );
      }),
    );
    // return _taskController.taskList;
  }


  _showBottomSheet(BuildContext context, Task task){
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(top: Dimensions.oneUnitHeight * 5),
        height: Dimensions.screenHeight * 0.32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.oneUnitHeight * 20),
            topRight: Radius.circular(Dimensions.oneUnitHeight * 20),
          ),
          color: Get.isDarkMode ? Colors.black.withOpacity(0.7) : Colors.white.withOpacity(0.7),
        ),
        child: Column(
          children: [
            Container(
              height: 7,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.oneUnitHeight * 10),
                color: Get.isDarkMode ? Colors.grey : Colors.grey.shade600,
              ),
            ),
            const Spacer(),
            if(task.isCompleted != 1)BottomSheetButtons(
                label: "Mark Task Completed",
                onTap:(){
                  _taskController.markTaskCompleted(task.id!);
                  Get.back();
                },
                clr: Get.isDarkMode ? const Color(0xFFff5349) : const Color(0xFF0D98BA),
            ),
            if(task.isCompleted == 1)BottomSheetButtons(
              label: "Mark Task Undo",
              onTap:(){
                _taskController.markTaskUndo(task.id!);
                Get.back();
              },
              clr: Get.isDarkMode ? const Color(0xFFff5349) : const Color(0xFF0D98BA),
            ),
            SizedBox(height: Dimensions.oneUnitHeight * 15,),
            BottomSheetButtons(
              label: "Delete Task",
              onTap:(){
                _taskController.delete(task);
                notifyHelper.deleteNotification(task.id!);
                Get.back();
              },
              clr: Colors.transparent,
              isDelete: true,
            ),
            SizedBox(height: Dimensions.oneUnitHeight * 40,),
            BottomSheetButtons(
              label: "Close",
              onTap:(){
                Get.back();
              },
              clr: Colors.transparent,
              isClose: true,
            ),
            SizedBox(height: Dimensions.oneUnitHeight * 20,),
          ],
        ),
      )
    );
  }

  _addDateBar(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: Dimensions.oneUnitHeight * 20,horizontal: Dimensions.oneUnitWidth * 10),
      // color: Colors.green,
      child: DatePicker(
        DateTime.now(),
        height: Dimensions.oneUnitHeight * 100,
        width: Dimensions.oneUnitWidth * 70,
        selectionColor: Get.isDarkMode ? const Color(0xFFff5349) : const Color(0xFF0D98BA),
        selectedTextColor: Colors.white,
        initialSelectedDate: DateTime.now(),
        dateTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Dimensions.oneUnitHeight * 22,
          color: Colors.grey,
          fontFamily: "RobotoCondensed",
        ),
        monthTextStyle:TextStyle(
          fontSize: Dimensions.oneUnitHeight * 12,
          color: Get.isDarkMode ? Colors.white : Colors.black,
          fontFamily: "RobotoCondensed",
        ),
        dayTextStyle:TextStyle(
          fontSize: Dimensions.oneUnitHeight * 12,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        onDateChange: (date){
          setState(() {
            _selectedDate = date;
          });
        },
      ),
    );
  }

  _addTaskBar(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: Dimensions.oneUnitWidth * 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: CustomsubHeadingStyle,
              ),
              Text("Today", style: CustomHeadingStyle,),
            ],
          ),
          CustomButton(
            label: "+ Add Task",
            onTap: () async{
              await Get.to(()=>AddTaskPage());
              _taskController.getTasks();
            }, rainbow: false,
          ),
        ],
      ),
    );
  }

  _appbar(){
    return AppBar(
      leading: GestureDetector(
        onTap: (){
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
            title : "Theme Changed",
            body : Get.isDarkMode ? "Activated Light mode" : "Activated Dark mode",
          );
          // notifyHelper.scheduledNotification();
        },
        child: Padding(
          padding: EdgeInsets.only(left: Dimensions.oneUnitWidth * 15.0),
          child: Icon(
            Get.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            size: Dimensions.oneUnitHeight * 30,
            color: context.theme.primaryColor,
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.to(() => HistoryScreen());
          },
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(context.theme.primaryColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("History",style: TextStyle(fontSize: Dimensions.oneUnitHeight * 18,fontFamily: "Cabin"),),
              SizedBox(width: Dimensions.oneUnitWidth * 5,),
              Icon(Icons.history_rounded,size: Dimensions.oneUnitHeight * 25,),
            ],
          ),
        ),
        SizedBox(width: Dimensions.oneUnitWidth * 15,),
      ],
    );
  }
}



