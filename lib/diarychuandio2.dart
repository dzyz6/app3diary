class Diarys {
    int? code;
    String? message;
    List<Datas>? data;

    Diarys({this.code, this.message, this.data});

    Diarys.fromJson(Map<String, dynamic> json) {
        code = json["code"];
        message = json["message"];
        data = json["data"] == null ? null : (json["data"] as List).map((e) => Datas.fromJson(e)).toList();
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

class Datas {
    int? journalId;
    String? journalTitle;
    String? createdAt;
    String? modifiedAt;
    String? location;
    int? sharedCount;
    int? journalGroupIdAt;
    String? journalText;
    int? topJournal;

    Datas({this.journalId, this.journalTitle, this.createdAt, this.modifiedAt, this.location, this.sharedCount, this.journalGroupIdAt, this.journalText, this.topJournal});

    Datas.fromJson(Map<String, dynamic> json) {
        journalId = json["journalId"];
        journalTitle = json["journalTitle"];
        createdAt = json["createdAt"];
        modifiedAt = json["modifiedAt"];
        location = json["location"];
        sharedCount = json["sharedCount"];
        journalGroupIdAt = json["journalGroupIdAt"];
        journalText = json["journalText"];
        topJournal = json["topJournal"];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> _data = <String, dynamic>{};
        _data["journalId"] = journalId;
        _data["journalTitle"] = journalTitle;
        _data["createdAt"] = createdAt;
        _data["modifiedAt"] = modifiedAt;
        _data["location"] = location;
        _data["sharedCount"] = sharedCount;
        _data["journalGroupIdAt"] = journalGroupIdAt;
        _data["journalText"] = journalText;
        _data["topJournal"] = topJournal;
        return _data;
    }
}