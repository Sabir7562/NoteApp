import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:notes_app/notes_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class dbhelper{
  dbhelper._();
  static final dbhelper getinstance = dbhelper._();
  static final String TableName = "NoteTable";
  static final String NoteColumnTitle = "title";
  static final String NoteColumnDesc = "Desc";
  static final String NoteColumnsrNo = "sno";
  Database? mydb;

  ///------------get db with Condition-----
  Future<Database> getdb()async{
    if(mydb!=null){
      return mydb!;
    }else{
      return opendb();
    }
  }
  ///-----open datbase with dbpath-----
  Future<Database> opendb()async{
    Directory appdir = await getApplicationDocumentsDirectory();
    String rootPath = appdir.path;
    String dbpath = join(rootPath,"example.db");
    return await openDatabase(dbpath, version: 1,onCreate: (db,version){
      db.rawQuery("CREATE TABLE $TableName ( $NoteColumnsrNo INTEGER PRIMARY KEY AUTOINCREMENT, $NoteColumnTitle TEXT, $NoteColumnDesc TEXT)");
    });
  }
  ///---------insert data-----
  Future<bool> insertData(NoteModel newnote)async{
    var db = await getdb();
    int RowEffeted = await db.insert(TableName, newnote.toMap());
    return RowEffeted>0;
  }
  ///----------getallnotes-------
 Future<List<NoteModel>> getallnote()async{
    var db = await getdb();
    List<NoteModel> mNotes = [];

    var allnote = await db.query(TableName);

    for(Map<String,dynamic> eachnote in allnote){
      NoteModel eachModel = NoteModel.fromMap(eachnote);
      mNotes.add(eachModel);
    }
    return mNotes;
 }
///----update notes-----
Future<bool> updateNote({
  required int sno,required NoteModel updatedNote }) async{
    var db = await getdb();
   int RowEffected = await db.update(TableName, {
      NoteColumnTitle:updatedNote.title,
      NoteColumnDesc:updatedNote.desc,
    },where: "$NoteColumnsrNo = $sno");
   return RowEffected>0;
}
///-----------delete the note---------
Future<bool> DeleteNote({required int sno})async{
var db = await getdb();
int Roweffected = await db.delete(TableName,where: "$NoteColumnsrNo= $sno");
return Roweffected>0;
}
}
