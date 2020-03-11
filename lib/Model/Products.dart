import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'ProductDetials.dart';

class Products extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProductsState();
  }
}

class ProductsState extends State<Products> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('products').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text('There is no products..');
        } else {
          return GridView.builder(
              itemCount: snapshot.data.documents.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, index) {
                return Padding(
                  padding: const EdgeInsets.all(0.0),
                  child:  Single_prod(
                    prod_name: snapshot.data.documents[index]['product_name'],
                    prod_pricture: snapshot.data.documents[index]['product_picture'],
                    prod_old_price: snapshot.data.documents[index]['product_old_price'],
                    prod_price: snapshot.data.documents[index]['product_price'],
                  )
                );
              });
        }
      },
    );

  }
}

class Single_prod extends StatelessWidget {
  final prod_name;
  final prod_pricture;
  final prod_old_price;
  final prod_price;

  Single_prod({
    this.prod_name,
    this.prod_pricture,
    this.prod_old_price,
    this.prod_price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: prod_name,
          child: Material(
            child: InkWell(

              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // Get available height and width of the build area of this widget. Make a choice depending on the size.
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(0.0),
                      content: new Container(
                        width: width,
                        height: height / 1.5,
                        child: ProductDetials(),
                      ),
                    );
                  },
                );
              },
              child: GridTile(
                  footer: Container(
                    color: Colors.white70,
                    child: ListTile(
                      leading: Text(
                        prod_name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      title: Text(
                        "\$$prod_price",
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.w800),
                      ),
                      subtitle: Text(
                        "\$$prod_old_price",
                        style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w800,
                            decoration: TextDecoration.lineThrough),
                      ),
                    ),
                  ),
                  child: Image.network(
                    prod_pricture,
                    fit: BoxFit.cover,
                    //height: 50,
                  )),
            ),
          )),
    );

  }


}
