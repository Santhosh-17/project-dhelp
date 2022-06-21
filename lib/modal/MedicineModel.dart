class Medicinemodel {
  String? uid;
  String? userName;
  String? email;
  String? phoneNo;
  String? aadharNo;
  String? location;
  String? sickness;
  String? medicineName;
  String? dosage;
  String? isRequestAccpeted;

  Medicinemodel(
      {this.uid,
        this.email,
        this.userName,
        this.aadharNo,
        this.phoneNo,
        this.location,
        this.sickness,
        this.medicineName,
        this.isRequestAccpeted,
        this.dosage,});

// receiving data from server
  factory Medicinemodel.fromMap(map) {
    return Medicinemodel(
      uid: map['uid'],
      email: map['email'],
      userName: map['userName'],
      aadharNo: map['aadharNo'],
      phoneNo: map['phoneNo'],
      location: map['location'],
      isRequestAccpeted: map['isRequestAccpeted'],
      medicineName: map['medicineName'],
      dosage: map['dosage'],
      sickness: map['sickness'],);
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
      'dosage': dosage,
      'isRequestAccpeted': isRequestAccpeted,
      'medicineName' : medicineName,
      'sickness': sickness
    };
  }
}
