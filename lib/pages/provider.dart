import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier{
  int count=0;
  // List allahname = [
  //   'Allah',
  //   'Rahman',
  // ];
  //
  // void allahnamee(){
  //   allahname;
  // }

  void increment(){
    count++;
    notifyListeners();
  }
  void decrement(){
    count--;
    notifyListeners();
  }
}
