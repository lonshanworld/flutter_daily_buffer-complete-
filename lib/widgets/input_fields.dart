import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:to_do_app_2/ui/custom_theme.dart';

import '../ui/dimensions.dart';

class CustomTextFields extends StatefulWidget {

  final String title;
  final String hintTxt;
  final TextEditingController? ctlr;
  final Widget? wgt;

  const CustomTextFields({
    Key? key,
    required this.title,
    required this.hintTxt,
    this.ctlr,
    this.wgt
  }) : super(key: key);

  @override
  State<CustomTextFields> createState() => _CustomTextFieldsState();
}

class _CustomTextFieldsState extends State<CustomTextFields> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: Customtitle,
          ),
          Container(
            height: Dimensions.oneUnitHeight * 50,
            margin: EdgeInsets.only(top: Dimensions.oneUnitHeight * 5),
            padding: EdgeInsets.only(left: Dimensions.oneUnitWidth * 14,right: Dimensions.oneUnitWidth * 5),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1,
              ),
              borderRadius: BorderRadius.all(Radius.circular(Dimensions.oneUnitHeight * 12)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: widget.wgt == null ? false : true,
                    autofocus: false,
                    cursorColor: Get.isDarkMode ? Colors.grey[100] : Colors.grey[700],
                    style: Customsubtitle,
                    controller: widget.ctlr,
                    decoration: InputDecoration(
                      hintText: widget.hintTxt,
                      hintStyle: TextStyle(
                        color: widget.wgt == null ? Colors.grey : context.theme.primaryColor,
                        fontFamily: widget.wgt == null ? "Cabin" : "RobotoCondensed",
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(widget.wgt != null)Container(
                  child: widget.wgt,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
