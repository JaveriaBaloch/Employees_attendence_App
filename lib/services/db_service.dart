import 'dart:math';

import 'package:employee_attendance_system/constants/constants.dart';
import 'package:employee_attendance_system/models/department_model.dart';
import 'package:employee_attendance_system/models/user_model.dart';
import 'package:employee_attendance_system/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService extends ChangeNotifier{
 final SupabaseClient _supabase = Supabase.instance.client;
  UserModel? userModel;
  List<DepartmentModel> allDeparment = [];
  int? employeeDepartment;
 String generateRandomEmployeeId(){
   final random = Random();
   const allChar = "faangFaang0123456789";
   final randomString = List.generate(8, (index) => allChar[random.nextInt(allChar.length)]).join();
   return randomString;
 }

 Future insertNewUserData( String email, var id) async {
  await _supabase.from(Constants.employeeTable).insert({
    'id':id,
    'name':'',
    'email':email,
    'employeeId': generateRandomEmployeeId(),
    'department': null

  });
}
    Future<UserModel?> getUserData()async{
       final userData = await _supabase.from(Constants.employeeTable).select().eq('id', _supabase.auth.currentUser!.id).single();
        userModel = UserModel.fromJson(userData);
        employeeDepartment == null? userModel?.department: null;
        return userModel!;
    }
    Future<void> gatAllDepartments() async{
      final List result = await _supabase.from(Constants.departmentTable).select();
      allDeparment = result.map((department) => DepartmentModel.fromJson(department)).toList();
      notifyListeners();
    }
    Future updateProfile( String name, BuildContext context)async{
        await _supabase
            .from(Constants.employeeTable)
            .update({'name':name, 'department':employeeDepartment})
            .eq('id',_supabase.auth.currentUser!.id);
        Utils.showSnackBar("updated successfully", context, color: Colors.green);
    }
}