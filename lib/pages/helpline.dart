import 'package:d_help/constant.dart';
import 'package:d_help/widgets/my_header.dart';
import 'package:flutter/material.dart';
class HelpLine extends StatefulWidget {
  const HelpLine({Key? key}) : super(key: key);

  @override
  _HelpLineState createState() => _HelpLineState();
}

class _HelpLineState extends State<HelpLine> {
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
        title: const Text("HELPLINE"),
        backgroundColor: const Color(0xFF11249F),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: [
            MyHeader(image: "assets/icons/Drcorona.svg",textTop: "\nCORONA ( COVID 19 ) HELPLINE :", textBottom: "           011-23978046 OR 1075", topOffset: offset,leftOffset: 0,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text("EMERGENCY NUMBERS TAMIL NADU",style: kTitleTextstyle2,),
                   const SizedBox(height: 20,),
                  Text(" TAMIL NADU COVID 19 HELPLINE : 044-29510500 , 25615025 , 28593990",style: kTitleTextstyle,),
                  const SizedBox(height: 20,),
                  Text("FOR AUTHENTIC INFORMATION ON IT VISIT :\n\nNDRF Helpline Number : +91-9711077372\n\nNDMA : 1078 OR 011-26701728",
                    style: kTitleTextstyle,),
                  const SizedBox(height: 30,),
                  Text("POLICE:   100",style: kTitleTextstyle,),
                  const SizedBox(height: 20,),
                  Text("AMBULANCE:   108",style: kTitleTextstyle,),
                  const SizedBox(height: 30,)
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}
