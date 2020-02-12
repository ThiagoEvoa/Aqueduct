import 'package:my_api/my_api.dart';

class Config extends Configuration{
  Config(String path) : super.fromFile(File(path));

  DatabaseConfiguration database;
}