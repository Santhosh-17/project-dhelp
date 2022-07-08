
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_help/Utils.dart';
import 'package:d_help/common/theme_helper.dart';
import 'package:d_help/modal/FoodModel.dart';
import 'package:d_help/modal/UserModel.dart';
import 'package:d_help/pages/profile_page.dart';
import 'package:d_help/pages/widgets/header_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';

class FoodRequest extends StatefulWidget {
  const FoodRequest({Key? key}) : super(key: key);

  @override
  _FoodRequestState createState() => _FoodRequestState();
}

class _FoodRequestState extends State<FoodRequest> {
  final _auth = FirebaseAuth.instance;

  // string for displaying the error Message
  String? errorMessage;

  final _formKey = GlobalKey<FormState>();


  final locationEditingController = new TextEditingController(text: Utils.userLocation);
  final foodTypeEditingController = new TextEditingController();
  final quantityEditingController = new TextEditingController();
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
    print( Utils.userLocation);
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
                          Text("Request Food",
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
                              controller: foodTypeEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  'Type of food', 'What type of food do you need?'),
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
                              controller: quantityEditingController,
                              decoration: ThemeHelper().textInputDecoration(
                                  "Quantity", "Enter no.of people you have"),
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
                                  postFoodDetailsToFirestore(context);
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

  postFoodDetailsToFirestore(BuildContext context) async {
    // calling our firestore
    // calling our user model
    // sedning these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;

    Foodmodel foodModel = Foodmodel();

    // writing all the values
    foodModel.email = user!.email;
    foodModel.uid = user.uid;
    foodModel.userName = Name;
    foodModel.phoneNo = phone;
    foodModel.aadharNo = aadharNumberEditingController.text;
    foodModel.location = locationEditingController.text;
    foodModel.typeOfFood = foodTypeEditingController.text;
    foodModel.quantity = quantityEditingController.text;
    foodModel.isRequestAccpeted = "Not accepted currently!";

    await firebaseFirestore
        .collection("foodRequest")
        .doc(user.uid)
        .set(foodModel.toMap());
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
