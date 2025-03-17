class ImageUploadModel {
  // Fixed class name typo
  dynamic imageUrlPath;

  ImageUploadModel({
    // Fixed class name typo
    this.imageUrlPath,
  });

  // Fixed method name typo from 'fromJsom' to 'fromJson'
  ImageUploadModel.fromJson(Map<String, dynamic> json) {
    imageUrlPath = json['imageUrlPath'];
  }

  // Fixed method name typo from 'tojson' to 'toJson'
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['imageUrlPath'] = this.imageUrlPath;
    return data;
  }
}
