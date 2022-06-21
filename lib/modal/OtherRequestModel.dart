class OtherRequestModel {
  String? uid;
  String? userName;
  String? email;
  String? phoneNo;
  String? aadharNo;
  String? location;
  String? need;
  String? isRequestAccpeted;

  OtherRequestModel(
      {this.uid,
        this.email,
        this.userName,
        this.aadharNo,
        this.phoneNo,
        this.location,
        this.isRequestAccpeted,
        this.need,});

// receiving data from server
  factory OtherRequestModel.fromMap(map) {
    return OtherRequestModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      aadharNo: map['aadharNo'],
      phoneNo: map['phoneNo'],
      location: map['location'],
      isRequestAccpeted: map['isRequestAccpeted'],
      need: map['need'],);
  }

// sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'userName': userName,
      'aadharNo': aadharNo,
      'phoneNo': phoneNo,
      'location': location,
      'need': need,
      'isRequestAccpeted': isRequestAccpeted
    };
  }
}
