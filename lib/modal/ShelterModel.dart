class ShelterModel {
  String? uid;
  String? userName;
  String? email;
  String? phoneNo;
  String? aadharNo;
  String? location;
  String? transport;
  String? quantity;
  String? isRequestAccpeted;

  ShelterModel(
      {this.uid,
        this.email,
        this.userName,
        this.aadharNo,
        this.phoneNo,
        this.location,
        this.transport,
        this.isRequestAccpeted,
        this.quantity,});

// receiving data from server
  factory ShelterModel.fromMap(map) {
    return ShelterModel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      aadharNo: map['aadharNo'],
      phoneNo: map['phoneNo'],
      location: map['location'],
      quantity: map['quantity'],
      isRequestAccpeted: map['isRequestAccpeted'],
      transport: map['transport'],);
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
      'quantity': quantity,
      'transport': transport,
      'isRequestAccpeted': isRequestAccpeted
    };
  }
}
