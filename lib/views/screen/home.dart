import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_app/controller/apiOper.dart';
import 'package:wallpaper_app/model/PhotosModel.dart';
import 'package:wallpaper_app/model/categoryModel.dart';
import 'package:wallpaper_app/views/screen/fullScreen.dart';
import 'package:wallpaper_app/views/widget/CatBlock.dart';
import 'package:wallpaper_app/views/widget/CustomAppBar.dart';
import 'package:wallpaper_app/views/widget/SearchBar.dart';
import 'package:cached_network_image/cached_network_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  List<PhotosModel> trendingWallpapers = [];
  late TabController _controller;
  List<CategoryModel> categoryWallpapersList = [];

  getTrendingWallpaperList() async {
    categoryWallpapersList = await ApiOperations.getCategoriesList();
    trendingWallpapers = await ApiOperations.getTrendingWallpapers();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTrendingWallpaperList();
    _controller = TabController(length: 6, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomAppBar(
          word1: "WallPaper",
          word2: "Guru",
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: SearchBar(),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              child: SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryWallpapersList.length,
                  itemBuilder: ((context, index) => CatBlock(
                        categoryModelData: categoryWallpapersList[index],
                      )),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              height: 700,
              child: GridView.builder(
                  physics: BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisExtent: 250,
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemCount: trendingWallpapers.length,
                  itemBuilder: ((context, index) => GridTile(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FullScreen(
                                        imageUrl:
                                            trendingWallpapers[index].imgSrc)));
                          },
                          child: Hero(
                            tag: trendingWallpapers[index].imgSrc,
                            child: Container(
                              height: 250,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amberAccent,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: trendingWallpapers[index].imgSrc,
                                  placeholder: (context, url) =>
                                      const CircularProgressIndicator(),
                                  cacheManager: CacheManager(Config(
                                    'customCacheKey',
                                    stalePeriod: const Duration(days: 1),
                                  )),
                                  errorWidget: (context, url, error) =>
                                      const Icon(
                                    Icons.error,
                                    size: 100,
                                    color: Colors.red,
                                  ),
                                  height: 250,
                                  width: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
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
