import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:townteam/Model/SizeHorizontalList.dart';

class ProductDetials extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProductDetialsState();
  }
}

class ProductDetialsState extends State<ProductDetials> {
  bool _favouriteColor=true;


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new SafeArea(
        child: SingleChildScrollView(
          child: new Container(
            child: Column(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Image(
                          image: AssetImage('images/m1.png'),
                          fit: BoxFit.cover,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width / 3,
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          child:      IconButton(
                            onPressed: (){
                              setState(() {
                                _favouriteColor=false;
                              });
                            },
                            icon: Icon(
                              Icons.favorite,
                              color: (_favouriteColor)?Colors.white:Colors.red,
                              size: 35,),
                          ),
                        )

                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'new Dress',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 17),
                          ),
                          Spacer(),
                          Text(
                            'Price :  130',
                            style:
                                TextStyle(color: Colors.blueGrey, fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  indent: 15,
                  endIndent: 15,
                  color: Colors.black,
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Text(
                    'Select Size',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(5.0),
                  child: SizeHorizontalList(),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Select Quantity',
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 15,
                    left: 40,
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {},
                        color: Colors.grey,
                        textColor: Colors.white,
                        child: Icon(
                          Icons.remove,
                          size: 18,
                        ),
                        padding: EdgeInsets.all(5),
                        shape: CircleBorder(),
                      ),
                      Text(
                        '1',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {},
                        color: Colors.grey,
                        textColor: Colors.white,
                        child: Icon(
                          Icons.add,
                          size: 18,
                        ),
                        padding: EdgeInsets.all(5),
                        shape: CircleBorder(),
                      ),
                    ],
                  ),
                ),
                RaisedButton(
                    color: Colors.deepPurpleAccent,
                    child: Text(
                      'Add To Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(
                          color: Colors.deepPurpleAccent,
                          width: 2.0,
                          style: BorderStyle.solid),
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
