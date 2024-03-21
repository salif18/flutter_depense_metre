
class ModelCategories {
  final int? id;
  final String? categoryName;

  ModelCategories({
    required this.id,
    required this.categoryName,
  });

  factory ModelCategories.fromJson(Map<String, dynamic> json) {
    return ModelCategories(
      id: json["id"] ?? "",
      categoryName: json["name_categories"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name_categories": categoryName,
    };
  }
}
