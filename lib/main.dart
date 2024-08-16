import 'package:flutter/material.dart';
import 'package:notes_app/dbhelper.dart';
import 'package:notes_app/noteDBProvider.dart';
import 'package:provider/provider.dart';
import 'Home_Page.dart';
import 'Provider/Multiple_provider/list_map_provider.dart';
import 'Provider/Single_provider/Provider_home.dart';
import 'Provider/Single_provider/counter_provider.dart';

// void main(){
//   runApp(ChangeNotifierProvider(create: (context)=>Counterprovider(),
//     child: ChangeNotifierProvider(create: (context)=>ListProvider(),child: MyApp(),)),
//   );
// }

void main(){
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=>NoteDBProvider(mainDB: dbhelper.getinstance))
    // ChangeNotifierProvider(create: (context)=> Counterprovider()),
    // ChangeNotifierProvider(create: (context)=>ListProvider()),
  ],child: MyApp(),));
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: note_home(),
    );
  }
}

