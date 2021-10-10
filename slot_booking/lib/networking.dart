import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NetworkHelper{

  final String url;
  NetworkHelper(this.url);

  Future getData() async{

    http.Response response= await http.get(url);
    if(response.statusCode==200){
      String data = response.body;

      var decodedData = jsonDecode(data);

      return decodedData;

    }
    else{
      // ignore: avoid_print
      print(response.statusCode);
    }

  }

  Future postData() async{

    http.Response response= await http.post(url);
    if(response.statusCode==201){
      return "Slot booked successfully!";

    }
    else{
      return "Something went wrong. Please try Again!";
    }

  }


}