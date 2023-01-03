import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import "package:get/get.dart";
import 'package:get_storage/get_storage.dart';
import 'package:to_do_app_2/db/db_Helpers.dart';
import './screens/homePage.dart';
import './services/theme_service.dart';
import './ui/custom_theme.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DBhelper.initDB();
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Daily Buffer",
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      themeMode: ThemeService().theme,
      home: HomePage(),
    );
  }
}
