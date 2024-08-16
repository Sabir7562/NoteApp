import 'package:flutter/cupertino.dart';
import 'package:notes_app/dbhelper.dart';
import 'package:notes_app/noteModel/note_model.dart';

import 'notes_model.dart';

class NoteDBProvider extends ChangeNotifier{
dbhelper mainDB;
NoteDBProvider({required this.mainDB});
  List<NoteModel> _allnotes = [];

  //events
void addNote({required NoteModel newnote}) async {
bool isNoteAdded = await mainDB.insertData(newnote);
if(isNoteAdded){
_allnotes = await mainDB.getallnote();
notifyListeners();
}
}

//get initial note's
void getInitialNotes() async{
  _allnotes = await mainDB.getallnote();
  notifyListeners();
}

List<NoteModel> getNoteData(){
  return _allnotes;
}
//update note with provider

void updateNote({required NoteModel updatedNote,required int sno})async{
 bool isNoteupdated = await mainDB.updateNote(sno: sno, updatedNote: updatedNote );
  if(isNoteupdated){
    _allnotes = await mainDB.getallnote();
    notifyListeners();
  }
}

//delete Note
void deleteNote({required int sno})async{
bool isNotDeleted = await mainDB.DeleteNote(sno: sno);
if(isNotDeleted){
  _allnotes = await mainDB.getallnote();
  notifyListeners();
}

}

}