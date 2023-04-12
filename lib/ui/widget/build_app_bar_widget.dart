
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../theme.dart';

AppBar buildAppBar(String? title, Function()? onPressed, IconData icon, BuildContext ctx) {
  return AppBar(
    elevation: 0,
    title: Text(title!, style: titleStyle.copyWith(
      color: Get.isDarkMode? Colors.white: Colors.grey[900]
    )),
    leading: IconButton(
        icon: Icon(icon, color:Get.isDarkMode? Colors.white: Colors.grey[900]),
        onPressed: onPressed),
    backgroundColor: ctx.theme.colorScheme.background,
    centerTitle: true,
    actions: const [
      Padding(
        padding: EdgeInsets.only(
          right: 10,
        ),
        child: CircleAvatar(
          backgroundImage: AssetImage('images/person.jpeg'),
        ),
      ),
    ],
  );
}
