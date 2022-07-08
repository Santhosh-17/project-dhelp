import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_help/modal/MedicineModel.dart';
import 'package:flutter/material.dart';

class MedicineList extends StatefulWidget {
  const MedicineList({Key? key}) : super(key: key);

  @override
  _MedicineListState createState() => _MedicineListState();
}

class _MedicineListState extends State<MedicineList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Medicine Requests",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
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

      body: StreamBuilder<List<Medicinemodel>>(
        stream: readMedicineRequest(),
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

  Stream<List<Medicinemodel>> readMedicineRequest() {
    return FirebaseFirestore.instance.collection('medicineRequest').snapshots().map(
            (snapshots) => snapshots.docs
            .map((doc) => Medicinemodel.fromMap(doc.data()))
            .toList());
  }

  setRequestStatus(uid) async{
    await FirebaseFirestore.instance
        .collection("medicineRequest")
        .doc(uid)
        .update({'isRequestAccpeted': 'Request Accepted!'});
  }

  Widget buildList(Medicinemodel medicineModel) => ListTile(
    title: Text('${medicineModel.medicineName!} - ${medicineModel.sickness}'),
    subtitle: Text(medicineModel.location!),
    onTap: (){
      showDialog(
        context: context,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Medicine Request"),
            content: Text("Person Name: ${medicineModel.userName}\nContact No. ${medicineModel.phoneNo}\nMedicine Name: ${medicineModel.medicineName}\nDosage: ${medicineModel.dosage}\nSickness : ${medicineModel.sickness}\nLocation: ${medicineModel.location}"),
            actions: [
              medicineModel.isRequestAccpeted == "Not accepted currently!" ? TextButton(                     // FlatButton widget is used to make a text to work like a button
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
              medicineModel.isRequestAccpeted == "Not accepted currently!" ? TextButton(
                onPressed: () {
                  setRequestStatus(medicineModel.uid);
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
                child: Text(medicineModel.isRequestAccpeted!),
              ),
            ],
          );
        },
      );
    },
  );
}
