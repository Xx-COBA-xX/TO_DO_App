// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../size_config.dart';
import '../theme.dart';

class InputFormF extends StatelessWidget {
  final String title;
  final String hint;
  final Widget? widget;
  final TextEditingController? controller;
  final Function()? onPressed;

  const InputFormF(
      {super.key,
      required this.title,
      required this.hint,
      this.widget,
      this.controller,
      this.onPressed});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: subTitleStyle.copyWith(
              color: Get.isDarkMode ? white : Colors.grey[900]),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 55,
          width: SizeConfig.screenWidth,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Get.isDarkMode
                    ? Colors.grey
                    : const Color.fromARGB(255, 54, 54, 54),
              )),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  style: subTitleStyle.copyWith(color: Get.isDarkMode?white : darkGreyClr),
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: descStyle.copyWith(
                        color: Get.isDarkMode ? white : Colors.grey[900]),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                  ),
                  readOnly: widget != null ? true : false
                ),
              ),
              widget ?? Container(width:0,),
            ],
          ),
        ),
      ],
    );
  }
  
}
