// ignore_for_file: prefer_const_constructors

import 'package:bnotes/pages/detail_note_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:bnotes/helper/drawer_navigation.dart';
import 'package:bnotes/models/note.dart';
import 'package:bnotes/pages/cu_note_page.dart';
import 'package:bnotes/services/note_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Note> _noteList;
  final _noteService = NoteService();

  @override
  void initState() {
    super.initState();
    getAllNotes();
  }

  getAllNotes() async {
    _noteList = [];
    var noteService = await _noteService.readNote();
    noteService.forEach((note) {
      setState(() {
        var noteModel = Note();
        noteModel.id = note["id"];
        noteModel.title = note["title"];
        noteModel.description = note["description"];
        noteModel.dateTime = note["date_time"];
        // noteModel.category = note["category"];
        // noteModel.isFinished = note["is_finished"];
        // noteModel.isPrivate = note["is_private"];
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
        title: Text("Notes - Home"),
      ),
      drawer: DrawerNavigation(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
        child: StaggeredGridView.countBuilder(
            crossAxisCount: 2,
            itemCount: _noteList.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5,
                child: ListTile(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            DetailNotePage(id: _noteList[index].id)));
                    getAllNotes();
                  },
                  onLongPress: () {
                    _noteService.copyNoteDescription(
                        _noteList[index].description.toString());
                    _showSnackBarMessage(Text("Copied succesfully"));
                    debugPrint(_noteList[index].id.toString());
                  },
                  title: Text(_noteList[index].title.toString()),
                  subtitle: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(_noteList[index].dateTime.toString(),
                            textAlign: TextAlign.start),
                        SizedBox(height: 5),
                        Text(
                          _noteList[index].description.toString(),
                          textAlign: TextAlign.start,
                          maxLines: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
                  isThreeLine: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
              );
            },
            staggeredTileBuilder: (index) {
              return StaggeredTile.count(1, index.isEven ? 1.2 : 1.5);
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CreateUpdateNotePage(
                      isEdit: false,
                  )
                ));
            getAllNotes();
          }),
      // resizeToAvoidBottomInset: false
    );
  }
}
