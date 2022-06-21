class Foodmodel {
  String? uid;
  String? userName;
  String? email;
  String? phoneNo;
  String? aadharNo;
  String? location;
  String? typeOfFood;
  String? quantity;
  String? isRequestAccpeted;

  Foodmodel({
    this.uid,
    this.email,
    this.userName,
    this.aadharNo,
    this.phoneNo,
    this.location,
    this.typeOfFood,
    this.isRequestAccpeted,
    this.quantity,
  });

// receiving data from server
  factory Foodmodel.fromMap(map) {
    return Foodmodel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      aadharNo: map['aadharNo'],
      phoneNo: map['phoneNo'],
      location: map['location'],
      isRequestAccpeted: map['isRequestAccpeted'],
      quantity: map['quantity'],
      typeOfFood: map['typeOfFood'],
    );
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
      'isRequestAccpeted': isRequestAccpeted,
      'typeOfFood': typeOfFood
    };
  }
}
