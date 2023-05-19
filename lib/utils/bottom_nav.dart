import 'package:employee_attendance_system/screens/attendance_screen.dart';
import 'package:employee_attendance_system/screens/calender_screen.dart';
import 'package:employee_attendance_system/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomNav extends StatefulWidget{
  final int currentIndex;
  const BottomNav({super.key,required this.currentIndex});

  @override

  State<BottomNav> createState () => _BottomNavState();
}
class _BottomNavState extends State<BottomNav>{

  @override
  Widget build(BuildContext context){
    List<IconData> navigationIcon = [
      FontAwesomeIcons.solidCalendarDays,
      FontAwesomeIcons.check,
      FontAwesomeIcons.solidUser
    ];
    return  Container(
          height: 70,
          margin: const EdgeInsets.only(left: 12, right: 12,bottom: 24),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(40)),
              boxShadow: [
                BoxShadow(color: Colors.black26,blurRadius: 10,offset: Offset(2,2) )
              ]
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for(int i=0; i<navigationIcon.length;i++)...{

                Expanded(
                    child: GestureDetector(
                        onTap: (){
                          setState(() {
                            if(i==0){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const CalenderScreen()));
                            }
                            else if(i==1){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const AttendanceScreen()));
                            }
                            else if(i==2){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>const ProfileScreen()));
                            }
                          });
                        },
                        child: Center(
                          child: FaIcon(
                            navigationIcon[i],
                            color: i==widget.currentIndex?  Color(0xffFF004F): Colors.black54,
                            size: i==widget.currentIndex? 30:26,
                          ),
                        )
                    )
                )

              }
            ],
          ),
        );
  }
}
