// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  var _selectedItem;
  var _category;
  
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
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title),
                labelText: "Title",
                hintText: "Write the title",
              ),
            ),
            DropdownButtonFormField(
              value: _selectedItem,
              items: _category,
              hint: Text("Category"),
              onChanged: (value) {
                setState(() {
                  _selectedItem = value;
                });
              },
              // decoration: InputDecoration(
              //   prefixIcon: Icon(Icons.view_list),
              //   labelText: "Category",
              //   hintText: "Write a category",
              // ),
            ),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today),
                labelText: "Pick a date",
                // hintText: "Write a title",
              ),
            ),
            TextField(
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