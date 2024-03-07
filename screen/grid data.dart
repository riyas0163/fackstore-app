import 'package:cached_network_image/cached_network_image.dart';
import 'package:fackstore/model/classdata.dart';
import 'package:fackstore/screen/productscreen.dart';
import 'package:flutter/material.dart';

class h2 extends StatelessWidget {
  const h2({super.key,required this.product});
  final datamodel product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){Navigator.push(context,MaterialPageRoute(builder: (context)=>h3(product: product)));},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(color: Colors.white,
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: "${product.image}",
                height: MediaQuery.of(context).size.height *0.09,
                width: MediaQuery.of(context).size.width*0.3,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${product.title}",maxLines: 1,),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("\$ ${product.price}"),
                  Icon(Icons.favorite_border)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
