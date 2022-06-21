import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_help/modal/FoodModel.dart';
import 'package:d_help/modal/OtherRequestModel.dart';
import 'package:flutter/material.dart';

class OtherList extends StatefulWidget {
  const OtherList({Key? key}) : super(key: key);

  @override
  _OtherListState createState() => _OtherListState();
}

class _OtherListState extends State<OtherList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Other Emergency Requests",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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

      body: StreamBuilder<List<OtherRequestModel>>(
        stream: readOtherRequest(),
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

  Stream<List<OtherRequestModel>> readOtherRequest() {
    return FirebaseFirestore.instance.collection('otherRequest').snapshots().map(
            (snapshots) => snapshots.docs
            .map((doc) => OtherRequestModel.fromMap(doc.data()))
            .toList());
  }


  Widget buildList(OtherRequestModel otherRequestModel) => ListTile(
    title: Text('${otherRequestModel.need!}'),
    subtitle: Text(otherRequestModel.location!),
    onTap: (){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Alert Dialog"),
            content: Text("Dialog Content"),
            actions: [
              FlatButton(                     // FlatButton widget is used to make a text to work like a button
                textColor: Colors.black,
                onPressed: () {},             // function used to perform after pressing the button
                child: Text('CANCEL'),
              ),
              FlatButton(
                textColor: Colors.black,
                onPressed: () {

                },
                child: Text('ACCEPT REQUEST'),
              ),
            ],
          );
        },
      );
    },
  );
}
