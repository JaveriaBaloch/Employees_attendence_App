import 'package:employee_attendance_system/screens/attendance_screen.dart';
import 'package:employee_attendance_system/screens/home_screen.dart';
import 'package:employee_attendance_system/screens/login_screen.dart';
import 'package:employee_attendance_system/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget{
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context){
    final authService = Provider.of<AuthService>(context);
    return authService.currentUser == null? const LoginScreen(): const HomeScreen();
    // Scaffold(
    //   backgroundColor: Colors.redAccent,
    //   body: Center(
    //     child: Icon(Icons.qr_code_scanner, color: Colors.white,size: 70,),
    //   ),
    // );
  }
}