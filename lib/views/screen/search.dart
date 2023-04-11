import 'package:flutter/material.dart';
import 'package:wallpaper_app/controller/apiOper.dart';
import 'package:wallpaper_app/model/PhotosModel.dart';
import 'package:wallpaper_app/views/widget/CustomAppBar.dart';
import 'package:wallpaper_app/views/widget/SearchBar.dart';

import 'fullScreen.dart';

class SearchScreen extends StatefulWidget {
  String query;
  SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  static List<PhotosModel> photosModelList = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getSearchWallpapers();
  }

  getSearchWallpapers() async {
    photosModelList = await ApiOperations.searchWallpapers(widget.query);
    setState(() {
      this.isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomAppBar(
          word1: "WallPaper",
          word2: "Guru",
        ),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SearchBar(),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    margin: const EdgeInsets.only(
                      top: 5,
                    ),
                    height: 700,
                    child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisExtent: 250,
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5),
                        itemCount: photosModelList.length,
                        itemBuilder: ((context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullScreen(
                                            imageUrl: photosModelList[index]
                                                .imgSrc)));
                              },
                              child: Container(
                                height: 250,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.amberAccent,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                      height: 250,
                                      width: 50,
                                      fit: BoxFit.cover,
                                      photosModelList[index].imgSrc),
                                ),
                              ),
                            ))),
                  )
                ],
              ),
            ),
    );
  }
}
