
import 'package:employee_attendance_system/screens/splash_screen.dart';
import 'package:employee_attendance_system/services/auth_service.dart';
import 'package:employee_attendance_system/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:employee_attendance_system/models/department_model.dart';
import '../utils/bottom_nav.dart';
import '../utils/red_buttons.dart';


class ProfileScreen extends StatefulWidget{
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen>{
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context){
    final dbService = Provider.of<DBService>(context);
    //using below conditions because build can be called multiple times as notify listener are in use
    dbService.allDeparment.isEmpty ? dbService.gatAllDepartments():null;
    nameController.text.isEmpty ? nameController.text = dbService.userModel?.name?? '':null;
    return Scaffold(
      body: dbService.userModel == null ? const Center(
        child: CircularProgressIndicator(),
      ): Padding(
          padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Container(
                margin: const EdgeInsets.only(top: 80,),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color(0xffFF004F)
                ),
                child: const Center(
                  child: Icon(Icons.person,color: Colors.white,size: 50,),
                ),
              ),
              const SizedBox(height: 15,),
              Text("Employee ID :  ${dbService.userModel!.employeeId}"),
              const SizedBox(height: 30,),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  label: Text("Full Name"),
                  border: OutlineInputBorder()
                ),
              ),
              const SizedBox(height: 15,),
              dbService.allDeparment.isEmpty? const LinearProgressIndicator(): SizedBox(
                width: double.infinity,
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder()
                  ),
                  value: dbService.employeeDepartment?? dbService.allDeparment.first.id,
                  items: dbService.allDeparment.map((DepartmentModel department){
                    return DropdownMenuItem(
                      value: department.id,
                        child: Text(department.title, style: const TextStyle(fontSize: 20),)
                    );
                  }
                  ).toList(),
                  onChanged: (int? selectedValue) {
                          dbService.employeeDepartment = selectedValue;
                },
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                  style: MyRedButtonStyle(),
                  child: const Text("Update profile",style: TextStyle(fontSize: 25),),
                  onPressed: (){
                        dbService.updateProfile(nameController.text.trim(), context);
                  },
                ),
              ),
              const SizedBox(height: 20,),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.bottomCenter,

                child: TextButton.icon(
                  style: MyRedButtonStyle(),
                    onPressed: () {
                      Provider.of<AuthService>(context, listen: false)
                          .signOut();
                      Navigator.push(context,MaterialPageRoute(builder: (context)=> const SplashScreen()));
                    },
                    icon: const Icon(Icons.logout,color:Colors.white),
                    label: const Text("Sign Out",style: TextStyle(color: Colors.white, fontSize: 20),)),
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNav(currentIndex: 2,),

    );
  }
}