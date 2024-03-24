class Get {
  int? code;
  String? message;
  Data? data;

  Get({
    this.code,
    this.message,
    this.data,
  });

  factory Get.fromJson(Map<String, dynamic> json) => Get(
    code: json["code"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data!.toJson(),
  };
}

class Data {
  int total;
  List<Record> records;

  Data({
    required this.total,
    required this.records,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    total: json["total"],
    records: List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "records": List<dynamic>.from(records.map((x) => x.toJson())),
  };
}

class Record {
  int journalId;
  String journalTitle;
  String createdAt;
  String modifiedAt;
  String location;
  int sharedCount;
  int journalGroupIdAt;
  String journalText;
  int topJournal;

  Record({
    required this.journalId,
    required this.journalTitle,
    required this.createdAt,
    required this.modifiedAt,
    required this.location,
    required this.sharedCount,
    required this.journalGroupIdAt,
    required this.journalText,
    required this.topJournal,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    journalId: json["journalId"],
    journalTitle: json["journalTitle"],
    createdAt: json["createdAt"],
    modifiedAt: json["modifiedAt"],
    location: json["location"],
    sharedCount: json["sharedCount"],
    journalGroupIdAt: json["journalGroupIdAt"],
    journalText: json["journalText"],
    topJournal: json["topJournal"],
  );

  Map<String, dynamic> toJson() => {
    "journalId": journalId,
    "journalTitle": journalTitle,
    "createdAt": createdAt,
    "modifiedAt": modifiedAt,
    "location": location,
    "sharedCount": sharedCount,
    "journalGroupIdAt": journalGroupIdAt,
    "journalText": journalText,
    "topJournal": topJournal,
  };
}










class Editor {
  int? code;
  String? message;
  String? data;

  Editor({this.code, this.message, this.data});

  Editor.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}









