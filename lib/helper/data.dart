import 'package:latenews/model/category_model.dart';

List<CategoryModel> getCategories() {
  List<CategoryModel> category = new List<CategoryModel>();
  CategoryModel categoryModel = new CategoryModel();

//1
  categoryModel.categoryName = "Business";
  categoryModel.imageAsset =
      'assets/business.jpg';
  category.add(categoryModel);

//2
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.imageAsset =
      'assets/entertainment.jpg';
  category.add(categoryModel);

//3
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "General";
  categoryModel.imageAsset =
      'assets/general.jpg';
  category.add(categoryModel);

//4
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Health";
  categoryModel.imageAsset =
      'assets/health.jpg';
  category.add(categoryModel);

//5
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Science";
  categoryModel.imageAsset =
      'assets/science.jpg';
  category.add(categoryModel);

//6
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.imageAsset =
      'assets/sports.jpg';
  category.add(categoryModel);

//7
  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.imageAsset =
     'assets/technology.jpg';
  category.add(categoryModel);

  return category;
}
