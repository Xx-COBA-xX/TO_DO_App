import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:to_do/controller/task_controller.dart';
import 'package:to_do/db/db_helper.dart';
import 'package:to_do/services/theme_services.dart';
import 'package:to_do/ui/screens/home_screen.dart';
import 'package:to_do/ui/theme.dart';

void main() async{
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await DBHelpler.initDB();

  //NotificationHelper().initializationNotification();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeServices().theme,
      debugShowCheckedModeBanner: false,
      // home: const NotificationScreen(payload: "Haider|Habeeb|Hameed"),
      home: const HomeScreen(),
    );
  }
}
