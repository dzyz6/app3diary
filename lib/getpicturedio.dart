class Getpicture {
  int? code;
  String? message;
  List<Data>? data;

  Getpicture({this.code, this.message, this.data});

  Getpicture.fromJson(Map<String, dynamic> json) {
    code = json["code"];
    message = json["message"];
    data = json["data"] == null ? null : (json["data"] as List).map((e) => Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["code"] = code;
    _data["message"] = message;
    if(data != null) {
      _data["data"] = data?.map((e) => e.toJson()).toList();
    }
    return _data;
  }
}

class Data {
  String? pictureId;
  String? pictureUrl;

  Data({this.pictureId, this.pictureUrl});

  Data.fromJson(Map<String, dynamic> json) {
    pictureId = json["pictureId"];
    pictureUrl = json["pictureUrl"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["pictureId"] = pictureId;
    _data["pictureUrl"] = pictureUrl;
    return _data;
  }
}