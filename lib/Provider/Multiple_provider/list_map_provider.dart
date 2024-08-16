import 'package:flutter/widgets.dart';
import 'package:notes_app/noteModel/note_model.dart';

class ListProvider extends ChangeNotifier{
  List<Map<String,dynamic>> _mData = [];

  //events
  // add data
void addMap(Note_model newNote){
  _mData.add(newNote.toMap());
  notifyListeners();
}

//update data
  void updateData({required Note_model updatedNote, required int index}){
    _mData[index] = updatedNote.toMap();
    notifyListeners();
  }


  //delete data

  void deleteData({required int index}){
_mData.removeAt(index);
notifyListeners();
  }

//get data
List<Map<String,dynamic>> getAllMaps(){
  return _mData;
}
}