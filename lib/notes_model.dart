import 'package:notes_app/dbhelper.dart';

class NoteModel{
  int? sno;
  String title;
  String desc;

  NoteModel({this.sno,required this.title,required this.desc});

//from Map
factory NoteModel.fromMap(Map<String, dynamic> map ){
  return NoteModel(sno:map[dbhelper.NoteColumnsrNo],title: map[dbhelper.NoteColumnTitle], desc: map[dbhelper.NoteColumnDesc]);
}

///to map
Map<String, dynamic> toMap(){
  return {
    dbhelper.NoteColumnTitle:title,
    dbhelper.NoteColumnDesc:desc,
  };
}

}