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


  Widget buildList(ShelterModel shelterModel) => ListTile(
    title: Text('Current Location: ${shelterModel.location!}'),
    subtitle: Text('No. of People: ${shelterModel.quantity!}'),
  );

}
