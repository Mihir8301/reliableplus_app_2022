class AdminLoginModel {
  String id = "", name = "", email = "", pass = "";

  AdminLoginModel({
    this.id = "",
    this.name = "",
    this.pass = "",
    this.email = "",
  });

  AdminLoginModel.fromMap(Map<String, dynamic> map) {
    id = map['id']?.toString() ?? "";
    name = map['name']?.toString() ?? "";
    pass = map['pass']?.toString() ?? "";
    email = map['email']?.toString() ?? "";
  }

  void updateFromMap(Map<String, dynamic> map) {
    id = map['id']?.toString() ?? "";
    name = map['name']?.toString() ?? "";
    pass = map['pass']?.toString() ?? "";
    email = map['email']?.toString() ?? "";
  }

  Map<String, dynamic> tomap() {
    return {
      "id" : id,
      "name" : name,
      "pass" : pass,
      "email" : email,
    };
  }

  @override
  String toString() {
    return "id:${id}, name:$name, pass:$pass, email:$email";
  }
}