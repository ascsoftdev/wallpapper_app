import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/categoryModel.dart';
import 'package:wallpaper_app/views/screen/category.dart';

class CatBlock extends StatelessWidget {
  CategoryModel categoryModelData;
  CatBlock({super.key, required this.categoryModelData});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            (MaterialPageRoute(
              builder: (context) => CategoryScreen(
                  catName: categoryModelData.catName,
                  catImgUrl: categoryModelData.catImgUrl),
            )));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                  height: 50,
                  width: 100,
                  fit: BoxFit.cover,
                  categoryModelData.catImgUrl),
            ),
            Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            Positioned(
              left: 30,
              top: 15,
              child: Text(
                categoryModelData.catName,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),
      ),
    );
  }
}
