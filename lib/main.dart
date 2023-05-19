import 'package:employee_attendance_system/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // load env
  await dotenv.load();
  // initialize supabase
  String supabaseUrl = dotenv.env['SUPABASE_URL']?? '';
  String supabaseKey = dotenv.env['SUPABASE_KEY']?? '';
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);


  runApp(MaterialApp(home: Home(),));
}

