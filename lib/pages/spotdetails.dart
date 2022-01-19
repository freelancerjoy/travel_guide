import 'package:flutter/material.dart';
import 'package:travel_guide/data/travel_data.dart';
import 'package:travel_guide/model/travel_model.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';

class sportDetail extends StatefulWidget {
  String? sportname;
  String? timage;
  String? tdescription;

  @override
  _sportDetailState createState() => _sportDetailState();

  sportDetail({this.sportname, this.timage, this.tdescription});
}

class _sportDetailState extends State<sportDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarDEcoration(context, 'curd'),
      body: ListView(
        children: [
          ClipRRect(
            child: Image.asset('${widget.timage}'),
          ),
          Text('${widget.sportname}'),
          Text('Spot Description'),
        ],
      ),
    );
  }
}