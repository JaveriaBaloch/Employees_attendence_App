class AttendanceModel{
  final String id;
  final String date;
  final String checkIn;
  final String? checkOut;
  final String createdAt;
  final Map? checkIn_location;
  final Map? checkOut_location;
  AttendanceModel({
    required this.id,
    required this.createdAt,
    required this.date,
    required this.checkIn,
    this.checkOut,
    required this.checkIn_location,
    required this.checkOut_location
  });

  factory AttendanceModel.fromJson(Map<String,dynamic> data){
    return AttendanceModel(
        id: data['employeeId'],
        date: data['date'],
        checkOut: data['checkOut'],
        createdAt: "${DateTime.parse(data['created_at'])}",
        checkIn: data['checkIn'],
        checkIn_location: data['checkIn_location'],
        checkOut_location: data['checkout_location'],
    );
  }
}