class DailyAttendenceModel {
  String attandance = "";
  DateTime? datetime;

  DailyAttendenceModel({
    this.attandance = "",
    this.datetime,
  });

  DailyAttendenceModel.fromMap(Map<String, dynamic> map) {
    attandance = map['attandance']?.toString() ?? "";
    try {
      String timeString = (map['datetime']?.toString() ?? "");
      if(timeString.isNotEmpty) {
        datetime = DateTime.tryParse(timeString);
      }
    }
    catch(e) {}
  }

  void updateFromMap(Map<String, dynamic> map) {
    attandance = map['attandance']?.toString() ?? "";
    try {
      String timeString = (map['datetime']?.toString() ?? "");
      if(timeString.isNotEmpty) {
        datetime = DateTime.tryParse(timeString);
      }
    }
    catch(e) {}
  }

  Map<String, dynamic> tomap() {
    return {
      "attandance" : attandance,
      "datetime" : datetime?.toString(),
    };
  }

  @override
  String toString() {
    return "attandance:${attandance}, datetime:${datetime}";
  }
}