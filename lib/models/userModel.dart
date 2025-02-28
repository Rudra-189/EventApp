class userDataModel{
  final String id;
  final String name;
  final String email;
  final String role;
  final String photo;

  userDataModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.photo
  });

  factory userDataModel.fromMap(Map<String, dynamic> json,String documentId){
    return userDataModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      photo: json['photo'] ?? ''
    );
  }
}