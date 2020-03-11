import 'package:flutter/cupertino.dart';
import'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class HorizontalList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return HorizontalListState();
  }

}

class HorizontalListState extends State<HorizontalList>{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      padding: EdgeInsets.only(top:5.0,right:20.0),
      height: 100.0,
      child: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.
          collection("catogery")
            .orderBy('name')
            .snapshots(),

        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Text('there is no catogery...');
          }else{
              return ListView(
                  scrollDirection: Axis.horizontal,
                  children: getCatogeryItems(snapshot)
              );
          }
          }
      ),

      /*
      //standalone list view
      ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Image.asset('images/cats/tshirt.png',height: 50,),
                  Text('Shirts',style: TextStyle(fontSize: 14,color: Colors.white),),
                ],
              ),
            ),
            onTap: (){

            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Image.asset('images/cats/dress.png',height: 50,),
                  Text('Dress',style: TextStyle(fontSize: 14,color: Colors.white),),
                ],
              ),
            ),
            onTap: (){

            },
          ),
          InkWell(
            child: Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                 // Image.asset('images/cats/accessories.png',height: 50,),
                  Image.network('https://firebasestorage.googleapis.com/v0/b/townteam-8a348.appspot.com/o/Category%2Faccessories.png?alt=media&token=7827c8fb-4fe2-4497-86db-c601c3ff443e',
                    height: 50,),
                  Text('Accessories',style: TextStyle(fontSize: 14,color: Colors.white),),
                ],
              ),
            ),
            onTap: (){

            },
          ),
          InkWell(
            child:  Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Image.asset('images/cats/formal.png',height: 50,),
                  Text('Formal',style: TextStyle(fontSize: 14,color: Colors.white),),
                ],
              ),
            ),
            onTap: (){

            },
          ),
          InkWell(
            child:  Container(
              padding: EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Image.asset('images/cats/jeans.png',height: 50,),
                  Text('Jeans',style: TextStyle(fontSize: 14,color: Colors.white),),
                ],
              ),
            ),
            onTap: (){

            },
          ),
          InkWell(
           child:  Container(
             padding: EdgeInsets.all(5.0),
             child: Column(
               children: <Widget>[
                 Image.asset('images/cats/shoe.png',height: 50,),
                 Text('Shoes',style: TextStyle(fontSize: 14,color: Colors.white),),
               ],
             ),
           ),
           onTap: (){

           },
         ),
          InkWell(
           child: Container(
             padding: EdgeInsets.all(5.0),
             child: Column(
               children: <Widget>[
                 Image.asset('images/cats/informal.png',height: 50,),
                 Text('Informal',style: TextStyle(fontSize: 14,color: Colors.white),),
               ],
             ),
           ),
           onTap: (){

           },
         )

        ],
      ),

       */
    );


  }
    getCatogeryItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data.documents
        .map((doc) =>    InkWell(
      child: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            Image.network(doc['image_url'],height: 50,),
            Text(doc['name'],style: TextStyle(fontSize: 14,color: Colors.white),),
          ],
        ),
      ),
      onTap: (){

      },
    )
    )
        .toList();
    }

}
