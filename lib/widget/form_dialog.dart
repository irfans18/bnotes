import 'package:bnotes/models/category.dart';
import 'package:bnotes/services/category_sevice.dart';
import 'package:flutter/material.dart';

class FormDialog extends StatefulWidget {
  final bool isEdit;
  final int? id;
  const FormDialog({Key? key, required this.isEdit, this.id}) : super(key: key);

  @override
  State<FormDialog> createState() => _FormDialogState();
}

class _FormDialogState extends State<FormDialog> {
  final _editCategoryNameController = TextEditingController();

  final _editCategoryDescriptionController = TextEditingController();

  final _category = Category();

  final _categoryService = CategoryService();

  var category;

  @override
  initState(){
    if (widget.isEdit) _editCategory(context, widget.id);
    super.initState();
  }

  _editCategory(BuildContext context, categoryId) async {
    category = await _categoryService.readCategoryById(categoryId);
    _editCategoryNameController.text = category[0]["name"] ?? "No Name";
    _editCategoryDescriptionController.text = category[0]["description"] ?? "No Description";
  }

  _saveCategory() {
    _category.name = _editCategoryNameController.text;
    _category.description = _editCategoryDescriptionController.text;

    return _categoryService.saveCategory(_category);
  }

  _updateCategory() {
    _category.id = widget.id;
    _category.name = _editCategoryNameController.text;
    _category.description = _editCategoryDescriptionController.text;

    return _categoryService.updateCategory(_category);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEdit ? "Edit Category" : "Add Category"), //$title
      actions: <Widget>[
        TextButton(
            child: const Text("Cancel"),
            style: TextButton.styleFrom(primary: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            }),
        TextButton(
            child: Text(widget.isEdit ? "Update" : "Save"),
            style: TextButton.styleFrom(
                primary: Colors.white, backgroundColor: Colors.blue),
            onPressed: () async {
              // ignore: prefer_typing_uninitialized_variables
              late var result;
              if (widget.isEdit) {
                result = await _updateCategory();
              } else {
                result = await _saveCategory();
              }

              if (result > 0) {
                Navigator.pop(context);
              }
            }),
      ],
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _editCategoryNameController,
              decoration: const InputDecoration(
                hintText: "Write a category",
                labelText: "Category",
              ),
            ),
            TextField(
              controller: _editCategoryDescriptionController,
              decoration: const InputDecoration(
                hintText: "Write a description",
                labelText: "Description",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
