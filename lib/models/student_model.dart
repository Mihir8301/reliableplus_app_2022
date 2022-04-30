class StudentModel {
  String enrollment_id = "", name = "", branch = "", email = "", password = "", phone = "", image = "";
  DateTime? createdTime;
  bool training_completed = false;

  StudentModel({
    this.enrollment_id = "",
    this.name = "",
    this.branch = "",
    this.email = "",
    this.password = "",
    this.phone = "",
    this.image = "",
    this.createdTime,
    this.training_completed = false,
  });

  StudentModel.fromMap(Map<String, dynamic> map) {
    enrollment_id = map['enrollment_id']?.toString() ?? "";
    name = map['name']?.toString() ?? "";
    branch = map['branch']?.toString() ?? "";
    email = map['email']?.toString() ?? "";
    password = map['password']?.toString() ?? "";
    phone = map['phone']?.toString() ?? "";
    image = map['image']?.toString() ?? "";
    training_completed = map['training_completed'] ?? false;

    try {
      String timeString = (map['createdTime']?.toString() ?? "");
      if(timeString.isNotEmpty) {
        createdTime = DateTime.tryParse(timeString);
      }
    }
    catch(e) {}
  }

  void updateFromMap(Map<String, dynamic> map) {
    enrollment_id = map['enrollment_id']?.toString() ?? "";
    name = map['name']?.toString() ?? "";
    branch = map['branch']?.toString() ?? "";
    email = map['email']?.toString() ?? "";
    password = map['password']?.toString() ?? "";
    phone = map['phone']?.toString() ?? "";
    image = map['image']?.toString() ?? "";
    training_completed = map['training_completed'] ?? false;

    try {
      String timeString = (map['createdTime']?.toString() ?? "");
      if(timeString.isNotEmpty) {
        createdTime = DateTime.tryParse(timeString);
      }
    }
    catch(e) {}
  }

  Map<String, dynamic> tomap() {
    return {
      "enrollment_id" : enrollment_id,
      "name" : name,
      "branch" : branch,
      "email" : email,
      "password" : password,
      "phone" : phone,
      "image" : image,
      "training_completed" : training_completed,
      "createdTime" : createdTime?.toString(),
    };
  }

  @override
  String toString() {
    return "enrollment_id:${enrollment_id}, name:$name, branch:${branch}, email:$email, password:${password}, phone:${phone}, "
        "image:$image, training_completed:${training_completed}, createdTime:${createdTime}";
  }
}