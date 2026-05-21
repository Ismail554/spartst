import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiEndpoints {
  static String get baseUrl => dotenv.env['BASE_URL']?? "https://api.spartst.com/";
}
