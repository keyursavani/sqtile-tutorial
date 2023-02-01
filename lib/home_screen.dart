import 'package:flutter/material.dart';

import 'db_handler.dart';
import 'notes.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{
  DBHelper? dbHelper;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return new Scaffold(
     appBar: new AppBar(
       title: new Text("Notes SQL"),
       centerTitle: true,
     ),
     body: new Column(
       children: [
       ],
     ),
     floatingActionButton: new FloatingActionButton(
       onPressed : (){
         dbHelper!.insert(
             new NotesModel(
               title: 'First Note',
               age : 22,
               description: 'This is My first sql app',
               email : 'savanikeyur1011@gmail.com'
             )
         ).then((value){
           print("data added");
           }).onError((error, stackTrace){
             print(error.toString());
         });
       },
       child: const Icon(Icons.add),
     ),
   );
  }
}