import 'package:reliable_app/models/admin_login_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:reliable_app/models/student_model.dart';
import 'package:reliable_app/utils/my_print.dart';

class UserProvider extends ChangeNotifier {
  StudentModel? studentModel;
  AdminLoginModel? adminLoginModel;
}