import "package:flutter/material.dart";
import "package:get/get.dart";

import '../ui/dimensions.dart';

class BottomSheetButtons extends StatelessWidget {

  final String label;
  final VoidCallback onTap;
  final Color clr;
  final bool? isClose;
  final bool? isDelete;

  const BottomSheetButtons({Key? key, required this.label, required this.onTap, required this.clr, this.isClose = false, this.isDelete = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 20)),
      color: isClose == true ? Colors.transparent : clr,
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 20)),
        splashColor: Colors.white.withOpacity(0.3),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          // margin: EdgeInsets.symmetric(vertical: 4),
          padding: EdgeInsets.symmetric(vertical: Dimensions.oneUnitHeight * 10),
          width: Dimensions.screenWidth * 0.9,
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: isClose == true ? Get.isDarkMode ? Colors.white : Colors.black :Colors.transparent,
            ),
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 20)),
            color: Colors.transparent,
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: "Cabin",
              color: isDelete == true ? Colors.red : context.theme.primaryColor,
              fontSize: isDelete == true ? Dimensions.oneUnitHeight * 20 : Dimensions.oneUnitHeight * 16,
              fontWeight: isDelete == true ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
