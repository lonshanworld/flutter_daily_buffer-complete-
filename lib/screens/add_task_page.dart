import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app_2/controllers/task_controller.dart';
import 'package:to_do_app_2/models/task.dart';
import 'package:to_do_app_2/ui/custom_theme.dart';
import 'package:to_do_app_2/widgets/custom_button.dart';
import 'package:to_do_app_2/widgets/input_fields.dart';

import '../ui/dimensions.dart';

class AddTaskPage extends StatefulWidget {
  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {

  final TaskController _taskController = Get.put(TaskController());
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat.jm().format(DateTime.now());
  String _endTime = DateFormat.jm().format( DateTime.now().add(const Duration(minutes: 75)));
  int _selectedRemind = 0;
  List<int> remindLists = [0,5,10,20,40,60];
  String _selectedRepeat = "None";
  List<String> repeatList =["None", "Daily", "Weekly", "Monthly"];
  List<Color> colorList = [Colors.green, Colors.yellow.shade600, Colors.blue.shade800, Colors.red.shade800, Colors.purple, Colors.orange.shade700];
  int _selectedColor = 1;

  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _notecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    showtimepicker(){
      return showTimePicker(
        initialEntryMode: TimePickerEntryMode.dial,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ),
      );
    }

    getDateFromUser() async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2010),
        lastDate: DateTime(2200),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Get.isDarkMode
                  ?
                const ColorScheme.light(
                  primary: Color(0xFFff5349),
                  onPrimary: Colors.white,
                  onSurface: Colors.white,
                )
                  :
                const ColorScheme.light(
                  primary:  Color(0xFF0D98BA),
                  onPrimary: Colors.black,
                  onSurface: Colors.black,
                ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Get.isDarkMode ? const Color(0xFFff5349) : const Color(0xFF0D98BA), // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
      );
      if(pickedDate != null) {
        setState(() {
          _selectedDate = pickedDate;
        });
      }
    }
    getTimeFromUser(bool isStartTime) async {
      var pickedTime = await showtimepicker();
      String formattedTime = pickedTime!.format(context);
      if(isStartTime == true){
        setState(() {
          _startTime = formattedTime;
        });
      }else if(isStartTime == false){
        setState(() {
          _endTime = formattedTime;
        });
      }
    }

    addTasktoDB() {
      _taskController.addTask(task : Task(
        title: _titlecontroller.text,
        note: _notecontroller.text,
        isCompleted: 0,
        date: DateFormat.yMMMd().format(_selectedDate),
        startTime: _startTime,
        endTime: _endTime,
        color: _selectedColor,
        remind: _selectedRemind,
        repeat: _selectedRepeat,
      ));
    }

    validateData(){
      if(_titlecontroller.text.isNotEmpty && _notecontroller.text.isNotEmpty){
        addTasktoDB();
        Get.back();
      }else{
        Get.snackbar(
          "Attention !!!",
          "All fields are required to be filled",
          backgroundColor: Colors.red.withOpacity(0.4),
          colorText: Get.isDarkMode ? Colors.white : Colors.black,
          snackPosition: SnackPosition.BOTTOM,
          icon: Icon(Icons.error,size: Dimensions.oneUnitHeight * 25,),
        );
      }
    }

    return Scaffold(
      appBar: _appbar(context),
      body: ListView(
        padding: EdgeInsets.only(
          left: Dimensions.oneUnitWidth * 20 ,
          right: Dimensions.oneUnitWidth * 20,
          bottom: Dimensions.oneUnitHeight * 40,
          top: Dimensions.oneUnitHeight * 20,
        ),
        children: [
          Container(
            // padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text(
              "Add Task",
              style: CustomHeadingStyle,
            ),
          ),
          CustomTextFields(title: "Title", hintTxt: "Enter title here", ctlr: _titlecontroller,),
          CustomTextFields(title: "Note", hintTxt: "Enter your note", ctlr: _notecontroller,),
          CustomTextFields(
            title: "Date",
            hintTxt: DateFormat.yMMMd().format(_selectedDate),
            wgt: IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              onPressed: getDateFromUser,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: CustomTextFields(
                  title: "Start Time",
                  hintTxt: _startTime,
                  wgt: IconButton(
                    icon: const Icon(Icons.access_time_rounded),
                    onPressed: (){
                      getTimeFromUser(true);
                    },
                  ),
                ),
              ),
              SizedBox(width: Dimensions.oneUnitWidth * 20,),
              Expanded(
                child: CustomTextFields(
                  title: "End Time",
                  hintTxt: _endTime,
                  wgt: IconButton(
                    icon: const Icon(Icons.access_time_rounded),
                    onPressed: (){
                      getTimeFromUser(false);
                    },
                  ),
                ),
              ),
            ],
          ),
          CustomTextFields(
            title: "Reminder",
            hintTxt: "$_selectedRemind minutes earlier",
            wgt: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                iconSize: Dimensions.oneUnitHeight * 32,
                elevation: 5,
                items: remindLists.map<DropdownMenuItem<String>>((int value){
                    return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString())
                    );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRemind = int.parse(value!);
                  });
                },
              ),
            ),
          ),
          CustomTextFields(
            title: "Repeat   (Monthly repeat will have 30 days duration)",
            hintTxt: _selectedRepeat,
            wgt: DropdownButtonHideUnderline(
              child: DropdownButton(
                icon: const Icon(Icons.keyboard_arrow_down_outlined),
                iconSize:Dimensions.oneUnitHeight *  32,
                elevation: 5,
                items: repeatList.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value)
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    _selectedRepeat = value!;
                  });
                },
              ),
            ),
          ),
          SizedBox(height: Dimensions.oneUnitHeight * 25,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Colors", style: Customtitle,),
                  SizedBox(height:Dimensions.oneUnitHeight *  5,),
                  Wrap(
                    children: List<Widget>.generate(6, (index) => GestureDetector(
                      onTap: (){
                        setState(() {
                          _selectedColor = index;
                        });
                      },
                      child: Padding(
                        padding: EdgeInsets.only( right: Dimensions.oneUnitWidth * 8.0),
                        child: CircleAvatar(
                          radius: Dimensions.oneUnitHeight * 14,
                          backgroundColor: colorList[index],
                          child: _selectedColor == index
                              ?
                            Icon(
                              Icons.done,
                              size: Dimensions.oneUnitHeight * 26,
                              color: Get.isDarkMode ? Colors.white : Colors.black,
                            )
                              :
                            Container(),
                        ),
                      ),
                    )),
                  ),
                ],
              ),
              CustomButton(
                label: "+ Create",
                onTap: validateData,
                rainbow: true,
                rainbowColors: colorList[_selectedColor],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _appbar(BuildContext context) {
    return AppBar(
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
      actions: [
        Icon(
          Icons.person,
          size: Dimensions.oneUnitHeight * 30,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
        SizedBox(
          width: Dimensions.oneUnitWidth * 15,
        ),
      ],
    );
  }
}
