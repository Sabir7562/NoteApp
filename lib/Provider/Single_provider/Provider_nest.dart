import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Provider/Multiple_provider/list_map_provider.dart';
import 'package:notes_app/noteModel/note_model.dart';

import 'package:provider/provider.dart';

import 'counter_provider.dart';

class nest_page extends StatefulWidget{
  @override
  State<nest_page> createState() => _nest_pageState();
}

class _nest_pageState extends State<nest_page> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("nest page"),
        backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: ElevatedButton(onPressed: (){
          Provider.of<ListProvider>(context,listen: false).addMap(
            Note_model(desc: "Love your self", title:"Fev Note")
          );
        }, child: Text("add")),
      ),
      floatingActionButton: FloatingActionButton(onPressed:(){
        Provider.of<Counterprovider>(context,listen: false).incrementCount();
      } ,child: Icon(Icons.add),),
    );
  }
}