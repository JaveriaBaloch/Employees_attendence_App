
import 'package:employee_attendance_system/models/attendance_model.dart';
import 'package:employee_attendance_system/services/attendance_service.dart';
import 'package:employee_attendance_system/utils/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

import '../models/user_model.dart';
import '../services/db_service.dart';

class AttendanceScreen extends StatefulWidget{
  const AttendanceScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AttendanceScreenState();
}
class _AttendanceScreenState extends State<AttendanceScreen>{
  final GlobalKey<SlideActionState> key = GlobalKey<SlideActionState>();
  
  @override
  // only first time call
  void initState(){
    Provider.of<AttendanceService>(context,listen: false).getTodayAttendance();
    super.initState();

  }
  @override
  Widget build(BuildContext context){
    final attendanceService = Provider.of<AttendanceService>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: const Text("Welcome", style:
                  TextStyle(color: Colors.black54, fontSize: 30),),
              ),
            Consumer<DBService>(builder: (context,dbService,child){
              return FutureBuilder(
                  future: dbService.getUserData(),
                  builder:(context,snapshot) {
                    if (snapshot.hasData) {
                      UserModel? user = snapshot.data;
                          return  Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              user?.name !=''? user!.name:"#${user!.employeeId}",
                              style: const TextStyle(fontSize: 25),
                    ));

                    }
                    else{
                      return const SizedBox(
                        width: 60,
                        child: LinearProgressIndicator(),
                      );
                    }
                  },
                );
            }),

            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: const Text("Today's Status", style:
              TextStyle(color: Colors.black54, fontSize: 20),),
            ),
            Container(
              margin: const EdgeInsets.only(top: 12, bottom: 22),
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2)
                )
                ],
                borderRadius: BorderRadius.all(Radius.circular(30))
              ),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Check In", style: TextStyle(fontSize: 20, color: Colors.black54),),
                          const SizedBox(width: 80, child: Divider()),
                          Text(
                            attendanceService.attendanceModel?.checkIn ?? '--/--',
                            style: TextStyle(fontSize: 25,color: Colors.black),)
                        ],
                      )
                  ),
                  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Checkout", style: TextStyle(fontSize: 20, color: Colors.black54),),
                          const SizedBox(width: 80, child: Divider()),
                          Text( attendanceService.attendanceModel?.checkOut ?? '--/--', style: TextStyle(fontSize: 25,color: Colors.black),)
                        ],
                      )
                  )
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: Text(DateFormat('dd MMMM yyyy').format(DateTime.now()), style: TextStyle(fontSize: 20),),
            ),
            StreamBuilder(
                stream: Stream.periodic(const Duration(seconds: 1)),
                builder: (context, snapshot) {
                  return Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat("hh:mm:ss a").format(DateTime.now()),
                      style: const TextStyle(fontSize: 15, color: Colors.black54),
                    ),
                  );
                }),
           
            Container(
              margin: const EdgeInsets.only(top: 25),
              child: Builder(builder: (context){
                return SlideAction(
                  text:  attendanceService.attendanceModel?.checkIn ==null ? "Slide to check in":  "Slide to checkout",
                  textStyle: const TextStyle(color: Colors.black54, fontSize: 18),
                  outerColor: const Color(0xFFFFFFFF),
                  innerColor: const Color(0xffFF004F),
                  key: key,
                  onSubmit: () async{
                    await attendanceService.markAttendance(context);
                    key.currentState!.reset();
                  },
                );
              },),
            )
          ],
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 1,),
    );
  }
}