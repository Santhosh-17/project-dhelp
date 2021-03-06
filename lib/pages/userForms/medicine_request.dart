import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_help/Utils.dart';
import 'package:d_help/common/theme_helper.dart';
import 'package:d_help/modal/MedicineModel.dart';
import 'package:d_help/pages/profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../modal/UserModel.dart';
import '../widgets/header_widget.dart';
class MedicineRequest extends StatefulWidget {
  const MedicineRequest({Key? key}) : super(key: key);

  @override
  _MedicineRequestState createState() => _MedicineRequestState();
}

class _MedicineRequestState extends State<MedicineRequest> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  final _formKey = GlobalKey<FormState>();

  final locationEditingController = new TextEditingController(text: Utils.userLocation);
  final sicknessTypeEditingController = new TextEditingController();
  final dosageEditingController = new TextEditingController();
  final medicineNameEditingController = new TextEditingController();
  final aadharNumberEditingController = new TextEditingController();

  String? Name = "";
  String? phone ="";

  @override
  void initState()  {
    super.initState();
    _callFetch();
  }

  _callFetch() async{
    await _fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                height: 150,
                child: HeaderWidget(150, false, Icons.person_add_alt_1_rounded),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(25, 125, 25, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 25,
                          ),
                          Text("Request Medicine",
                            style: TextStyle(fontSize: 25,color: Colors.black, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: TextFormField(
                              controller: locationEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Location', 'Enter your current Location'),
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This field should be filled!";
                                }
                                return null;
                              },
                            ),
                            decoration:
                            ThemeHelper().inputBoxDecorationShaddow(),

                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: TextFormField(
                              controller: sicknessTypeEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Sickness/Disease', 'Type of sickness you have?'),
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This field should be filled!";
                                }
                                return null;
                              },
                            ),
                            decoration:
                            ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: medicineNameEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Medicine Name", "Enter name of the medicine"),
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This field should be filled!";
                                }
                                return null;
                              },
                            ),
                            decoration:
                            ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: dosageEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Dosage", "Enter dosage"),
                              keyboardType: TextInputType.text,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This field should be filled!";
                                }
                                return null;
                              },
                            ),
                            decoration:
                            ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 20.0),
                          Container(
                            child: TextFormField(
                              controller: aadharNumberEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Aadhar Number", "Enter your Aadhar number"),
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "Enter a valid phone number";
                                }
                                return null;
                              },
                            ),
                            decoration:
                            ThemeHelper().inputBoxDecorationShaddow(),
                          ),
                          SizedBox(height: 40.0),

                          Container(
                            decoration:
                            ThemeHelper().buttonBoxDecoration(context),
                            child: ElevatedButton(
                              style: ThemeHelper().buttonStyle(),
                              child: Padding(
                                padding:
                                const EdgeInsets.fromLTRB(40, 10, 40, 10),
                                child: Text(
                                  "Submit".toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // registerUser(context,emailEditingController.text,passwordEditingController.text);
                                  postMedicineDetailsToFirestore(context);
                                }
                              },
                            ),
                          ),
                          SizedBox(height: 30.0),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  _fetch() async {
    final firebaseUser = await FirebaseAuth.instance.currentUser!;
    // if (firebaseUser != null)
    await FirebaseFirestore.instance
        .collection('users')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      UserModel user = UserModel.fromMap(ds.data());
      Name = "${user.firstName} ${user.secondName}";
      phone = user.phoneNo;

    }).catchError((e) {
      print(e);
    });
  }

  postMedicineDetailsToFirestore(BuildContext context) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    Medicinemodel medicineModel = Medicinemodel();

    // writing all the values
    medicineModel.email = user!.email;
    medicineModel.uid = user.uid;
    medicineModel.userName = Name;
    medicineModel.phoneNo = phone;
    medicineModel.aadharNo = aadharNumberEditingController.text;
    medicineModel.location = locationEditingController.text;
    medicineModel.sickness = sicknessTypeEditingController.text;
    medicineModel.dosage = dosageEditingController.text;
    medicineModel.medicineName = medicineNameEditingController.text;
    medicineModel.isRequestAccpeted = "Not accepted currently!";


    await firebaseFirestore
        .collection("medicineRequest")
        .doc(user.uid)
        .set(medicineModel.toMap());
    ScaffoldMessenger.of(context).showSnackBar(new SnackBar(content: new Text("Your request has been successfully submitted! :) ")));
    //Fluttertoast.showToast(msg: "Account created successfully :) ");

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => ProfilePage()
        ),
            (Route<dynamic> route) => false
    );

  }


}
