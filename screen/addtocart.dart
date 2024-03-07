import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/classdata.dart';
class h4 extends StatefulWidget {
  final int id;
  const h4({super.key,required this.id});

  @override
  State<h4> createState() => _h4State();
}

class _h4State extends State<h4> {

  List<datamodel> list1 =[];
  List<datamodel> list2 =[];
  Future<List<datamodel>> getinformation()async {
    List<datamodel> categorylist =[];
    final data = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    final response = jsonDecode(data.body)as List;
    categorylist = response.map((e) => datamodel.fromJson((e))).toList();
    return categorylist;
  }
  
  void data() async {
    list1.addAll(await getinformation());
    list2.addAll(list1.where((element) => element.id== widget.id));
    if(list2.isNotEmpty){
      setState(() {
      });
    }
  }
@override
  void initState() {
    data();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,
        leading: BackButton(color: Colors.green,),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
          itemCount: list2.length,
          itemBuilder: (context , index){
            return Column(
              children: [
                ListTile(
                  leading: Image.network(list2[index].image.toString()),
                  title: Text("${list2[index].title}"),
                  trailing: Text("\$ ${list2[index].price}",style: TextStyle(fontSize: 15
                  ),),
                ),
                ElevatedButton(onPressed: (){
                  setState(() {
                    list2.clear();
                  });
                },child: Text("Clear",style: TextStyle(color: Colors.green),),),

              ],
            );
          }),
    );
  }
}
