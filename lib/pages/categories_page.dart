// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:bnotes/models/category.dart';
import 'package:bnotes/pages/home_page.dart';
import 'package:bnotes/services/category_sevice.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  var _addCategoryNameController = TextEditingController();
  var _addCategoryDescriptionController = TextEditingController();
  var _editCategoryNameController = TextEditingController();
  var _editCategoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  List<Category> _categoryList = [];

  var category;

  // final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    getAllCategories();
  }

  getAllCategories() async {
    _categoryList.clear();
    var categories = await _categoryService.readCategory();
    categories.forEach((category) {
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category["name"];
        categoryModel.description = category["description"];
        categoryModel.id = category["id"];
        _categoryList.add(categoryModel);
      });
    });
  }

  _addFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: Text("Add Category"),
            actions: <Widget>[
              TextButton(
                  child: Text("Cancel"),
                  style: TextButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Save"),
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.blue),
                  onPressed: () async {
                    
                    var result = await _saveCategory();
                    if (result > 0) {
                      // debugPrint(result);
                      Navigator.pop(context);
                      getAllCategories();
                    }
                  }),
            ],
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _addCategoryNameController,
                    decoration: InputDecoration(
                      hintText: "Write a category",
                      labelText: "Category",
                    ),
                  ),
                  TextField(
                    controller: _addCategoryDescriptionController,
                    decoration: InputDecoration(
                      hintText: "Write a description",
                      labelText: "Description",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editCategoryNameController.text = category[0]["name"] ?? "No Name";
      _editCategoryDescriptionController.text =
          category[0]["description"] ?? "No Description";
    });
    _editFormDialog(context);
  }

  _editFormDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: Text("Edit Category"),
            actions: <Widget>[
              TextButton(
                  child: Text("Cancel"),
                  style: TextButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Update"),
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.blue),
                  onPressed: () async {
                    var result = await _updateCategory();

                    if (result > 0) {
                      //   debugPrint(result);
                      Navigator.pop(context);
                      _showSnackBarMessage(Text("Category was updated!"));
                      getAllCategories();
                    }
                  }),
            ],
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _editCategoryNameController,
                    decoration: InputDecoration(
                      hintText: "Write a category",
                      labelText: "Category",
                    ),
                  ),
                  TextField(
                    controller: _editCategoryDescriptionController,
                    decoration: InputDecoration(
                      hintText: "Write a description",
                      labelText: "Description",
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _deleteFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return AlertDialog(
            title: Text("Are you sure want to delete?"),
            actions: <Widget>[
              TextButton(
                  child: Text("Cancel"),
                  style: TextButton.styleFrom(primary: Colors.grey),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              TextButton(
                  child: Text("Delete"),
                  style: TextButton.styleFrom(
                      primary: Colors.white, backgroundColor: Colors.red),
                  onPressed: () async {
                    var result =
                        await _categoryService.deleteCategory(categoryId);

                    if (result > 0) {
                      debugPrint("DELETE : " + result.toString());
                      Navigator.pop(context);
                      _showSnackBarMessage(Text("Category was deleted!"));
                      getAllCategories();
                    }
                  }),
            ],
          );
        });
  }

  _showSnackBarMessage(message) {
    var snackBar = SnackBar(content: message);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _saveCategory() {
    _category.name = _addCategoryNameController.text.toString();
    _category.description = _addCategoryDescriptionController.text.toString();

    return _categoryService.saveCategory(_category);
  }

  _updateCategory(){
  _category.id = category[0]["id"];
  _category.name = _editCategoryNameController.text;
  _category.description = _editCategoryDescriptionController.text;

  return _categoryService.updateCategory(_category);
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _globalKey,
      appBar: AppBar(
        leading: TextButton(
            child: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => HomePage()))
                }),
        title: Text("Categories"),
      ),
      body: ListView.builder(
          itemCount: _categoryList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _editCategory(context, _categoryList[index].id);
                    }),
                title: Row(children: <Widget>[
                  Text(_categoryList[index].name.toString()),
                  IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _deleteFormDialog(context, _categoryList[index].id);
                      })
                ]),
              ),
            );
      }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            _addFormDialog(context);
      })
    );
  }
}


