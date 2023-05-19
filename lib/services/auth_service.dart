import 'dart:math';

import 'package:employee_attendance_system/services/db_service.dart';
import 'package:employee_attendance_system/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier{
  final SupabaseClient _supabase = Supabase.instance.client;
  final DBService _dbService = DBService();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }

  Future registerEmployee( String email, String password, BuildContext context)async{
    try {
      setIsLoading = true;
      if (email.isEmpty || password.isEmpty) {
        throw ("All Fields are required");
      } else {
        final AuthResponse response = await _supabase.auth.signUp(
            email: email, password: password
        );
        if(response != null){
          await _dbService.insertNewUserData(email, response.user?.id);
          Utils.showSnackBar("Successfully Registered!",context,color: Colors.green);
          await loginEmployee(email, password, context);
          Navigator.pop(context);
        }
      }
    } catch(error){
      setIsLoading = false;
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
      print(error);
    }
  }

  Future loginEmployee(String email, String password, BuildContext context)async{
    try{
      setIsLoading = true;
      if (email.isEmpty || password.isEmpty) {
        throw ("All Fields are required");
      } else {
        final AuthResponse response = await _supabase.auth.signInWithPassword(
            email: email, password: password
        );
        setIsLoading = false;
      }
    }catch(error){
      setIsLoading = false;
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
      print(error);
    }
  }
  Future signOut() async {
    await _supabase.auth.signOut();
    notifyListeners();
  }

  User? get currentUser => _supabase.auth.currentUser;

}