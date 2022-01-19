import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travel_guide/pages/region_page.dart';
import 'package:travel_guide/widgets/appBarDecoration.dart';
import 'package:travel_guide/widgets/static_variablee.dart';
import 'package:url_launcher/url_launcher.dart';
const String _url = 'https://flutter.dev';

class MyHomePageClass extends StatefulWidget {
  const MyHomePageClass({Key? key}) : super(key: key);

  @override
  _MyHomePageClassState createState() => _MyHomePageClassState();
}

class _MyHomePageClassState extends State<MyHomePageClass> {
  String _facebook = 'https://www.facebook.com/';
  String _url = 'https://flutter.dev';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:appBarDEcoration(context, 'Home'),
      body: _bodyUi(),
    );
  }

  Widget _bodyUi(){
    Size size =MediaQuery.of(context).size;
    Color Primerycolor =Theme.of(context).primaryColor;
    Color Hintcolor = Theme.of(context).hintColor;
    return ListView(
      children: [
        Container(
          height: size.height*0.2,
          width: size.width,
          decoration: BoxDecoration(
            color: Primerycolor
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.pin_drop_outlined,size: size.height*0.1,color: Colors.white,)
              ,Column(
                mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Text("Travel Guide",style: TextStyle(color: Hintcolor,fontSize: size.height*0.04),),
                 Text("Travel Information for All Countries",style: TextStyle(color: Hintcolor,fontSize: size.height*0.02)),
               ],
              )
            ],
          ),
        ),
        GridView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ), itemCount: StaticVariable.HomeData.length,itemBuilder: (context,index){
          return _gridBuilder(index);
        }),
        Card(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                IconButton(
                    onPressed: ()async{
                      if (await canLaunch('https://www.facebook.com/')){
                        await launch('https://www.facebook.com/');
                      };
                    },
                    icon:  Icon(FontAwesomeIcons.facebook,size: 50,color: Colors.blue,
                    ),
                ),

                IconButton(
                    onPressed: (){
                      _launchURL(_facebook);
                    },
                    icon:  Icon(FontAwesomeIcons.twitter,size: 50,color: Colors.blue),
                ),

                IconButton(
                    onPressed: (){},
                    icon:  Icon(FontAwesomeIcons.instagram,size: 50,color: Colors.purple),
                ),

                IconButton(
                    onPressed: (){},
                    icon:Icon(FontAwesomeIcons.youtube,size: 50,color: Colors.red),
                ),

              ],
            ),
          ),
        )
      ],
    );

  }
  Widget _gridBuilder(int index) {
    return InkWell(

      onTap: (){
        if (index==0||index==1){
          Navigator.push(context,MaterialPageRoute(builder: (context)=>region_page(
            index:index,
            region: StaticVariable.HomeData[index],
          )));
        }
      },
      child: Card(
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              index==0?Icons.my_location_sharp :
              index==1?Icons.circle :
              index==2?Icons.content_paste_sharp :
              index==3?Icons.stars_sharp :
              index==4?Icons.video_call_sharp :
              Icons.home,color: Colors.white,size: 30,),
            Text(StaticVariable.HomeData[index],
              style: TextStyle(
                color: Colors.white,
              ),)
          ],
        ),
      ),
    );
  }
}
void _launchURL(String _url) async {
  if (!await launch(_url)) throw 'Could not launch $_url';
}

