
import 'package:employee_attendance_system/constants/constants.dart';
import 'package:employee_attendance_system/models/attendance_model.dart';
import 'package:employee_attendance_system/services/location_service.dart';
import 'package:employee_attendance_system/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AttendanceService extends ChangeNotifier{
 final SupabaseClient _supabase = Supabase.instance.client;
 AttendanceModel? attendanceModel;


 String todayDate = DateFormat('dd MMMM yyyy').format(DateTime.now());

 bool _isLoading = false;
 bool get isLoading => _isLoading;
 set setIsLoading(bool value){
   _isLoading = value;
   notifyListeners();
 }


 String _attendanceHistoryMonth = DateFormat("MMMM yyyy").format(DateTime.now());
 String get attendanceHistoryMonth => _attendanceHistoryMonth;
 set attendanceHistoryMonth( String value){
   _attendanceHistoryMonth = value;
   notifyListeners();
 }
 Future getTodayAttendance() async{
   final List result = await _supabase
       .from(Constants.attendanceTable)
       .select().eq('employeeId', _supabase.auth.currentUser!.id)
       .eq('date', todayDate);
   if(result.isNotEmpty){
     attendanceModel = AttendanceModel.fromJson(result.first);
   }
   notifyListeners();
 }

 Future markAttendance(BuildContext context) async{
   Map? getLocation = await LocationService().initializeAndGetLocation(context);
   if(getLocation!=null){
     if(attendanceModel?.checkIn==null){
       await _supabase.from(Constants.attendanceTable).insert({
         'employeeId': _supabase.auth.currentUser!.id,
         'date': todayDate,
         'checkIn': DateFormat('HH:mm').format(DateTime.now()).toString(),
         'checkIn_location': getLocation
       });
     }else if(attendanceModel?.checkOut ==  null){
       await _supabase.from(Constants.attendanceTable).update({
         'checkOut':DateFormat("HH: mm").format(DateTime.now()),
         'checkout_location': getLocation
       }).eq('employeeId', _supabase.auth.currentUser!.id)
           .eq('date', todayDate);
       getTodayAttendance();
     }else{
       Utils.showSnackBar("You have already checked Out today", context);
       getTodayAttendance();
     }
   }
 }

 Future<List<AttendanceModel>> getAttendenceHistory() async{
   final List data = await _supabase
       .from(Constants.attendanceTable)
       .select().eq("employeeId", _supabase.auth.currentUser!.id)
       .textSearch('date', "'$attendanceHistoryMonth'", config: 'english')
       .order("created_at", ascending: false);
    return data.map((attendanceModelJson) => AttendanceModel.fromJson(attendanceModelJson)).toList();
 }


}