import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../model/classdata.dart';

class APICONTROL{
 static Future<List<datamodel>> getdata(BuildContext context) async {
    try{
      final data = await http.get(Uri.parse("https://fakestoreapi.com/products"));
      final response = jsonDecode(data.body) as List;
      //print(response);
      return response.map((e) => datamodel.fromJson((e))).toList();
    } catch(e){
      // print("error:$e");
      return [];
    }
  }


 static Future<List<String>> getDatacategory(BuildContext context) async {
   try {
     List<String> categorylist = [];
     final response = await http.get(Uri.parse("https://fakestoreapi.com/products/categories"));
     final Data = jsonDecode(response.body);
     // print("$Data");
     return categorylist = List<String>.from(Data);
   } catch (e) {
     // print("Error: $e");
     rethrow;
   }
 }
 static Future<List<datamodel>> getDataname(BuildContext context , String categoryname) async {
   try {
     String url ="https://fakestoreapi.com/products/category/$categoryname";
     final response =await http.get(Uri.parse(url));
     final Data = jsonDecode(response.body) as List;
     //  print("$Data");
     return Data.map((e) => datamodel.fromJson((e))).toList();
   } catch (e) {
     // print("Error: $e");
     rethrow;
   }
 }
}