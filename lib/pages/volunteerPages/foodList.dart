import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_help/modal/FoodModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FoodList extends StatefulWidget {
  const FoodList({Key? key}) : super(key: key);

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Requests",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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

      body: StreamBuilder<List<Foodmodel>>(
        stream: readFoodRequest(),
        builder: (context,snapshot) {
          if(snapshot.hasData){
            final data = snapshot.data!;
            return ListView(
              children: data.map(buildList).toList(),
            );
          }else{
            return  Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ));
          }
        },
      ),
    );
  }

  Stream<List<Foodmodel>> readFoodRequest() {
    return FirebaseFirestore.instance.collection('foodRequest').snapshots().map(
            (snapshots) => snapshots.docs
            .map((doc) => Foodmodel.fromMap(doc.data()))
            .toList());
  }

  setRequestStatus(uid) async{
    await FirebaseFirestore.instance
        .collection("foodRequest")
        .doc(uid)
        .update({'isRequestAccpeted': 'Request Accepted!'});
  }

  Widget buildList(Foodmodel foodmodel) => ListTile(
    title: Text(foodmodel.typeOfFood!),
    subtitle: Text(foodmodel.location!),
    onTap: (){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Food Request"),
            content: Text("Person Name: ${foodmodel.userName}\nContact No. ${foodmodel.phoneNo}\nType of Food Need: ${foodmodel.typeOfFood}\nNo.of people: ${foodmodel.quantity}\nLocation: ${foodmodel.location}"),
            actions: [
              foodmodel.isRequestAccpeted == "Not accepted currently!" ? TextButton(                     // FlatButton widget is used to make a text to work like a button
                onPressed: () {
                  Navigator.of(context).pop();
                },             // function used to perform after pressing the button
                child: Text('CANCEL',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ) : Text(''),
              foodmodel.isRequestAccpeted == "Not accepted currently!" ? TextButton(
                onPressed: () {
                  setRequestStatus(foodmodel.uid);
                  ScaffoldMessenger.of(context).showSnackBar(
                      new SnackBar(content: new Text("Successfully Accepted! :) ")));
                  Navigator.of(context).pop();
                },             // function used to perform after pressing the button
                child: Text('ACCEPT REQUEST',
                  style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ) : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(foodmodel.isRequestAccpeted!),
              ),
            ],
          );
        },
      );
    },
  );
}
