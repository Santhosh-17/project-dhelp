import 'package:d_help/constant.dart';
import 'package:d_help/widgets/my_header.dart';
import 'package:flutter/material.dart';
class SafetyDetails extends StatefulWidget {
  const SafetyDetails({Key? key}) : super(key: key);

  @override
  _SafetyDetailsState createState() => _SafetyDetailsState();
}

class _SafetyDetailsState extends State<SafetyDetails> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: const Text("SAFETY DETAILS"),
        backgroundColor: const Color(0xFF11249F),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            MyHeader(image: "assets/icons/Drcorona.svg",textTop: "", textBottom: "", topOffset: offset,leftOffset: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("\tAvoid Travelling below Red Zone Areas as much as possible",style: kSubBodyTextStyle,),
                  const SizedBox(height: 20,),
                  Text("RED ZONE DISTRICTS",style: kTitleTextstyle,),
                  const SizedBox(height: 20,),
                  Text("1.Chennai\n\n2.Coimbatore\n\n3.Madurai\n\n4.Thiruvallur\n\n5.Kanchipuram\n\n6.Salem",style: kSubBodyTextStyle,),
                  const SizedBox(height: 30,),
                  Text("ORANGE ZONE DISTRICTS",style: kTitleTextstyle,),
                  const SizedBox(height: 20,),
                  Text("1.Thanjavur\n\n2.Trichy\n\n3.Dindugal\n\n4.Thiruvarur\n\n5.Karaikudi\n\n6.Cuddaloor\n\n7.Dharmapuri\n\n8.Pudukkottai\n\n9.Viruthunagar",style: kSubBodyTextStyle,),
                  const SizedBox(height: 30,),
                  Text("GREEN ZONE DISTRICTS",style: kTitleTextstyle,),
                  const SizedBox(height: 20,),
                  Text("1.Thirunelvelli\n\n2.Thuthukudi\n\n3.Sivagangai\n\n4.KanyaKumari\n\n5.Namakkal",style: kSubBodyTextStyle,),
                  const SizedBox(height: 20,),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
