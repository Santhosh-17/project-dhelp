import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_help/modal/otherRequestModel.dart';
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

  setRequestStatus(uid) async{
    await FirebaseFirestore.instance
        .collection("otherRequest")
        .doc(uid)
        .update({'isRequestAccpeted': 'Request Accepted!'});
  }

  Widget buildList(OtherRequestModel otherRequestModel) => ListTile(
    title: Text('${otherRequestModel.need!}'),
    subtitle: Text(otherRequestModel.location!),
    onTap: (){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Other Emergency Request"),
            content: Text("Person Name: ${otherRequestModel.userName}\nContact No. ${otherRequestModel.phoneNo}\nTheir Need: ${otherRequestModel.need}\nLocation: ${otherRequestModel.location}"),
            actions: [
              otherRequestModel.isRequestAccpeted == "Not accepted currently!" ? TextButton(                     // FlatButton widget is used to make a text to work like a button
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
              otherRequestModel.isRequestAccpeted == "Not accepted currently!" ? TextButton(
                onPressed: () {
                  setRequestStatus(otherRequestModel.uid);
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
                child: Text(otherRequestModel.isRequestAccpeted!),
              ),
            ],
          );
        },
      );
    },
  );
}
