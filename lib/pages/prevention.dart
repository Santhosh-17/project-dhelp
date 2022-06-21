import 'package:d_help/constant.dart';
import 'package:d_help/widgets/my_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Prevention extends StatefulWidget {
  static const String id = 'Prevention';

  const Prevention({Key? key}) : super(key: key);

  @override
  State<Prevention> createState() => _PreventionState();
}

class _PreventionState extends State<Prevention> {
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
        title: const Text("PREVENTION"),
        backgroundColor: const Color(0xFF11249F),
      ),
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyHeader(image: "assets/icons/Drcorona.svg",textTop: "Wash Your Hands", textBottom: "                         Keep Distancing", topOffset: offset,leftOffset: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("WASHING",style: kTitleTextstyle,),
                  const SizedBox(height: 20,),
                  Text("Wash Your hands with soap and running water when hands are visibly dirty",style: kSubBodyTextStyle,),
                  const SizedBox(height: 20,),
                  Text("* Wash Your hands after coughing or sneezing\n\n* when caring for the sick\n\n* before eating\n\n* after handling animals",style: kSubBodyTextStyle,),
                  const SizedBox(height: 25,),
                  Text("PROTECTION",style: kTitleTextstyle,),
                  const SizedBox(height: 20,),
                  Text("* Avoid Close Contact\n\n* Avoid Spitting in public \n\n* Cover Nose while Sneezing",style: kSubBodyTextStyle,),
                  const SizedBox(height: 70,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
