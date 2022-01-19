import 'package:flutter/material.dart';
import 'package:travel_guide/data/travel_data.dart';
import 'package:travel_guide/model/travel_model.dart';
import 'package:travel_guide/pages/spotdetails.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
import 'package:travel_guide/widgets/static_variablee.dart';

class TravelSpot extends StatefulWidget {
  int ? index;
  String? region;

  @override
  _TravelSpotState createState() => _TravelSpotState();

  TravelSpot({this.index, this.region});
}

class _TravelSpotState extends State<TravelSpot> {
  List <TravelModel> travelList=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    travelList=GetTravel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDEcoration(context, '${widget.region}'),
      body: _bodyUI(),
    );
  }
    Widget _bodyUI(){
      return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1,
          ),

          itemBuilder: (context,index){
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => sportDetail(
                  sportname: travelList[index].spotname,
                  timage: travelList[index].timage,
                  tdescription: travelList[index].tdescription,
                )));
              },
              child: Container(
                margin: EdgeInsets.only(bottom: 16, left: 10, right: 10, top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 5.0,
                      spreadRadius: 3.0,
                      offset: Offset(0,3)
                    )
                  ]
                ),
                child: Column(
                  children: [
                    ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                ),
                          child: Image.asset('${travelList[index].timage}',
                          height: 180,
                              width: double.maxFinite,
                          fit: BoxFit.cover,),

                   ),
                    SizedBox(height: 10,),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${travelList[index].spotname}',style: TextStyle(
                            fontSize: 25,
                          ),),
                          SizedBox(height: 6,),
                          Text('${travelList[index].tdescription}',
                            maxLines: 3,

                            textAlign: TextAlign.justify,
                            style: TextStyle(
                            fontSize: 20,
                          ),)
                        ],
                      ),
                    )
                    
                  ],
                ),
              ),

            );
          }

          );
    }

}
