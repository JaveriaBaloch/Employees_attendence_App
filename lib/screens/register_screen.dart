import 'package:employee_attendance_system/screens/login_screen.dart';
import 'package:employee_attendance_system/services/auth_service.dart';
import 'package:employee_attendance_system/utils/red_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget{
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();

}
class _RegisterScreenState extends State<RegisterScreen>{

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context){

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor:const Color(0xffFF004F),
        automaticallyImplyLeading: false,

        elevation: 0,
      ),
      resizeToAvoidBottomInset: false ,
      body: Column(
        children: <Widget>[
          Container(
            height: screenHeight/4,
            width: screenWidth,
            decoration:  const BoxDecoration(
                color:  Color(0xffFF004F),
                borderRadius:BorderRadius.only(bottomRight: Radius.circular(70))
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.qr_code_scanner, color: Colors.white,size: 80,),
                SizedBox(height: 20,),
                Text("Faang", style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          const SizedBox(height: 50,),
          Padding(padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextField(
                  decoration: const InputDecoration(
                      label: Text("Employee Email ID"),
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder()
                  ),
                  controller: _emailController,
                ),
                const SizedBox(height: 20,),
                TextField(
                  decoration: const InputDecoration(
                    label: Text("Password"),
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  controller: _passwordController,
                  obscureText: true,
                ),
                const SizedBox(height: 30,),

                Consumer<AuthService>(builder: (context,authServiceProvider,child){
                  return SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: authServiceProvider.isLoading? const Center(
                      child: CircularProgressIndicator(backgroundColor: Color(0xffFF004F),),
                    ): ElevatedButton(
                      onPressed: (){
                       authServiceProvider.registerEmployee(_emailController.text.trim(), _passwordController.text, context);
                      },
                      style: MyRedButtonStyle(),
                      child: Text("Register".toUpperCase(),style: const TextStyle(fontSize: 20),),
                    ),

                  );
                }
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                }, child: const Text("Already have an account? Login here")
                )
              ],
            ),)
        ],
      ),
    );
  }
}