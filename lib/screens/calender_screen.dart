import 'package:employee_attendance_system/models/attendance_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import '../services/attendance_service.dart';
import '../utils/bottom_nav.dart';


class CalenderScreen extends StatefulWidget{
  const CalenderScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CalenderScreenState();
}
class _CalenderScreenState extends State<CalenderScreen>{

  @override
  Widget build(BuildContext context){
    final attendanceService = Provider.of<AttendanceService>(context);

    return  Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 20,top: 60,bottom: 10),
            child: const Text("My Attendance", style: TextStyle(fontSize: 25),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(attendanceService.attendanceHistoryMonth, style: const TextStyle(fontSize: 25),),
              OutlinedButton(
                  onPressed: ()async{
                    // disable future dates by disableFuture = true
                    final selectedDate = await SimpleMonthYearPicker.showMonthYearPickerDialog
                      (context: context,disableFuture: true);
                    String pickedMonth = DateFormat('MMMM yyyy').format(selectedDate);
                    attendanceService.attendanceHistoryMonth = pickedMonth;
                  },
                  child: const Text("Pick a Month"))
            ],
          ),
          Expanded(child: FutureBuilder(
            future: attendanceService.getAttendenceHistory(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                if(snapshot.data.length>0){
                  // print(snapshot.data);
                      return ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context,index){
                            AttendanceModel attendanceData  = snapshot.data[index];
                            // return Text("$index");
                            return Container(
                              margin: const EdgeInsets.only(top: 12,left: 20, right: 20, bottom: 10),
                              height: 150,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26, blurRadius: 10, offset: Offset(2,2)
                                  )
                                ],
                                borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(),
                                          decoration: const BoxDecoration(
                                            color: Color(0xffFF004F),
                                            borderRadius: BorderRadius.all(Radius.circular(20))
                                          ),
                                          child: Center(
                                            child: Text(DateFormat("EE \n dd").format(DateTime.parse(attendanceData.createdAt))
                                            ,style: const TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold
                                              ),),
                                          ),
                                        )
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Text("Check in", style: TextStyle(fontSize: 20, color: Colors.black54),),
                                          const SizedBox(
                                            width: 80,
                                            child: Divider()
                                          ),
                                          Text(attendanceData.checkIn, style: const TextStyle(fontSize: 25),)
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Text("Check Out", style: TextStyle(fontSize: 20, color: Colors.black54),),
                                          const SizedBox(
                                              width: 80,
                                              child: Divider()
                                          ),
                                          Text(attendanceData?.checkOut.toString()?? '--/--', style: const TextStyle(fontSize: 25),)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15,)
                                  ],
                                )
                            );
                          });
                }
                else{
                  return const Center(
                    child: Text("No Data Available"),
                  );
                }
              }else{
                return const LinearProgressIndicator(color: Colors.grey,backgroundColor: Colors.black54,);
              }
            },
          )
          )
        ],

      ),

      bottomNavigationBar: const BottomNav(currentIndex: 0,),

    );
  }
}