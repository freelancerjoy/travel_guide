import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:travel_guide/widgets/formdecration.dart';
import 'package:travel_guide/widgets/static_variablee.dart';

class AddTravelSpot extends StatefulWidget {
  const AddTravelSpot({Key? key}) : super(key: key);

  @override
  _AddTravelSpotState createState() => _AddTravelSpotState();
}

class _AddTravelSpotState extends State<AddTravelSpot> {

  String? selectTravelRegion;
  String? selectTravelSpot;

  ImagePicker image = ImagePicker();
  File? file;
  String uri = "";

  Future <void> CameraImag() async {
    var img = await image.pickImage(source: ImageSource.camera);
    setState(() {
      file = File(img!.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Travel Spot'),
      ),
      body: _bodUI(),
    );
  }

  Widget _bodUI(){
  Size size =  MediaQuery.of(context).size;
    return Padding(padding: EdgeInsets.symmetric(horizontal: 10),
      child: ListView(
        children: [
          ClipRRect(
            child: Image.asset('img/1.png',height: 200,width: 200,),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(onPressed: (){
                CameraImag();
              },
                  icon: Icon(Icons.camera)),

              IconButton(onPressed: (){},
                  icon: Icon(Icons.image)),
            ],
          ),
          SizedBox(height: 10,),
          TextField(
            maxLines: 2,
            keyboardType: TextInputType.text,
            decoration: FormDecoration.copyWith(
              labelText: 'Spot Name'
            ),

          ),
          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(3)),
              border: Border.all(
                color: Theme.of(context).primaryColor,
                width: 3,
              )
            ),
            width: MediaQuery.of(context).size.width,
           child: DropdownButtonHideUnderline(
             child: DropdownButton(
               value: selectTravelSpot,
               hint: Container(
                 width: size.width*.75,
                 child: Text('Select Region', style: TextStyle(
                   color: Colors.grey[700],
                   fontSize: size.height*0.023
                 ),),
               ),
               items: StaticVariable.TravelRegion.map((selectTravelSpot){
                 return DropdownMenuItem(
                     child: Container(
                   width: size.width*.75,
                       child: Text(selectTravelSpot,style: TextStyle(
                         color: Colors.grey[900],
                         fontSize: 16,
                       ),),
                 ),
                 value: selectTravelSpot,);
               }).toList(),
               onChanged: (newValue){
                 setState(() {
                   selectTravelSpot=newValue as String?;
                 });
               },
               dropdownColor: Colors.white,
             ),
           ),
          ),

          SizedBox(height: 10,),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                )
            ),
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonHideUnderline(
              child: DropdownButton(
                value: selectTravelRegion,
                hint: Container(
                  width: size.width*.75,
                  child: Text('Select Spot', style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: size.height*0.023
                  ),),
                ),
                items: StaticVariable.TravelRegion.map((selectTravelRegion){
                  return DropdownMenuItem(
                    child: Container(
                      width: size.width*.75,
                      child: Text(selectTravelRegion,style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 16,
                      ),),
                    ),
                    value: selectTravelRegion,);
                }).toList(),
                onChanged: (newValue){
                  setState(() {
                    selectTravelRegion=newValue as String?;
                  });
                },
                dropdownColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


