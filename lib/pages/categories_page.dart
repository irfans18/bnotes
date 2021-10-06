// ignore_for_file: use_key_in_widget_constructors, prefer_final_fields, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:bnotes/models/category.dart';
import 'package:bnotes/pages/home_page.dart';
import 'package:bnotes/services/category_sevice.dart';
import 'package:bnotes/widget/form_dialog.dart';
import 'package:flutter/material.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  var _categoryService = CategoryService();

  final List<Category> _categoryList = [];

  var category;

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
          return FormDialog(isEdit: false);
        });
  }

  _editFormDialog(BuildContext context, categoryId) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          return FormDialog(isEdit: true, id: categoryId);
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
                    onPressed: () async {
                      await _editFormDialog(context, _categoryList[index].id);
                      getAllCategories();
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
          onPressed: () async{
            _addFormDialog(context);
            getAllCategories();
      })
    );
  }
}


