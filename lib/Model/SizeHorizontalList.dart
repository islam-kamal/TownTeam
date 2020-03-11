import'package:flutter/material.dart';

class SizeHorizontalList extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SizeHorizontalListState();
  }
}
class SizeHorizontalListState extends State<SizeHorizontalList>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
      alignment: Alignment.center ,
      padding: EdgeInsets.only(top:5.0,),
      height:MediaQuery.of(context).size.width/10,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              child: Container(
                width: MediaQuery.of(context).size.width/7,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey)
                ),
                child: Text('UK 7',style: TextStyle(fontSize: 14,color: Colors.blueGrey),),
              ),
              onTap: (){

              },
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width/7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey)
                ),
                child: Text('UK 8',style: TextStyle(fontSize: 14,color: Colors.blueGrey),),
              ),
              onTap: (){

              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width/7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey)
                ),
                child: Text('UK 9',style: TextStyle(fontSize: 14,color: Colors.blueGrey),),
              ),
              onTap: (){

              },
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 10),
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width/7,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blueGrey)
                ),
                child: Text('UK 10',
                  style: TextStyle(fontSize: 14,
                      color: Colors.blueGrey),),
              ),
              onTap: (){

              },
            ),
          ),


        ],
      ),
    );
  }

}
