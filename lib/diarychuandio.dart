import 'package:diary/diarychuandio2.dart';
import 'package:dio/dio.dart';


Future<void> createJournalGroup(String token) async {
  Dio dio = Dio();
  String url = "http://mambaout.xyz/createJournalGroup";
  dio.options.baseUrl = url;
  dio.options.headers['token'] = token;
    Map<String,dynamic> map = Map();
    map['journalGroupName']="";
  Response response = await dio.post(url,data: map);
print('aassssaaaa');
print(response.data);
}


class GetDiaryList{
 var diaryslist = DiarysList();
Future<void> getofDiarys(String token,int page) async {
  Dio dio = Dio();
  String url = "http://mambaout.xyz/getJournalGroups";
  dio.options.baseUrl = url;
  dio.options.headers['token'] = token;
  Map<String,dynamic> map = Map();
    map['page']=page;
    map['pageSize']=100;
  Response response = await dio.get(url,queryParameters: map);
 diaryslist = DiarysList.fromJson(response.data);

}

}
class DiarysList {
    int? code;
    String? message;
    Data? data;

    DiarysList({this.code, this.message, this.data});

    DiarysList.fromJson(Map<String, dynamic> json) {
        code = json["code"];
        message = json["message"];
        data = json["data"] == null ? null : Data.fromJson(json["data"]);
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["code"] = code;
        _data["message"] = message;
        if(data != null) {
            _data["data"] = data?.toJson();
        }
        return _data;
    }
}

class Data {
    int? total;
    List<Records>? records;

    Data({this.total, this.records});

    Data.fromJson(Map<String, dynamic> json) {
        total = json["total"];
        records = json["records"] == null ? null : (json["records"] as List).map((e) => Records.fromJson(e)).toList();
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["total"] = total;
        if(records != null) {
            _data["records"] = records?.map((e) => e.toJson()).toList();
        }
        return _data;
    }
}

class Records {
    int? journalGroupId;
    String? journalGroupName;
    String? createdAt;
    String? modifiedAt;
    int? journalCount;

    Records({this.journalGroupId, this.journalGroupName, this.createdAt, this.modifiedAt, this.journalCount});

    Records.fromJson(Map<String, dynamic> json) {
        journalGroupId = json["journalGroupId"];
        journalGroupName = json["journalGroupName"];
        createdAt = json["createdAt"];
        modifiedAt = json["modifiedAt"];
        journalCount = json["journalCount"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["journalGroupId"] = journalGroupId;
        _data["journalGroupName"] = journalGroupName;
        _data["createdAt"] = createdAt;
        _data["modifiedAt"] = modifiedAt;
        _data["journalCount"] = journalCount;
        return _data;
    }
}
class GetDiaryofDiarys
{
   var diarys=Diarys();
Future<void> getofDiarys(String token,int diaryChuanID) async {
  Dio dio = Dio();
  String url = "http://mambaout.xyz/getJournalsInJournalGroup";
  dio.options.baseUrl = url;
  dio.options.headers['token'] = token;
Map<String,dynamic> map = Map();
    map['journalGroupId']=diaryChuanID;
  Response response = await dio.get(url,data:map);
  diarys =  await Diarys.fromJson(response.data);
  print('sassasas');

}
}