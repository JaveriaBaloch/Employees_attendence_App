import 'package:employee_attendance_system/screens/login_screen.dart';
import 'package:employee_attendance_system/screens/splash_screen.dart';
import 'package:employee_attendance_system/services/attendance_service.dart';
import 'package:employee_attendance_system/services/auth_service.dart';
import 'package:employee_attendance_system/services/db_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget{
  const Home({super.key});
  @override
  Widget build(BuildContext context){
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=>AuthService()),
        ChangeNotifierProvider(create: (context)=>DBService()),
        ChangeNotifierProvider(create: (context)=>AttendanceService())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Employee Attendance",
        theme:  ThemeData(
          primarySwatch: Colors.blue
        ),
        home: const  SplashScreen(),
      ),
    );
  }
}