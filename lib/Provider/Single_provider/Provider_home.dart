import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Provider/Multiple_provider/list_map_provider.dart';
import 'package:notes_app/noteModel/note_model.dart';
import 'package:provider/provider.dart';
import 'Provider_nest.dart';
import 'counter_provider.dart';

class phome extends StatefulWidget{
  @override
  State<phome> createState() => _phomeState();
}

class _phomeState extends State<phome> {
  List<Note_model> allnote = [];
   @override
  Widget build(BuildContext context) {
      allnote.clear();
     var data = Provider.of<ListProvider>(context).getAllMaps();
//for loop get the list index value
     for(Map<String,dynamic> eacnote in data){
       allnote.add(Note_model.fromMap(eacnote));
     }

    return Scaffold(
      appBar: AppBar(
        title: Text("Statemanagement"),
        backgroundColor: Colors.yellow,
      ),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          data.isNotEmpty ? Expanded(
            child: ListView.builder(
                itemCount: allnote.length,
                itemBuilder: (_,index){
              return ListTile(
                title: Text(allnote[index].title),
                subtitle: Text(allnote[index].desc),
                trailing: SizedBox(
                  width: 50,
                  child: Row(
                    children: [
                      InkWell(
                        onTap:(){
                         context.read<ListProvider>().updateData(updatedNote: Note_model(desc: allnote[index].desc, title: "Updated Title"), index: index);
                        },
                          child: Icon(Icons.edit,color: Colors.blue,)),
                      InkWell(
                        onTap: (){
                          context.read<ListProvider>().deleteData(index: index);
                        },
                          child: Icon(Icons.delete,color: Colors.red,))
                    ],
                  ),
                ),
              );
            }),
          ):Text("No Note's Yet"),
          Center(
            child: Text("${Provider.of<Counterprovider>(context).getvalue()}"),
          ),
          SizedBox(height: 20),
          ElevatedButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>nest_page()));
          }, child: Text("Next"))
        ],

      )

    );
  }
}