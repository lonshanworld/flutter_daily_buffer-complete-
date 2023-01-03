import "package:flutter/material.dart";
import "package:get/get.dart";

import '../ui/dimensions.dart';
import '../widgets/bottomSheetButton.dart';

class NotifiedPage extends StatelessWidget {
  final String label;

  NotifiedPage({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title =  label.toString().split("|")[1];
    final note = label.toString().split("|")[2];
    final startTime = label.toString().split("|")[3];
    final endTime = label.toString().split("|")[4];
    final repeat = label.toString().split("|")[5];
    final remind = label.toString().split("|")[6];
    final isComplete = label.toString().split("|")[7];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios,color: Get.isDarkMode ? Colors.white : Colors.black,),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: "Cabin",
            fontSize: Dimensions.oneUnitHeight * 20,
            color: context.theme.primaryColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.access_time_rounded,
                color: context.theme.primaryColor,
                size:20,
              ),
              SizedBox(width: Dimensions.oneUnitWidth * 4),
              Text(
                "$startTime - $endTime",
                style: TextStyle(
                    fontSize: Dimensions.oneUnitHeight * 14,
                    color: context.theme.primaryColor,
                    fontFamily: "RobotoCondensed"
                ),
              ),
              SizedBox(width: Dimensions.oneUnitWidth * 10,),
              Container(
                padding: EdgeInsets.all(Dimensions.oneUnitHeight * 3),
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 5)),
                ),
                child: Text(
                  "Repeat : $repeat",
                  style: TextStyle(
                    fontSize: Dimensions.oneUnitHeight * 13,
                    color: Colors.grey,
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
                    color:Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 5)),
                ),
                child: Text(
                  "Notify $remind Mins earlier",
                  style: TextStyle(
                    fontSize: Dimensions.oneUnitHeight * 13,
                    color: Colors.grey,
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
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 5)),
                ),
                child: Text(
                  isComplete == "1" ? "Already Completed" : "Not Complete",
                  style: TextStyle(
                    fontSize: Dimensions.oneUnitHeight * 13,
                    color: Colors.grey,
                    fontFamily: "Cabin",
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Dimensions.oneUnitHeight * 20),
          Text(
            note,
            style: TextStyle(
              fontSize: Dimensions.oneUnitHeight * 13,
              color: context.theme.primaryColor,
              fontFamily: "Cabin",
            ),
          ),

          SizedBox(height: Dimensions.oneUnitHeight * 40),
          BottomSheetButtons(
            label: "Close",
            onTap:(){
              Get.back();
            },
            clr: Colors.transparent,
            isClose: true,
          ),
        ],
      ),
    );
  }
}
