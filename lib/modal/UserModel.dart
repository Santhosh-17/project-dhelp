class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? phoneNo;
  String? password;
  String? role;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.phoneNo,
      this.password,
      this.role});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        phoneNo: map['phoneNo'],
        password: map['password'],
        role: map['role']);
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'phoneNo': phoneNo,
      'password': password,
      'role': role
    };
  }
}
