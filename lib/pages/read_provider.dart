import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_guide/pages/provider.dart';

class readProvider extends StatefulWidget {
  const readProvider({Key? key}) : super(key: key);

  @override
  _readProviderState createState() => _readProviderState();
}

class _readProviderState extends State<readProvider> {
  // int count = 0;
  //
  // void increment(){
  //   count++;
  // }
  // void decrement(){
  //   count--;
  // }
  // @override
  Widget build(BuildContext context) {
  final CounterProvider counterProvider=Provider.of<CounterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Read Provider'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15,),
            Text('I Love You ${counterProvider.count.toString()}',
        style: TextStyle(fontSize: 50,color: Colors.blueAccent),),
            SizedBox(height: 15,),
            RaisedButton(
              child: Text('Increment'),
                onPressed: counterProvider.increment,
            ),
            RaisedButton(
              child: Text('Decrement'),
              onPressed: counterProvider.decrement,
            ),
          ],
        ),
      ),
    );
  }
}
