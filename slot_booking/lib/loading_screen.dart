import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:slot_booking/slot_list_screen.dart';
import 'package:slot_booking/slot_model.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getSlotData() async {

    var slots= await getSlots();
    Navigator.push(context,MaterialPageRoute(builder: (context){

      return SlotListScreen(slots: slots);
    })).then((value) {
      setState(() {

      });
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    getSlotData();
    return Scaffold(
      body: Center(
          child: SpinKitDoubleBounce(
            color: Colors.white,
            size:100.0,
          )
      ),
    );
  }
}
