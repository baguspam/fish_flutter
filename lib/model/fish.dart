import 'dart:convert';

List<FishModel> fishModelFromJson(String str){
  return List<FishModel>.from(json.decode(str).map((x) => FishModel.fromJson(x)));
}

String fishModelToJson(List<FishModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FishModel {
  final int id;
  final String title;
  final String category;
  final String description;
  final String photo;
  final String createdAt;

  FishModel({
    this.id,
    this.title,
    this.category,
    this.description,
    this.photo,
    this.createdAt,
  });

  factory FishModel.fromJson(Map<String, dynamic> json) => FishModel(
      id: json["id"],
      title: json["nama_ikan"],
      category: json["jenis"],
      description: json["deskripsi"],
      photo: json["foto"],
      createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "jenis": category,
    "deskripsi": description,
    "foto": photo,
    "created_at": createdAt,
  };

}

