import 'package:bnotes/models/note.dart';
import 'package:bnotes/repo/repository.dart';

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

  // readCategoryById(categoryId) async {
  //   return await _repository.readDataById("categories", categoryId);
  // }

  // updateCategory(Category category) async {
  //   // debugPrint("CS : ${category.categoryMap()} ");
  //   return await _repository.updateData("categories", category.categoryMap());
  // }

  deleteNote(noteId) async {
    // debugPrint("CS : ${category.categoryMap()} ");
    return await _repository.deleteData("notes", noteId);
  }
}