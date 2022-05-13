class FeedbackModel {
  String id = "",
      name = "",
      feedback = "";
  double rating = 5;
  DateTime createdTime = DateTime.now();

  FeedbackModel({
    this.id = "",
    this.name = "",
    this.feedback = "",
    this.rating = 0,
  });

  FeedbackModel.fromMap(Map<String, dynamic> map) {
    id = map['id']?.toString() ?? "";
    name = map['name']?.toString() ?? "";
    feedback = map['feedback']?.toString() ?? "";
    rating = double.tryParse(map['rating']?.toString() ?? "0") ?? 0;

    createdTime = DateTime.now();
    try {
      String timeString = (map['createdTime']?.toString() ?? "");
      if (timeString.isNotEmpty) {
        createdTime = DateTime.tryParse(timeString) ?? DateTime.now();
      }
    }
    catch (e) {}
  }

  void updateFromMap(Map<String, dynamic> map) {
    id = map['id']?.toString() ?? "";
    name = map['name']?.toString() ?? "";
    feedback = map['feedback']?.toString() ?? "";
    rating = double.tryParse(map['rating']?.toString() ?? "0") ?? 0;

    createdTime = DateTime.now();
    try {
      String timeString = (map['createdTime']?.toString() ?? "");
      if (timeString.isNotEmpty) {
        createdTime = DateTime.tryParse(timeString) ?? DateTime.now();
      }
    }
    catch (e) {}
  }

  Map<String, dynamic> tomap() {
    return {
      "id": id,
      "name": name,
      "feedback": feedback,
      "rating": rating,
      "createdTime": createdTime.toString(),
    };
  }

  @override
  String toString() {
    return "id:${id}, name:$name, feedback:$feedback, rating:$rating, createdTime:${createdTime}";
  }
}