import 'package:slot_booking/networking.dart';


// ignore: constant_identifier_names
const slot_url='http://127.0.0.1:8000/v1/slots/';

const slot_book_url='http://127.0.0.1:8000/v1/slots/:id:/book/';

class Slot {
  final int id;
  final String startTime;
  final String endTime;
  final int availableSeat;

  Slot(this.id, this.startTime, this.endTime, this.availableSeat);

  Slot.fromJson(Map<String, dynamic> json):
        id = json['id'],
        startTime = json['start_time'],
        endTime = json['end_time'],
        availableSeat = json['available_seat'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['available_seat'] =availableSeat;
    return data;
  }
}


Future<dynamic> getSlots() async {
  NetworkHelper networkHelper = NetworkHelper(slot_url);

  var data = await networkHelper.getData();
  final List<Slot> slots = [];
  data.forEach((element) {
    slots.add(Slot.fromJson(element));
  });
  print(slots);
  return slots;
}


Future<dynamic> bookSlot(int slotId) async {
  NetworkHelper networkHelper = NetworkHelper(slot_book_url.replaceAll(":id:", "${slotId}"));

  var data = await networkHelper.postData();
  return data;
}



