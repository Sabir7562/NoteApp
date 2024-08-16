import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Home_Page.dart';
import 'package:notes_app/noteDBProvider.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'notes_model.dart';

class NextPage extends StatelessWidget{
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Next page"),
          backgroundColor: Colors.yellow,
      ),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: titlecontroller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter title....",
                  label: Text("Title")
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: descController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Enter description....",
                    label: Text("desc")
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OutlinedButton(onPressed: (){
                    var mtitle = titlecontroller.text.toString();
                    titlecontroller.clear();
                    var mdesc = descController.text.toString();
                    descController.clear();
                    context.read<NoteDBProvider>().addNote(newnote: NoteModel(title: mtitle, desc: mdesc));
                    Navigator.pop(context);
                    }, child: Text("Add")),
                  OutlinedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Cancel"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  }

