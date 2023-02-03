import 'package:flutter/material.dart';

import 'db_handler.dart';
import 'notes.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen>{

  DBHelper? dbHelper;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     appBar: AppBar(
       title: Text("Notes SQL"),
       centerTitle: true,
     ),
     body: Column(
       children: [
       ],
     ),
     floatingActionButton: FloatingActionButton(
       onPressed : (){
         dbHelper!.insert(
                NotesModel(
               title: 'First Note',
               age : 22,
               description: 'This is My first sql app',
               email : 'savanikeyur1011@gmail.com'
             )
         ).then((value){
           print('data added');
           }).onError((error, stackTrace){
             print(error.toString());
         });
       },
       child: const Icon(Icons.add),
     ),
   );
  }
}