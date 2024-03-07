import 'package:cached_network_image/cached_network_image.dart';
import 'package:fackstore/model/classdata.dart';
import 'package:fackstore/screen/addtocart.dart';
import 'package:flutter/material.dart';

class h3 extends StatelessWidget {
  const h3({super.key,required this.product});
  final datamodel product;


  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white,
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              imageUrl: "${product.image}",
              height: MediaQuery.of(context).size.height *0.3,
              width: MediaQuery.of(context).size.width*0.8,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${product.title}",maxLines: 2,),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("\$ ${product.price}"),
                  Icon(Icons.favorite_border),
                  IconButton(onPressed: (){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>h4(id: int.parse(product.id.toString()))));
                  }, icon: Icon(Icons.add))
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("${product.description}"),
            )
          ],
        ),
      ),
    );
  }
}
