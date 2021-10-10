import 'package:flutter/material.dart';
import 'package:slot_booking/slot_model.dart';

class SlotListScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final slots;
  // ignore: use_key_in_widget_constructors
  const SlotListScreen({this.slots});

  @override
  _SlotListScreenState createState() => _SlotListScreenState();
}

class _SlotListScreenState extends State<SlotListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SafeArea(
            child: ListView.separated(
          padding: const EdgeInsets.all(6),
          itemCount: widget.slots.length,
          itemBuilder: (BuildContext context, int index) {
            bool is_available =
                widget.slots[index].availableSeat > 0 ? true : false;
            return Card(
              color: is_available ? Colors.white : Colors.white54,
              elevation: 6,
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Start Time: ",
                                style: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("${widget.slots[index].startTime}"),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Text("End Time: ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold)),
                              Text("${widget.slots[index].endTime}"),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              const Text("Available Seats: ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold)),
                              Text(" ${widget.slots[index].availableSeat}")
                            ],
                          )
                        ],
                      ),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:is_available?
                              MaterialStateProperty.all<Color>(Colors.green):MaterialStateProperty.all<Color>(Colors.grey),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        onPressed: () async {
                          if (is_available) {
                            var msg = await bookSlot(widget.slots[index].id);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(msg),
                              duration: const Duration(milliseconds: 400),
                            ));
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Book Slot'),
                      ),
                    ],
                  )),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(
            height: 20,
            indent: 2,
          ),
        )),
      ),
    );
  }
}
