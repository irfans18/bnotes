// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:bnotes/models/note.dart';
import 'package:bnotes/services/category_sevice.dart';
import 'package:bnotes/widget/card_note.dart';
import 'package:flutter/material.dart';

class CreateUpdateNotePage extends StatefulWidget {
  final Note? noteModel;
  final bool isEdit;
  const CreateUpdateNotePage({Key? key, required this.isEdit, this.noteModel}) : super(key: key);

  @override
  _CreateUpdateNotePageState createState() => _CreateUpdateNotePageState();
}

class _CreateUpdateNotePageState extends State<CreateUpdateNotePage> {
  late List<String> _categoryList = [];

  @override
  void initState() {
    _loadCategoryName();
    // debugPrint(widget.noteModel!.category.toString()+"CU");
    super.initState();
  }

  _loadCategoryName() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategory();
    categories.forEach((category) {
        _categoryList.add(category["name"]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isEdit ? "Edit" : "New Note"),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: CardNote(
          isEdit: widget.isEdit, 
          categoryList: _categoryList,
          noteModel: widget.noteModel,
          )
      ),
    // resizeToAvoidBottomInset: false
    );
  }
}