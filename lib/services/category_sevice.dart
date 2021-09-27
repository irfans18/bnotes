// @@ -0,0 +1,31 @@
import 'package:bnotes/models/category.dart';
import 'package:bnotes/repo/repository.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

class CategoryService {
  late Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  // create data
  saveCategory(Category category) async {
    // debugPrint("cServices : ${category.name}, ${category.description}");
    // debugPrint("cServices2----- : ${category.categoryMap()}");
    return await _repository.insertTable("categories", category.categoryMap());
  }

  // raad data
  readCategory() async {
    return await _repository.readData("categories");
  }

  readCategoryById(categoryId) async {
    return await _repository.readDataById("categories", categoryId);
  }

  updateCategory(Category category) async {
    debugPrint("CS : ${category.categoryMap()} ");
    return await _repository.updateData("categories", category.categoryMap());
  }
}
