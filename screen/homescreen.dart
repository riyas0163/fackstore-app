import 'package:fackstore/model/classdata.dart';
import 'package:fackstore/screen/grid data.dart';
import 'package:fackstore/service/Api%20service.dart';
import 'package:flutter/material.dart';

class h1 extends StatefulWidget {
  const h1({super.key});

  @override
  State<h1> createState() => _h1State();
}

class _h1State extends State<h1> {
  late Future<List<datamodel>> getinfo;
  late Future<List<String>> getdata;
  List<datamodel> listproducts = [];
  List<datamodel> listsearchproducts = [];
  bool _search = false;
  String searchkeyword ='';
  TextEditingController controller1 = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  @override
  void initState() {
    getinfo = APICONTROL.getdata(context);
    getdata = APICONTROL.getDatacategory(context);
    // TODO: implement initState
    super.initState();
  }

  void _show(BuildContext ctx, List<String> catlist) {
    showModalBottomSheet(
        elevation: 10,
        context: ctx,
        builder: (ctx) => Container(
            width: 380,
            height: 350,
            color: Colors.white,
            alignment: Alignment.center,
            child: ListView.builder(
                itemCount: catlist.length,
                itemBuilder: (context, index) {
                  final categoryname = catlist[index];
                  return ListTile(
                    onTap: () {
                      getinfo = APICONTROL.getDataname(context, categoryname);
                      setState(() {});
                      Navigator.pop(context);
                    },
                    leading: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.green,
                    ),
                    title: Text(catlist[index]),
                  );
                })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          // leading: Icon(
          //   Icons.menu,
          //   color: Colors.green,
          // ),
          title: Center(child: Text("Fackstore")),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: GestureDetector(
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),drawer:Drawer(backgroundColor: Colors.white,
      child: ListView(
        children: [
          SizedBox(height: 40,),
          Center(
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(color: Colors.blue,
                borderRadius: BorderRadius.circular(50)
              ),
            ),
          ),
          Center(
              child: Text("User")),
          Divider(),
          ListTile(

          ),
          ListTile(),
        ],
      ),
    ),
        backgroundColor: Colors.white,
        body: _search ? listsearchproduct() : listproduct());
  }

  Widget listproduct() {
    focusNode1.requestFocus();
    return FutureBuilder<List>(
        future: Future.wait([getinfo, getdata]),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data == null) {
            return Center(child: Text("get null value"));
          }
          if (snapshot.data!.isEmpty) {
            return Center(child: Text("error"));
          }
          listproducts = snapshot.data![0];
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextFormField(
                      focusNode: focusNode2,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search_sharp,
                          color: Colors.green,
                        ),
                        hintText: "Search for",
                      ),
                      onChanged: (key){
                        if(key.isEmpty){
                          _search = false;
                          setState(() {
                          });
                        }
                        if(key.isNotEmpty){
                          searchkeyword = key;
                          _search = true;
                          setState(() {
                          });
                        }
                        listsearchproducts = listproducts.where((element) => element.title!.toLowerCase().contains(key)).toList();
                       // setState(() {});
                      },
                    ),

                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: GestureDetector(
                        onTap: () => _show(context, snapshot.data![1]),
                        child: Icon(
                          Icons.filter_list,
                          color: Colors.green,
                        ),
                      )),
                ],
              ),
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: snapshot.data![0].length,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![0][index];
                      return h2(product: product);
                    }),
              ),
            ],
          );
        });
  }

  Widget listsearchproduct() {
   // controller1.text = searchkeyword;
    controller1.value = TextEditingValue(
      text: searchkeyword,selection: TextSelection.collapsed(offset: searchkeyword.length),
    );
    focusNode1.requestFocus();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextFormField(
                focusNode: focusNode1,
                controller: controller1,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search_sharp,
                    color: Colors.green,
                  ),
                  hintText: "Search for",
                ),onChanged: (key){
                  if(key.isEmpty){
                    _search = false;
                    setState(() {
                    });
                  }
                  searchkeyword = key;
                  listsearchproducts = listproducts.where((element) => element.title!.toLowerCase().contains(key)).toList();
                  setState(() {
                  });
              },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.05,
              width: MediaQuery.of(context).size.width * 0.1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              // child: GestureDetector(
              //   onTap: () => _show(context, snapshot.data![1]),
              //   child: Icon(
              //     Icons.filter_list,
              //     color: Colors.green,
              //   ),
              // )
            ),
          ],
        ),
        listsearchproducts.isNotEmpty?
        Expanded(
          child: GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: listsearchproducts.length,
              itemBuilder: (context, index) {
                final product = listsearchproducts[index];
                return h2(product: product);
              }),
        ): Center(child: Text("product not found"),)
      ],
    );
  }
}
