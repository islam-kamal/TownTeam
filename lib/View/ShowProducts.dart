import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:townteam/Model/AppBarComponents.dart';
class ShowProducts extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return null;
  }


}

class ShowProductsState extends State<ShowProducts>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: AppBarComponents.HeaderTitle('Products'),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          AppBarComponents.HeaderSearch(),
          AppBarComponents.HeaderCart(),
        ],
      ),
      body: new WillPopScope(
        onWillPop: () async => false,
        child: new Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: FutureBuilder(
            //  future: getData(),
              builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
                if (!snapshot.hasData) return new Container();
           //     departmentData = snapshot.data;
                return StaggeredGridView.countBuilder(
                  crossAxisCount: 2,
                  padding: EdgeInsets.only(top: 10.0),
                //  itemCount: departmentData.length,
                  itemBuilder: (BuildContext context, int index) =>
                      GestureDetector(
                        child: Card(
                          margin: const EdgeInsets.all(10.0),
                          child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                AspectRatio(
                                  // use to make all cells of grid view in same size
                                  aspectRatio: 18.0 / 13.0,
                                  child: Image(
                                    //  image: AssetImage(departmentData[index][0]),
                                    image: AssetImage('images/doctor4.png'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Padding(
                                  padding:
                                  EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      /*
                                      Text(departmentData[index]['name'],
                                          textAlign: TextAlign.center),

                                       */
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        onTap: () {

                        },
                      ),
                  staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                );
              }),
        ),
      ),
    );
  }

}