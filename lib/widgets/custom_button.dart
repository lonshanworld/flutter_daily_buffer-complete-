import "package:flutter/material.dart";
import 'package:get/get.dart';

import '../ui/dimensions.dart';

class CustomButton extends StatelessWidget {

  final String label;
  final VoidCallback onTap;
  final bool rainbow;
  final Color? rainbowColors;

  const CustomButton({Key? key, required this.label, required this.onTap, required this.rainbow, this.rainbowColors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 10)),
      color: rainbow ? rainbowColors : Get.isDarkMode ? const Color(0xFFff5349) : const Color(0xFF0D98BA),
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 10)),
        splashColor: Colors.white.withOpacity(0.3),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.oneUnitWidth * 20,vertical: Dimensions.oneUnitHeight * 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 10)),
            color: Colors.transparent,
          ),
          child: Text(
              label,
            style: TextStyle(
              fontFamily: "Cabin",
              fontSize: Dimensions.oneUnitHeight * 17,
              color: Get.isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
