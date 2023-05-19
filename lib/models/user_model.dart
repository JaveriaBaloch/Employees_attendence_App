class UserModel{
  final String id;
  final String email;
  final String name;
  final int? department;
  final String employeeId;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.department,
    required this.employeeId,
});
  
  factory UserModel.fromJson(Map<String,dynamic> data){
    return UserModel(
        id: data['id'],
        email: data['email'],
        name: data['name'],
        department: data['department'],
        employeeId: data['employeeId']
    );
  }
}