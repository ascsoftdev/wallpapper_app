class CategoryModel {
  String catName;
  String catImgUrl;

  CategoryModel({required this.catName, required this.catImgUrl});

  static CategoryModel fromApi2App(Map<String, dynamic> catMap) {
    return CategoryModel(
        catName: catMap["CategoryName"], catImgUrl: catMap["imgUrl"]);
  }
}
