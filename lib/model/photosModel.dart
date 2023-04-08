class PhotosModel {
  String name;
  String imgSrc;

  PhotosModel({required this.name, required this.imgSrc});

  static PhotosModel fromApi2App(Map<String, dynamic> photoMap) {
    return PhotosModel(
        name: photoMap["photographer"], imgSrc: (photoMap["src"])["portrait"]);
  }
}
