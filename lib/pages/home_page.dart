// ignore_for_file: prefer_const_constructors

import 'package:bnotes/helper/drawer_navigation.dart';
import 'package:bnotes/models/note.dart';
import 'package:bnotes/pages/add_note_page.dart';
import 'package:bnotes/services/note_service.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

    List<Note> _noteList = [];
    var _noteService = NoteService();


  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  getAllNotes() async {
    _noteList.clear();
    var noteService = await _noteService.readNote();
    noteService.forEach((note) {
      setState(() {
        var noteModel = Note();
        noteModel.title = note["title"];
        noteModel.description = note["description"];
        noteModel.category = note["category"];
        noteModel.isFinished = note["is_finished"];
        noteModel.isPrivate = note["is_private"];
        _noteList.add(noteModel);
      });
    });
  }

  _showSnackBarMessage(message) {
    var snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DNotes - Home"),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
            itemCount: _noteList.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // _editCategory(context, _categoryList[index].id);
                      }),
                  title: Row(children: <Widget>[
                    Text(_noteList[index].title.toString()),
                    IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () { 
                          // _deleteFormDialog(context, _categoryList[index].id); 
                        }
                    )
                  ]),
                ),
              );
            }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddNotePage()));
            getAllNotes();
            _showSnackBarMessage("Note Created successfully!");


        })
    );
  }
}
