import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:spartst/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // await dotenv.load(fileName: ".env");
  // DioManager.init();
  // debugRepaintRainbowEnabled = true;
  runApp(const MyApp());
  // Lock the orientation to portrait

}

