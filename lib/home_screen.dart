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
   late Future<List<NotesModel>> notesList;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    dbHelper = DBHelper();
    loadData ();
  }

  loadData () async{
    notesList = dbHelper!.getNotesList();
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
         Expanded(
           child: FutureBuilder(
             future: notesList,
               builder: (context , AsyncSnapshot<List<NotesModel>> snapshot){
              if(snapshot.hasData){
                return
                  ListView.builder(
                      itemCount: snapshot.data?.length,
                      reverse: false,
                      shrinkWrap: true,
                      itemBuilder: (context , index){
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                          background: Container(
                            color: Colors.red,
                            child: Icon(Icons.delete_forever),
                          ),
                          onDismissed: (DismissDirection direction){
                            setState(() {
                              dbHelper!.delete(snapshot.data![index].id!);
                              notesList = dbHelper!.getNotesList();
                              snapshot.data!.remove(snapshot.data![index]);
                            });
                          },
                          key: ValueKey<int>(snapshot.data![index].id!),
                          child: Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              title: Text(
                                  snapshot.data![index].title.toString()),
                              subtitle: Text(
                                  snapshot.data![index].description.toString()),
                              trailing: Text(
                                  snapshot.data![index].age.toString()),
                            ),
                          ),
                        );
                      });
              }
              else{
                return CircularProgressIndicator();
              }
               }
           ),
         )
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
           setState(() {
             notesList = dbHelper!.getNotesList();
           });
           }).onError((error, stackTrace){
             print(error.toString());
         });
       },
       child: const Icon(Icons.add),
     ),
   );
  }
}