
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:d_help/Utils.dart';
import 'package:d_help/constant.dart';
import 'package:d_help/modal/UserModel.dart';
import 'package:d_help/pages/helpline.dart';
import 'package:d_help/pages/login_page.dart';
import 'package:d_help/pages/prevention.dart';
import 'package:d_help/pages/profile_page.dart';
import 'package:d_help/pages/safetyDetails.dart';
import 'package:d_help/pages/volunteerPages/volunteer_profile.dart';
import 'package:d_help/routes.dart';
import 'package:d_help/widgets/counter.dart';
import 'package:d_help/widgets/my_header.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hexcolor/hexcolor.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Color _primaryColor = HexColor('#DC54FE');
  Color _accentColor = HexColor('#8A02AE');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: _primaryColor,
          accentColor: _accentColor,
          // scaffoldBackgroundColor: Colors.grey.shade100,
          //primarySwatch: Colors.grey,
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: "Poppins",
          textTheme: const TextTheme(
            bodyText1: const TextStyle(color: kBodyTextColor),
          )),
       home: HomeScreen(),
      // initialRoute: HomeScreen.id,
      // routes: PageRoutes().routes(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  static const String id = "HomeScreen";
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = ScrollController();
  double offset = 0;
  String? role = "Consumer";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
    _callFetch();
    getCurrentLocation();
  }

  _callFetch() async{
    await _fetch();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: new Text('Yes'),
          ),
        ],
      ),
    )) ?? false;
  }

  getCurrentLocation() async{
    await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    getAddressFromCoordinates(
        Coordinates(position.latitude,position.longitude)
    );
  }

  getAddressFromCoordinates(Coordinates cords) async {
    var addresses = await Geocoder.local.findAddressesFromCoordinates(cords);
    var first = addresses.first;
    Utils.userLocation = "${first.featureName} : ${first.addressLine}";
    print( Utils.userLocation);
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
      role = user.role;
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("D-Help"),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 5.0),
              child: IconButton(
                icon: Image.asset(
                  "assets/icons/loginIcon.png",
                ),
                onPressed: () async {

                  if (await FirebaseAuth.instance.currentUser != null) {
                  // signed in
                    if(role == "Consumer"){
                      print(role);
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => ProfilePage()), (route) => false);
                    }else{
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => VolunteerProfile()), (route) => false);
                    }

                  } else {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => LoginPage()), (route) => false);
                  }

                },
              ),
            )
          ],
          backgroundColor: const Color(0xFF11249F),
        ),
        body: SingleChildScrollView(
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyHeader(
                image: "assets/icons/Drcorona.svg",
                textTop: "All you need",
                textBottom: "is stay at home.",
                leftOffset: 150,
                topOffset: offset
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Corona Virus", style: kTitleTextstyle1,),const SizedBox(height: 10),
                    Text("Case Update", style: kTitleTextstyle,),const SizedBox(height: 5),
                    Text("Location: TamilNadu\nNewest update April 24",style: TextStyle(color: kTextLightColor,),),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 4),
                            blurRadius: 30,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const <Widget>[
                          Counter(
                            color: kInfectedColor,
                            number: 1046,
                            title: "Infected",
                          ),
                          Counter(
                            color: kDeathColor,
                            number: 87,
                            title: "Deaths",
                          ),
                          Counter(
                            color: kRecovercolor,
                            number: 46,
                            title: "Recovered",
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                  ],
                ),
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child: const Text("Things You Need to Know",style: kTitleTextstyle,),
              ),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    const SizedBox(width: 5.0,),
                    Cards(name: "PREVENTION",onPress: (){
                      print("PREVENTION");
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Prevention()));
                     // Navigator.pushNamed(context, Prevention.id);
                    },
                    ),
                    const SizedBox(width: 5.0,),
                    Cards(name: "SAFETY DETAILS",onPress: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SafetyDetails()));
                      print("SAFETY DETAILS");
                    },
                    ),
                    const SizedBox(width: 5.0,),
                    Cards(name: "HELPLINE",onPress: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => HelpLine()));
                      print("HELPLINE");
                    },
                    ),
                    const SizedBox(width: 10.0,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Cards extends StatelessWidget {

  var onPress, name;

  Cards({
    required this.onPress,
    required this.name
  });


  @override
  Widget build(BuildContext context) {

    return TextButton(
        onPressed: onPress,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
              height: 120,
              width: 150,
              color: Colors.blueAccent,
              child: Center(
                child: Text(name,
                style: const TextStyle(
                  color: Colors.white
                ),
                ),
              ),
          ),
        ),);
  }
}
