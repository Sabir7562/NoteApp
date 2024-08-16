import 'package:flutter/cupertino.dart';

class Counterprovider extends ChangeNotifier{

  //this is the integer variable which contain the 0 value
  int _count= 0;

  //this is the function which is Increment the count value with 1 every time;
  void incrementCount(){
    _count++;
    notifyListeners();
  }
  void DecrementCount(){
    if(_count>0){
    _count--;
    }
    notifyListeners();
  }
  //this is the funtion get the count value and store in it.
  int getvalue(){
    return _count;
  }
}