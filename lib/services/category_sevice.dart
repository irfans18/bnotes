import 'package:bnotes/models/category.dart';
import 'package:bnotes/repo/repository.dart';

class CategoryService {
  late Repository _repository;

  CategoryService() {
    _repository = Repository();
  }

  // create data
  saveCategory(Category category) async {
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
    return await _repository.updateData("categories", category.categoryMap());
  }

  deleteCategory(categoryId) async {
    return await _repository.deleteData("categories", categoryId);
  }
}
