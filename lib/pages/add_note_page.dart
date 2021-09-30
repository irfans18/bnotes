// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_final_fields

import 'package:bnotes/models/category.dart';
import 'package:bnotes/services/category_sevice.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  var _selectedItem;
  var _categoryList = ["Brazil", "Tunisia", "Test"];

  var _categoryService = CategoryService();

  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _dateController = TextEditingController();
  var _categoryController = TextEditingController();

  // getAllCategories() async {
  //   _categoryList.clear();
  //   var categories = await _categoryService.readCategory();
  //   categories.forEach((category) {
  //     setState(() {
  //       var categoryModel = Category();
  //       categoryModel.name = category["name"];
  //       categoryModel.description = category["description"];
  //       categoryModel.id = category["id"];
  //       _categoryList.add(categoryModel);
  //     });
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Note"),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title),
                labelText: "Title",
                hintText: "Write the title",
              ),
            ),
                       
            DropdownSearch<String>(
              mode: Mode.MENU,
              showSelectedItems: true,
              showSearchBox: true,
              // ignore: prefer_const_literals_to_create_immutables
              items: _categoryList,
              label: "Category",
              hint: "Select Category",
              onChanged: (val) {
                _selectedItem = val;
                debugPrint(_selectedItem);
              },
              dropdownSearchDecoration: InputDecoration(
                disabledBorder: InputBorder.none,
                prefixIcon:  Icon(Icons.view_list),
                alignLabelWithHint: true
                )
              // selectedItem: _selectedItem,
            ),
            
            //
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: "Pick a date",
                // hintText: "Write a title",
              ),
            ),
            TextField(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              minLines: 5,
              maxLines: 10,
              decoration: InputDecoration(
                labelText: "Description",
                hintText: "Write the description",
              ),
            ),
            ElevatedButton(
              onPressed: (){},
              child: Text("Save"))
          ],
        ),
      ),
    // resizeToAvoidBottomInset: false
    );
  }
}