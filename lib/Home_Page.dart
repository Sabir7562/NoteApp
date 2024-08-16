import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/dbhelper.dart';

class note_home extends StatefulWidget {
  const note_home({super.key});

  @override
  State<note_home> createState() => _note_homeState();
}

class _note_homeState extends State<note_home> {
  dbhelper? obj;
  int? a;
  List<Map<String,dynamic>> alldata = [];
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController updattitle = TextEditingController();
  TextEditingController updatedesc = TextEditingController();

  @override
  void initState() {
    super.initState();
    obj = dbhelper.getinstance;
    a = 5;
  }

  void getinstall() async {
    alldata = await obj!.getallnote();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("NoteApp"),
        backgroundColor: Colors.yellow,
      ),
      body: ListView.builder(
          itemCount: alldata.length,
          itemBuilder: (_,index){
        return ListTile(
          leading: Text("${alldata[index][dbhelper.NoteColumnsrNo]}"),
          title: Text("${alldata[index][dbhelper.NoteColumnTitle]}"),
          subtitle: Text("${alldata[index][dbhelper.NoteColumnDesc]}"),
          trailing: SizedBox(
            width:100,
            child: Row(
              children: [
                IconButton(onPressed: (){
                  ShownDailog(context,alldata[index][dbhelper.NoteColumnsrNo]);
                }, icon: Icon(Icons.edit),color: Colors.blue,),
                // Icon(Icons.edit,color: Colors.blue),
                IconButton(onPressed: (){
                  obj!.DeleteNote(sno: alldata[index][dbhelper.NoteColumnsrNo]);
                  getinstall();
                }, icon: Icon(Icons.delete,color: Colors.red,))
              ],
            ),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        onPressed: (){
        smbs();
        },child: Icon(Icons.add),),

    );
  }

  ///----------bottom mode sheet------------
  Widget smbs(){
    showModalBottomSheet(context: context, builder: (_){
      return SizedBox(
          width: double.infinity,
          // height: 400,
          child: Container(
            child: Column(
              children: [
                Text("Notes",style: TextStyle(fontSize: 30),),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      label: Text("Title"),
                      hintText: "Enter Title",
                      border: OutlineInputBorder(
                      )
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: descController,
                    decoration: InputDecoration(
                      label: Text("Desc"),
                      hintText: "Enter Desc..",
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  OutlinedButton(onPressed: (){
                    oncreate();
                    Navigator.pop(context);
                  }, child: Text("Add")),
                  OutlinedButton(onPressed: (){
                    Navigator.pop(context);
                  }, child: Text("Cancel"))
                ],)
              ],
            ),
          ));
    });
    return Container();
  }

  void oncreate() async {
    var mtitle = titleController.text.toString();
    titleController.clear();
    var mdesc = descController.text.toString();
    descController.clear();
   bool check = await obj!.insertData(title: mtitle, desc: mdesc);
   String msg = "Note Adding Faild";
   if(check){
     msg = "Note added successfully....";
     getinstall();
   }
   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
  ///-------------------show pop up box---------------
void ShownDailog(BuildContext context,int sno){
showDialog(context: context, builder: (BuildContext context){
  return AlertDialog(
    title: Text("Update Notes..."),
    content: SizedBox(
      height: 250,
      child: Column(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(
                hintText: "Update Title",
                label: Text("Title"),
                border: OutlineInputBorder()),
          ),
          SizedBox(height: 20),
          TextField(
            controller: descController,
            decoration: InputDecoration(
                hintText: "Update desc",
                label: Text("Desc"),
                border: OutlineInputBorder()),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              OutlinedButton(onPressed: (){
                onchange(sno: sno);
                getinstall();
                Navigator.pop(context);
              }, child: Text("Update")),
              OutlinedButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel"))
            ],
          )
        ],
      ),
    ),
  );
});
}

void onchange({required int sno}) async{
    var mupdatetitle = titleController.text.toString();
    updattitle.clear();
    var mupdatedesc = descController.text.toString();
    updatedesc.clear();
  bool ucheck = await obj!.updateNote(sno: sno, title: mupdatetitle, desc: mupdatedesc);
  String umsg = "Note Update faild";
  if(ucheck){
    umsg = "Note Update successfully";
    getinstall();
    print("Updated Done");
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(umsg)));
}


}
