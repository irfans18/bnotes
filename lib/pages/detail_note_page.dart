import 'package:bnotes/helper/edit_menu.dart';
import 'package:bnotes/models/note.dart';
import 'package:bnotes/pages/home_page.dart';
import 'package:bnotes/services/note_service.dart';
import 'package:flutter/material.dart';

class DetailNotePage extends StatefulWidget {
  final int? id;
  const DetailNotePage({ Key? key, @required this.id }) : super(key: key);

  @override
  _DetailNotePageState createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  // ignore: prefer_final_fields
  late var _noteModel = Note();

  final _noteService = NoteService();

  @override
  void initState(){
    super.initState();
    _getNoteDetail();
  }

  _getNoteDetail() async {
    var noteService = await _noteService.readNoteById(widget.id);
    setState(() {
      _noteModel.id = noteService[0]["id"];
      _noteModel.title = noteService[0]["title"];
      _noteModel.description = noteService[0]["description"];
      _noteModel.dateTime = noteService[0]["date_time"];
      _noteModel.category = noteService[0]["category"];
      _noteModel.isFinished = noteService[0]["is_finished"];
      _noteModel.isPrivate = noteService[0]["is_private"];
    });
    debugPrint(_noteModel.id.toString());
  }

  _deleteFormDialog(BuildContext context, noteId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: const Text("Are you sure want to delete?"),
            actions: <Widget>[
              TextButton(
                  child: const Text("Cancel"),
                  style: TextButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: const Text("Delete"),
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.red),
                  onPressed: () async {
                    var result =
                        await _noteService.deleteNote(noteId);

                    if (result > 0) {
                      debugPrint("DELETE : " + result.toString());
                      Navigator.pop(context);
                      _showSnackBarMessage(const Text("Note deleted!"));
                      Navigator.of(context).push(MaterialPageRoute (builder: (context)=> const HomePage()));
                    }
                  }),
            ],
          );
        });
  }

  _choiceAction(String choice){
    debugPrint(choice);
    if (choice == "Delete") _deleteFormDialog(context, _noteModel.id);
  }

  _showSnackBarMessage(message) {
    var snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Detail Page"),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0.0),
            child: InkWell(
              onTap: (){
                _noteService.copyNoteDetail(_noteModel.title, _noteModel.dateTime, _noteModel.description);
                _showSnackBarMessage(const Text("Copied in clipboard"));
              },
              child: const Icon(Icons.copy),              
            )
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (BuildContext context){
                return EditMenu.menuItems.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                    );
                }).toList();
              }, 
              onSelected: _choiceAction,    
            )
            
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListTile(
          title: Text(
            _noteModel.title.toString(), 
            style: const TextStyle(fontWeight: FontWeight.w400)
          ),
          subtitle: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
            const SizedBox(height: 5),
            Align(
              child: Text(_noteModel.dateTime.toString(), textAlign: TextAlign.end),
              alignment: Alignment.centerRight,
            ),
            const Divider(),
            Text(_noteModel.description.toString(), textAlign: TextAlign.start),
          ]),
          // isThreeLine: true,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}