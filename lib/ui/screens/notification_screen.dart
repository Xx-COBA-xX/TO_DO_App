import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:to_do/services/theme_services.dart';

import '../theme.dart';
import '../widget/notification_build_title_widget.dart';

class NotificationScreen extends StatefulWidget {
  final String? payload;
  const NotificationScreen({super.key, required this.payload});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.colorScheme.background,
        appBar: AppBar(
          elevation: 0,
          title: Text(
            widget.payload!.split('|')[0],
            style: titleStyle
          ),
          leading: IconButton(
            icon:  Icon(Icons.arrow_back_ios, color: Colors.grey[100]),
            onPressed: (){
              Get.back();
            },
          ),
          backgroundColor: Get.isDarkMode? darkGreyClr: primaryClr,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Hello , ${widget.payload!.split('|')[0]}",
                  style: titleStyle.copyWith(
                    color: Get.isDarkMode? white: Colors.grey[900]
                  )
                ),
                Text(
                  'You have a new remender',
                  style: subTitleStyle.copyWith(
                    color: Get.isDarkMode? white: Colors.grey[900]
                  )
                  )
              ],
            ),
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(19),
                  color: Get.isDarkMode ? darkGreyClr : primaryClr,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      buildTItle(Icons.account_balance_wallet_rounded, "title",
                          'Haider'),
                      const SizedBox(
                        height: 25,
                      ),
                      buildTItle(
                          Icons.description, "Description", 'description'),
                      const SizedBox(
                        height: 25,
                      ),
                      buildTItle(Icons.access_alarm, "Time", '10:45'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
