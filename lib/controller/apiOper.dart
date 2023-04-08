import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/model/PhotosModel.dart';

class ApiOperations {
  static const String _apiKey =
      "BpkR2MDenyWA4VlRRiXkP6oS2uECSa6BYWpcwjIOAUn6BwrXpqLDBhym";
  static List<PhotosModel> trendingWallpaperList = [];
  static List<PhotosModel> searchWallpaperList = [];
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
}
