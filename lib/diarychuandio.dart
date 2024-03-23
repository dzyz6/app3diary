import 'package:dio/dio.dart';

class GetDiaryofDiarys
{
  var diaryChuanID;
  var token;
  var diarys;
    GetDiaryofDiarys({
        required this.token,
        required this.diaryChuanID,
    });
    
Future<void> getofDiarys() async {
  Dio dio = Dio();
  String url = "http://8.130.98.175/getJournalsInJournalGroup";
  dio.options.baseUrl = url;
  dio.options.headers['token'] = this.token;
  Response response = await dio.get(url);
  diarys = Diarys.fromJson(response.data);
}




}







class Diarys {
    Diarys({
        required this.code,
        required this.message,
        required this.data,
    });

    final int? code;
    final String? message;
    final List<Datum> data;

    factory Diarys.fromJson(Map<String, dynamic> json){ 
        return Diarys(
            code: json["code"],
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        );
    }

}

class Datum {
    Datum({
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

    final int? journalId;
    final String? journalTitle;
    final DateTime? createdAt;
    final DateTime? modifiedAt;
    final String? location;
    final int? sharedCount;
    final int? journalGroupIdAt;
    final String? journalText;
    final int? topJournal;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            journalId: json["journalId"],
            journalTitle: json["journalTitle"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            modifiedAt: DateTime.tryParse(json["modifiedAt"] ?? ""),
            location: json["location"],
            sharedCount: json["sharedCount"],
            journalGroupIdAt: json["journalGroupIdAt"],
            journalText: json["journalText"],
            topJournal: json["topJournal"],
        );
    }

}
