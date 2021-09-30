// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_final_fields

// import 'package:bnotes/models/category.dart';
import 'package:bnotes/services/category_sevice.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

class AddNotePage extends StatefulWidget {
  @override
  _AddNotePageState createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late var _selectedItem;
  late List<String> _categoryList = [];


  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();
  var _dateController = TextEditingController();

  DateTime _dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadCategoryName();
  }

  _loadCategoryName() async {
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategory();
    categories.forEach((category) {
      // setState(() {
        _categoryList.add(category["name"]);
      // });
    });
  }

  _selectedDate(BuildContext context) async {
    var _pickDate = await showDatePicker(
      context: context, 
      initialDate: _dateTime, 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100)
    );

    if (_pickDate != null){
      setState(() {
        // _dateController.text = DateFormat("d MMMM yyyy").format(_pickDate);
        _dateController.text = DateFormat("yyyy-MM-dd").format(_pickDate);
        debugPrint(_pickDate.toString());
      });
    }
  }

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
                )
              // selectedItem: _selectedItem,
            ),
            
            //
            TextField(
              controller: _dateController,
              decoration: InputDecoration(
                // prefixIcon: Icon(Icons.calendar_today),
                prefixIcon: InkWell(
                  child: Icon(Icons.calendar_today),
                  onTap: (){
                    _selectedDate(context);
                  }),
                labelText: "Pick a date",
                hintText: "YYYY-MM-DD",
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
              child: Text("Save"),
              onPressed: (){},
              )
          ],
        ),
      ),
    // resizeToAvoidBottomInset: false
    );
  }
}