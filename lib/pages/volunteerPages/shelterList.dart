import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_help/modal/ShelterModel.dart';
import 'package:flutter/material.dart';

class ShelterList extends StatefulWidget {
  const ShelterList({Key? key}) : super(key: key);

  @override
  _ShelterListState createState() => _ShelterListState();
}

class _ShelterListState extends State<ShelterList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shelter Requests",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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

      body: StreamBuilder<List<ShelterModel>>(
        stream: readShelterRequest(),
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

  Stream<List<ShelterModel>> readShelterRequest() {
    return FirebaseFirestore.instance.collection('shelterRequest').snapshots().map(
            (snapshots) => snapshots.docs
            .map((doc) => ShelterModel.fromMap(doc.data()))
            .toList());
  }
  setRequestStatus(uid) async{
    await FirebaseFirestore.instance
        .collection("shelterRequest")
        .doc(uid)
        .update({'isRequestAccpeted': 'Request Accepted!'});
  }

  Widget buildList(ShelterModel shelterModel) => ListTile(
    title: Text('Current Location: ${shelterModel.location!}'),
    subtitle: Text('No. of People: ${shelterModel.quantity!}'),
    onTap: (){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Shelter Request"),
            content: Text("Person Name: ${shelterModel.userName}\nContact No. ${shelterModel.phoneNo}\nTransport request: ${shelterModel.transport}\nNo.of people: ${shelterModel.quantity}\nLocation: ${shelterModel.location}"),
            actions: [
              shelterModel.isRequestAccpeted == "Not accepted currently!" ? TextButton(                     // FlatButton widget is used to make a text to work like a button
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
              shelterModel.isRequestAccpeted == "Not accepted currently!" ? TextButton(
                onPressed: () {
                  setRequestStatus(shelterModel.uid);
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
                child: Text(shelterModel.isRequestAccpeted!),
              ),
            ],
          );
        },
      );
    },
  );

}
