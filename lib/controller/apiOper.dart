import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/PhotosModel.dart';
import 'package:wallpaper_app/model/categoryModel.dart';

class ApiOperations {
  static const String _apiKey =
      "BpkR2MDenyWA4VlRRiXkP6oS2uECSa6BYWpcwjIOAUn6BwrXpqLDBhym";
  static List<PhotosModel> trendingWallpaperList = [];
  static List<PhotosModel> searchWallpaperList = [];
  static List<CategoryModel> categoryList = [];
  static Future<List<PhotosModel>> getTrendingWallpapers() async {
    await http.get(
        Uri.parse("https://api.pexels.com/v1/curated?per_page=30&page=1"),
        headers: {"Authorization": _apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      photos.forEach((element) {
        trendingWallpaperList.add(PhotosModel.fromApi2App(element));
      });
    });
    return trendingWallpaperList;
  }

  static Future<List<PhotosModel>> searchWallpapers(String query) async {
    await http.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=$query&per_page=30&page=1"),
        headers: {"Authorization": _apiKey}).then((value) {
      Map<String, dynamic> jsonData = jsonDecode(value.body);
      List photos = jsonData['photos'];
      searchWallpaperList.clear();
      photos.forEach((element) {
        searchWallpaperList.add(PhotosModel.fromApi2App(element));
      });
    });
    return searchWallpaperList;
  }

  static Future<List<CategoryModel>> getCategoriesList() async {
    List cateogryName = [
      "Cars",
      "Nature",
      "Bikes",
      "Street",
      "City",
      "Flowers"
    ];
    categoryList.clear();
    cateogryName.forEach((catName) async {
      await http.get(
          Uri.parse(
              "https://api.pexels.com/v1/search?query=$catName&per_page=1&page=1"),
          headers: {"Authorization": _apiKey}).then((value) {
        Map<String, dynamic> jsonData = jsonDecode(value.body);
        List photos = jsonData['photos'];
        PhotosModel photosModel = PhotosModel.fromApi2App(photos[0]);
        categoryList.add(
            CategoryModel(catName: catName, catImgUrl: photosModel.imgSrc));
      });
    });

    return categoryList;
  }
}
