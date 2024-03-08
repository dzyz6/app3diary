// class Getjourney {
//   int code;
//   String message;
//   Data data;
//
//   Getjourney({this.code, this.message, this.data});
//
//   Getjourney.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     message = json['message'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     return data;
//   }
// }
//
// class Data {
//   int total;
//   List<Records> records;
//
//   Data({this.total, this.records});
//
//   Data.fromJson(Map<String, dynamic> json) {
//     total = json['total'];
//     if (json['records'] != null) {
//       records = new List<Records>();
//       json['records'].forEach((v) {
//         records.add(new Records.fromJson(v));
//       });
//     }
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['total'] = this.total;
//     if (this.records != null) {
//       data['records'] = this.records.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }
//
// class Records {
//   int journalId;
//   String journalTitle;
//   String createdAt;
//   String modifiedAt;
//   String location;
//   int sharedCount;
//   int journalGroupIdAt;
//   String journalText;
//   int topJournal;
//
//   Records(
//       {required this.journalId,
//         required this.journalTitle,
//         required this.createdAt,
//         required this.modifiedAt,
//         required this.location,
//         required this.sharedCount,
//         required this.journalGroupIdAt,
//         required this.journalText,
//         required this.topJournal});
//
//   Records.fromJson(Map<String, dynamic> json) {
//     journalId = json['journalId'];
//     journalTitle = json['journalTitle'];
//     createdAt = json['createdAt'];
//     modifiedAt = json['modifiedAt'];
//     location = json['location'];
//     sharedCount = json['sharedCount'];
//     journalGroupIdAt = json['journalGroupIdAt'];
//     journalText = json['journalText'];
//     topJournal = json['topJournal'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['journalId'] = this.journalId;
//     data['journalTitle'] = this.journalTitle;
//     data['createdAt'] = this.createdAt;
//     data['modifiedAt'] = this.modifiedAt;
//     data['location'] = this.location;
//     data['sharedCount'] = this.sharedCount;
//     data['journalGroupIdAt'] = this.journalGroupIdAt;
//     data['journalText'] = this.journalText;
//     data['topJournal'] = this.topJournal;
//     return data;
//   }
// }
//
//
//
//










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