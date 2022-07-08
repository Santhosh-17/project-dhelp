import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_help/Utils.dart';
import 'package:d_help/main.dart';
import 'package:d_help/modal/FoodModel.dart';
import 'package:d_help/modal/MedicineModel.dart';
import 'package:d_help/modal/OtherRequestModel.dart';
import 'package:d_help/modal/ShelterModel.dart';
import 'package:d_help/modal/UserModel.dart';
import 'package:d_help/pages/login_page.dart';
import 'package:d_help/pages/splash_screen.dart';
import 'package:d_help/pages/userForms/food_request.dart';
import 'package:d_help/pages/userForms/medicine_request.dart';
import 'package:d_help/pages/userForms/other_request.dart';
import 'package:d_help/pages/userForms/shelter_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:d_help/pages/widgets/header_widget.dart';

import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage> {
  double _drawerIconSize = 24;
  double _drawerFontSize = 17;
  FirebaseAuth _auth = FirebaseAuth.instance;
  final firebaseUser = FirebaseAuth.instance.currentUser!;

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (Route<dynamic> route) => false);
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile Page",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          elevation: 0.5,
          iconTheme: IconThemeData(color: Colors.white),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  Theme.of(context).primaryColor,
                  Theme.of(context).accentColor,
                ])),
          ),
        ),
        drawer: Drawer(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [
                  0.0,
                  1.0
                ],
                    colors: [
                  Theme.of(context).primaryColor.withOpacity(0.2),
                  Theme.of(context).accentColor.withOpacity(0.5),
                ])),
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.0, 1.0],
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).accentColor,
                      ],
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      "D-Help",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                ListTile(
                  //leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                  leading: IconButton(
                      icon: Image.asset(
                        "assets/icons/food.png",
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.all(15.0)),
                  title: Text(
                    'Request Food',
                    style: TextStyle(
                        fontSize: 17, color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FoodRequest()));
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  //leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                  leading: IconButton(
                      icon: Image.asset(
                        "assets/icons/medicine.png",
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.all(15.0)),
                  title: Text(
                    'Request Medicine',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MedicineRequest()),
                    );
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  //leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Theme.of(context).accentColor),
                  leading: IconButton(
                      icon: Image.asset(
                        "assets/icons/shelter.png",
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.all(15.0)),
                  title: Text(
                    'Request shelter',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShelterRequest()),
                    );
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  //leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                  leading: IconButton(
                      icon: Image.asset(
                        "assets/icons/other.png",
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.all(15.0)),
                  title: Text(
                    'Other Emergency requirements',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OtherRequest()),
                    );
                  },
                ),
                Divider(
                  color: Theme.of(context).primaryColor,
                  height: 1,
                ),
                ListTile(
                  //leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                  leading: IconButton(
                      icon: Image.asset(
                        "assets/icons/logout.png",
                      ),
                      onPressed: () {},
                      padding: EdgeInsets.all(15.0)),
                  title: Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: _drawerFontSize,
                        color: Theme.of(context).accentColor),
                  ),
                  onTap: () {
                    _auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        body: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(firebaseUser.uid)
                .get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                UserModel user = UserModel.fromMap(snapshot.data!.data());
                return SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        child: HeaderWidget(100, false, Icons.house_rounded),
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(width: 5, color: Colors.white),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20,
                                    offset: const Offset(5, 5),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.person,
                                size: 80,
                                color: Colors.grey.shade300,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "${user.firstName!} ${user.secondName!}",
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              user.role!,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, bottom: 8.0),
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      "User Information",
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Card(
                                    child: Container(
                                      alignment: Alignment.topLeft,
                                      // padding: EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[
                                              ...ListTile.divideTiles(
                                                color: Colors.grey,
                                                tiles: [
                                                  ListTile(
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5,
                                                            vertical: 4),
                                                    leading:
                                                        Icon(Icons.my_location),
                                                    title: Text("Location"),
                                                    subtitle:
                                                        Text(Utils.userLocation!),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.email),
                                                    title: Text("Email"),
                                                    subtitle: Text(user.email!),
                                                  ),
                                                  ListTile(
                                                    leading: Icon(Icons.phone),
                                                    title: Text("Phone"),
                                                    subtitle:
                                                        Text(user.phoneNo!),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Text(
                                    "My Requests",
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 50,
                                            shadowColor: Colors.black,
                                            color: Colors.white,
                                            child: InkWell(
                                              onTap: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return FutureBuilder<
                                                        DocumentSnapshot>(
                                                      future: FirebaseFirestore
                                                          .instance
                                                          .collection('foodRequest')
                                                          .doc(firebaseUser.uid)
                                                          .get(),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          Foodmodel foodmodel =
                                                          Foodmodel.fromMap(
                                                                  snapshot.data!
                                                                      .data());
                                                          return AlertDialog(
                                                            title: Text("Food Request"),
                                                            content: Text("Type of Food Need: ${foodmodel.typeOfFood}\nNo.of people: ${foodmodel.quantity}\nLocation: ${foodmodel.location}\nStatus: ${foodmodel.isRequestAccpeted}"),
                                                            actions: [
                                                              TextButton(                     // FlatButton widget is used to make a text to work like a button
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },             // function used to perform after pressing the button
                                                              child: Text('OK',
                                                                style: TextStyle(
                                                                    color: Colors.grey,
                                                                    fontWeight: FontWeight.bold
                                                                ),
                                                              ),
                                                            )
                                                            ],
                                                          );
                                                        } else {
                                                          return AlertDialog(
                                                            title: Text("No Request has been submitted!"),
                                                           // content: Text("Type of Food Need: ${foodmodel.typeOfFood}\nNo.of people: ${foodmodel.quantity}\nLocation: ${foodmodel.location}\nStatus: ${foodmodel.isRequestAccpeted}"),
                                                            actions: [
                                                              TextButton(                     // FlatButton widget is used to make a text to work like a button
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },             // function used to perform after pressing the button
                                                                child: Text('OK',
                                                                  style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: SizedBox(
                                                width: 120,
                                                height: 100,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: Image.asset(
                                                          "assets/icons/food.png",
                                                        ),
                                                      ), //CircleAvatar
                                                      SizedBox(
                                                        height: 10,
                                                      ), //SizedBox
                                                      Text(
                                                        'Food Request',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Card(
                                            elevation: 50,
                                            shadowColor: Colors.black,
                                            color: Colors.white,
                                            child: InkWell(
                                              onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return FutureBuilder<
                                                          DocumentSnapshot>(
                                                        future: FirebaseFirestore
                                                            .instance
                                                            .collection('medicineRequest')
                                                            .doc(firebaseUser.uid)
                                                            .get(),
                                                        builder: (context, snapshot) {
                                                          if (snapshot.hasData) {
                                                            Medicinemodel medicineModel =
                                                            Medicinemodel.fromMap(
                                                                snapshot.data!
                                                                    .data());
                                                            return AlertDialog(
                                                              title: Text("Medicine Request"),
                                                              content: Text("Medicine Name: ${medicineModel.medicineName}\nDosage: ${medicineModel.dosage}\nLocation: ${medicineModel.location}\nStatus: ${medicineModel.isRequestAccpeted}"),
                                                              actions: [
                                                                TextButton(                     // FlatButton widget is used to make a text to work like a button
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },             // function used to perform after pressing the button
                                                                  child: Text('OK',
                                                                    style: TextStyle(
                                                                        color: Colors.grey,
                                                                        fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          } else {
                                                            return AlertDialog(
                                                              title: Text("No Request has been submitted!"),
                                                              // content: Text("Type of Food Need: ${foodmodel.typeOfFood}\nNo.of people: ${foodmodel.quantity}\nLocation: ${foodmodel.location}\nStatus: ${foodmodel.isRequestAccpeted}"),
                                                              actions: [
                                                                TextButton(                     // FlatButton widget is used to make a text to work like a button
                                                                  onPressed: () {
                                                                    Navigator.of(context).pop();
                                                                  },             // function used to perform after pressing the button
                                                                  child: Text('OK',
                                                                    style: TextStyle(
                                                                        color: Colors.grey,
                                                                        fontWeight: FontWeight.bold
                                                                    ),
                                                                  ),
                                                                )
                                                              ],
                                                            );
                                                          }
                                                        },
                                                      );
                                                    },
                                                  );
                                              },
                                              child: SizedBox(
                                                width: 120,
                                                height: 100,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: Image.asset(
                                                          "assets/icons/medicine.png",
                                                        ),
                                                      ), //CircleAvatar
                                                      SizedBox(
                                                        height: 10,
                                                      ), //SizedBox
                                                      Text(
                                                        'Medicine Request',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 5.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Card(
                                            elevation: 50,
                                            shadowColor: Colors.black,
                                            color: Colors.white,
                                            child: InkWell(
                                              onTap: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           ShelterList()),
                                                // );
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return FutureBuilder<
                                                        DocumentSnapshot>(
                                                      future: FirebaseFirestore
                                                          .instance
                                                          .collection('shelterRequest')
                                                          .doc(firebaseUser.uid)
                                                          .get(),
                                                      builder: (context, snapshot) {
                                                        if (snapshot.hasData) {
                                                          ShelterModel shelterModel =
                                                          ShelterModel.fromMap(
                                                              snapshot.data!
                                                                  .data());
                                                          return AlertDialog(
                                                            title: Text("Shelter Request"),
                                                            content: Text("Location: ${shelterModel.location}\nNo.of. People: ${shelterModel.quantity}\nTransportation: ${shelterModel.transport}\nStatus: ${shelterModel.isRequestAccpeted}"),
                                                            actions: [
                                                              TextButton(                     // FlatButton widget is used to make a text to work like a button
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },             // function used to perform after pressing the button
                                                                child: Text('OK',
                                                                  style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        } else {
                                                          return AlertDialog(
                                                            title: Text("No Request has been submitted!"),
                                                            // content: Text("Type of Food Need: ${foodmodel.typeOfFood}\nNo.of people: ${foodmodel.quantity}\nLocation: ${foodmodel.location}\nStatus: ${foodmodel.isRequestAccpeted}"),
                                                            actions: [
                                                              TextButton(                     // FlatButton widget is used to make a text to work like a button
                                                                onPressed: () {
                                                                  Navigator.of(context).pop();
                                                                },             // function used to perform after pressing the button
                                                                child: Text('OK',
                                                                  style: TextStyle(
                                                                      color: Colors.grey,
                                                                      fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                              )
                                                            ],
                                                          );
                                                        }
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                              child: SizedBox(
                                                width: 120,
                                                height: 100,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: Image.asset(
                                                          "assets/icons/shelter.png",
                                                        ),
                                                      ), //CircleAvatar
                                                      SizedBox(
                                                        height: 10,
                                                      ), //SizedBox
                                                      Text(
                                                        'Shelter Request',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Card(
                                            elevation: 50,
                                            shadowColor: Colors.black,
                                            color: Colors.white,
                                            child: SizedBox(
                                              width: 120,
                                              height: 100,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(10.0),
                                                child: Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        // Navigator.push(
                                                        //   context,
                                                        //   MaterialPageRoute(
                                                        //       builder: (context) =>
                                                        //           OtherList()),
                                                        // );
                                                        showDialog(
                                                          context: context,
                                                          builder:
                                                              (BuildContext context) {
                                                            return FutureBuilder<DocumentSnapshot>(
                                                              future: FirebaseFirestore
                                                                  .instance
                                                                  .collection('otherRequest')
                                                                  .doc(firebaseUser.uid)
                                                                  .get(),
                                                              builder: (context, snapshot) {
                                                                if (snapshot.hasData) {
                                                                  OtherRequestModel otherRequest =
                                                                  OtherRequestModel.fromMap(
                                                                      snapshot.data!
                                                                          .data());
                                                                  return AlertDialog(
                                                                    title: Text("Other Emergency Request"),
                                                                    content: Text("\nMy Need: ${otherRequest.need}\nLocation: ${otherRequest.location}\nStatus: ${otherRequest.isRequestAccpeted}"),
                                                                    actions: [
                                                                      TextButton(                     // FlatButton widget is used to make a text to work like a button
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        },             // function used to perform after pressing the button
                                                                        child: Text('OK',
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.bold
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  );
                                                                } else {
                                                                  return AlertDialog(
                                                                    title: Text("No Request has been submitted!"),
                                                                    // content: Text("Type of Food Need: ${foodmodel.typeOfFood}\nNo.of people: ${foodmodel.quantity}\nLocation: ${foodmodel.location}\nStatus: ${foodmodel.isRequestAccpeted}"),
                                                                    actions: [
                                                                      TextButton(                     // FlatButton widget is used to make a text to work like a button
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop();
                                                                        },             // function used to perform after pressing the button
                                                                        child: Text('OK',
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontWeight: FontWeight.bold
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  );
                                                                }
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        width: 50,
                                                        height: 50,
                                                        child: Image.asset(
                                                          "assets/icons/other.png",
                                                        ),
                                                      ),
                                                    ), //CircleAvatar
                                                    SizedBox(
                                                      height: 10,
                                                    ), //SizedBox
                                                    Text(
                                                      'Other Request',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              } else {
                return Center(
                    child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ));
              }
            }),
      ),
    );
  }

  //   Future _fetch() async {
  //   final firebaseUser = await FirebaseAuth.instance.currentUser!;
  //   // if (firebaseUser != null)
  //      await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(firebaseUser.uid)
  //         .get()
  //         .then((ds) {
  //       UserModel user = UserModel.fromMap(ds.data());
  //       // myEmail = ds.data['email'];
  //       // print(myEmail);
  //       print(user.firstName);
  //       print(user.secondName);
  //       return user;
  //     }).catchError((e) {
  //       print(e);
  //     });
  // }

  // Stream<UserModel> readUser(){
  //   return FirebaseFirestore.instance.collection('users')
  //       .snapshots()
  //       .map((snapshots) => UserModel.fromMap(doc.data()));
  // }

}
