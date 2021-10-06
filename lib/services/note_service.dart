import 'package:bnotes/models/note.dart';
import 'package:bnotes/repo/repository.dart';
import 'package:flutter/services.dart';

class NoteService {
  late Repository _repository;

  NoteService(){
    _repository = Repository();
  }

  saveNote(Note note) async {
    return await _repository.insertTable("notes", note.noteMap());
  }

  readNote() async {
    return await _repository.readData("notes");
  }

  readNoteById(noteId) async {
    return await _repository.readDataById("notes", noteId);
  }

  // updateCategory(Category category) async {
  //   // debugPrint("CS : ${category.categoryMap()} ");
  //   return await _repository.updateData("categories", category.categoryMap());
  // }

  deleteNote(noteId) async {
    // debugPrint("CS : ${category.categoryMap()} ");
    return await _repository.deleteData("notes", noteId);
  }

  copyNoteDescription(message){
    Clipboard.setData(ClipboardData(text: message.toString()));
  }
  
  copyNoteDetail(title, date, desc){
    Clipboard.setData(ClipboardData(
      text: " ${title.toString()} \n ${date.toString()} \n ${desc.toString()}"));
  }
}