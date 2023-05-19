import 'package:employee_attendance_system/screens/attendance_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState () => _HomeScreenState();
}
class _HomeScreenState extends State<HomeScreen>{
  int currentIndex = 1;

  @override
  Widget build(BuildContext context){
   return const Scaffold(
     // appBar: AppBar(
     //   title: const Text("Employee Attendance"),
     //   backgroundColor: Colors.redAccent,
     // ),
     body: Center(
       child: AttendanceScreen(),
     ),
   );
 }
}
