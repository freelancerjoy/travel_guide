import 'package:flutter/material.dart';
import 'package:travel_guide/pages/addtravel.dart';
import 'package:travel_guide/pages/travel_spot.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
import 'package:travel_guide/widgets/static_variablee.dart';

class region_page extends StatefulWidget {
  int ? index;
  String? region;

  @override
  _region_pageState createState() => _region_pageState();

  region_page({this.index, this.region});
}

class _region_pageState extends State<region_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDEcoration(context, '${widget.region}'),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddTravelSpot()));
      },
        child: Icon(Icons.add),
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          mainAxisExtent: 100,
          ),
        itemCount: widget.index==0?StaticVariable.TravleBD.length : StaticVariable.TravleWorld.length,

          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context)=>TravelSpot(
                  index:index,
                  region: StaticVariable.TravleWorld[index],
                )));
              },
              child: Card(
                child: Center(child: Text(widget.index==0? StaticVariable.TravleBD[index]: StaticVariable.TravleWorld[index])),

              ),
            );
          })

    );
  }

}
