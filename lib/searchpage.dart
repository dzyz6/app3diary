import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'assets/icon/my_flutter_app_icons.dart';
import 'diarychuan.dart';
import 'dioclass.dart';
import 'gaipage.dart';
import 'ofeditorpage.dart';
import 'sizecontrol.dart';
import 'package:dio/dio.dart';

class searchpage extends StatefulWidget {
  const searchpage({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<searchpage> createState() => _searchpageState(token:
  token);
}

class _searchpageState extends State<searchpage> {


  String token;

  _searchpageState({required this.token});

  TextEditingController _textcirl = TextEditingController();

  List a = ["一", "二", "三", "四", "五", "六", "天"];

  var _get = Get();
  Dio dio = Dio();

  late String inside="";
  int total = 0;

  Future<void> createlist(String token) async {
    String url = "https://mambaout.xyz/getJournalsByUid";
    dio.options.baseUrl = url;
    dio.options.headers['token'] = token;
    Map<String, dynamic> map = Map();
    map['page'] = 1;
    map['pageSize'] = 100;
    map['journalTitle'] = null;
    map['range'] = 0;
    map['date']=null;
    Response response = await dio.get(url, queryParameters: map);
    _get = Get.fromJson(response.data);

    print(inside);
    print('aaaaaaaaaaaaaaaaaaaaaaaaa');
    print(total);
  }

  @override
  void initState() {

    super.initState();
    createlist(token);
  }

  Future<void> delete(String token,String id) async {
    String url = "https://mambaout.xyz/modifyJournal";

    dio.options.headers['token'] = token;
    Map<String, dynamic> map = Map();
    map['journalId'] = id;
    map['isDeleted']='1';

    Response response = await dio.put(url, data: map);
    print(response);
  }

  void showMessage(BuildContext context, String text) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("操作失败"),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("确定")),
          ],
        );
      },
    );
  }
  void showTureMessage(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("操作成功"),
          content: Text('成功移除日记'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("确定")),
          ],
        );
      },
    );
  }
  Future<void> deleteDiary(String diaryid,String diarylistid) async {
    Dio dio = Dio();
    String url = "http://mambaout.xyz/deleteJournalFromJournalGroup";
    dio.options.baseUrl = url;
    dio.options.headers['token'] = token;
    Map<String,dynamic> map = Map();
    map['journalId']=diaryid;
    map['journalGroupId']=diarylistid;
    Response response = await dio.put(url,data: map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Adapt.pt(80),
        automaticallyImplyLeading: false,
        title: Container(
          height: Adapt.pt(35),
          width: Adapt.pt(280),
          child: TextField(
            style: TextStyle(fontSize: Adapt.pt(13), ),
            controller: _textcirl,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search_outlined,color: Color(0xFF939393),),
                fillColor: Color(0xFFD5D5D5),
                filled: true,

                contentPadding: EdgeInsets.only(left: Adapt.pt(15),right: Adapt.pt(15)),
                isDense: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFD5D5D5),
                    width: 0,


                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),

              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFD5D5D5),
                  width: 0,


                ),
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ) ,
              hintText: "今天想搜些什么呢₍ᐢ..ᐢ₎♡",
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFFD5D5D5),
                    width: 0,

                  ),
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),

                suffixIcon: IconButton(
              icon:Icon(Icons.cancel,color: Color(0xFFB4B4B4),),
              onPressed: () {
                _textcirl.clear();
                FocusScope.of(context).requestFocus();

              },
            )),
          ),
        ),
        backgroundColor: Color(0xFFFFFFFF),
        leading: Row(
          children: [
            SizedBox(
              width: Adapt.pt(5),
            ),
            IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xFF445B28),
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Adapt.pt(20)),
            child: GestureDetector(
              onTap: (){
                FocusScope.of(context).unfocus();
                setState(() {

                });

              },
              child: Text("搜索",style: TextStyle(fontSize: Adapt.pt(15),color: Color(0xFF7B9F4D)),),
            ),
          )
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,

                colors: [Colors.white, Color(0xFFEFFCDE)])),
        child: _textcirl.text.isEmpty?Container():FutureBuilder(future: createlist(token),
            builder: (BuildContext context,
                AsyncSnapshot<void> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                    child: Container(

                    ),
                  );
                case ConnectionState.done:
                  if (_get != null &&
                      _get.data != null &&
                      _get.data!.records.isNotEmpty &&
                      _get.data?.total != 0) {
                    total = _get.data!.total;
                  } else {
                    total = 0;
                    inside = "";
                  }
                  int p=0;
                  SlidableController _slidableController=SlidableController();

                  for(int i=0;i<total;i++){
                    if(_get.data!.records[i].journalText.indexOf(_textcirl.text)!=-1){
                      p++;
                    }
                  }


                  if(p!=0){
                    return ListView.builder(
                        itemCount: total,
                        itemBuilder: (BuildContext context, int index) {
                          inside = _get.data!.records[index].journalText;
                          var time = _get.data!.records[index].createdAt;
                          var creattime = time.substring(12, 14);
                          var creattime2 = time.substring(15, 17);
                          var creattimeday = time.substring(8, 10);
                          var creattimemonth = time.substring(6, 7);
                          var creattimeyear = time.substring(0, 4);
                          if(inside.indexOf(_textcirl.text)!=-1){
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoPageRoute(
                                        builder: (context) =>
                                            gaipage(token: token,inside: _get.data!.records[index].journalText,id: _get.data!.records[index].journalId,
                                            ))).then((value) {
                                  setState(() {

                                  });

                                });

                              },
                              child: Slidable(
                                actionPane: SlidableDrawerActionPane(),
                                secondaryActions: [
                                  IconSlideAction(
                                    caption:
                                    "删除",
                                    iconWidget: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: ()async{
                                        await delete(token, _get.data!.records[index].journalId.toString());
                                        setState(() {

                                        });
                                      },
                                    ),
                                    color: Colors.red,


                                  ),
                                  IconSlideAction(
                                    iconWidget: IconButton(
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Container(
                                                height: Adapt.hpt(200),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    topLeft:
                                                    const Radius.circular(
                                                        20.0),
                                                    topRight:
                                                    const Radius.circular(
                                                        20.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      behavior: HitTestBehavior.translucent,
                                                      onTap: () async {
                                                        await getDiaryofDiarys
                                                            .getofDiarys(
                                                            token,
                                                            _get
                                                                .data!
                                                                .records[
                                                            index]
                                                                .journalGroupIdAt);
                                                        if (getDiaryofDiarys
                                                            .diarys
                                                            .code ==
                                                            200) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                      Diarychuan2(
                                                                        diaryListId: _get.data!.records[index].journalGroupIdAt,
                                                                      )));
                                                        } else {
                                                          showMessage(
                                                              context,
                                                              getDiaryofDiarys
                                                                  .diarys
                                                                  .message!);
                                                        }
                                                      },
                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: Adapt.pt(
                                                                  20),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .format_list_bulleted,
                                                              size: Adapt.pt(
                                                                  30),
                                                              color: Color(
                                                                  0xffffaeae),
                                                            ),
                                                            SizedBox(
                                                              width: Adapt.pt(
                                                                  20),
                                                            ),
                                                            Text(
                                                              "展示当前日记串",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  Adapt.pt(
                                                                      18)),
                                                            ),
                                                          ],
                                                        ),
                                                        margin:
                                                        EdgeInsets.all(
                                                            Adapt.hpt(15)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    GestureDetector(
                                                      behavior: HitTestBehavior.translucent,
                                                      onTap: () async {
                                                        await getDiaryofDiarys
                                                            .getofDiarys(
                                                            token,
                                                            _get
                                                                .data!
                                                                .records[
                                                            index]
                                                                .journalGroupIdAt);
                                                        if (getDiaryofDiarys
                                                            .diarys
                                                            .code ==
                                                            200) {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                      Ofeditorpage(

                                                                        token: token, diaryid: _get.data!.records[index].journalGroupIdAt.toString(),
                                                                      )));
                                                        } else {
                                                          showMessage(
                                                              context,
                                                              getDiaryofDiarys
                                                                  .diarys
                                                                  .message!);
                                                        }
                                                      },

                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: Adapt.pt(
                                                                  20),
                                                            ),
                                                            Icon(
                                                              Icons.add,
                                                              size: Adapt.pt(
                                                                  35),
                                                              color: Color(
                                                                  0xffc3f4ff),
                                                            ),
                                                            SizedBox(
                                                              width: Adapt.pt(
                                                                  20),
                                                            ),
                                                            Text(
                                                              "新建日记到当前日记串",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  Adapt.pt(
                                                                      18)),
                                                            ),
                                                          ],
                                                        ),
                                                        margin:
                                                        EdgeInsets.all(
                                                            Adapt.hpt(8)),
                                                      ),
                                                    ),
                                                    Divider(
                                                      color: Colors.grey,
                                                    ),
                                                    GestureDetector(
                                                      behavior: HitTestBehavior.translucent,
                                                      onTap: () async {
                                                        await getDiaryofDiarys
                                                            .getofDiarys(
                                                            token,
                                                            _get
                                                                .data!
                                                                .records[
                                                            index]
                                                                .journalGroupIdAt);
                                                        if (getDiaryofDiarys
                                                            .diarys
                                                            .code ==
                                                            200) {
                                                          deleteDiary(_get
                                                              .data!
                                                              .records[
                                                          index]
                                                              .journalId.toString(), _get
                                                              .data!
                                                              .records[
                                                          index]
                                                              .journalGroupIdAt.toString());
                                                          showTureMessage(context);
                                                        } else {
                                                          showMessage(
                                                              context,
                                                              getDiaryofDiarys
                                                                  .diarys
                                                                  .message!);
                                                        }
                                                      },
                                                      child: Container(
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: Adapt.pt(
                                                                  20),
                                                            ),
                                                            Icon(
                                                              Icons
                                                                  .exit_to_app,
                                                              size: Adapt.pt(
                                                                  30),
                                                              color: Color(
                                                                  0xffffe4a8),
                                                            ),
                                                            SizedBox(
                                                              width: Adapt.pt(
                                                                  20),
                                                            ),
                                                            Text(
                                                              "从日记串移出",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                  Adapt.pt(
                                                                      18)),
                                                            ),
                                                          ],
                                                        ),
                                                        margin:
                                                        EdgeInsets.all(
                                                            Adapt.hpt(10)),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          MyFlutterApp.circle,
                                          color: Colors.white,
                                          size: Adapt.pt(20),
                                        )),
                                    color: Colors.green,
                                  )
                                ],
                                controller: _slidableController,
                                key: UniqueKey(),
                                actionExtentRatio: 0.15,
                                dismissal:SlidableDismissal(child: SlidableDrawerDismissal(),
                                  dismissThresholds: <SlideActionType, double>{
                                    SlideActionType.primary: 1.0,
                                    SlideActionType.secondary: 1.0,
                                  },
                                  onDismissed:(actionType){
                                    print("66666");
                                  },
                                ),

                                child: Column(
                                  children: [
                                    Container(
                                      height: Adapt.pt(79),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: Adapt.pt(20),
                                          ),
                                          Column(
                                            children: [
                                              SizedBox(
                                                height: Adapt.pt(15),
                                              ),
                                              RichText(
                                                text: TextSpan(children: [
                                                  TextSpan(
                                                      text: "$creattimeday",
                                                      style: TextStyle(
                                                          fontSize: Adapt.pt(25),
                                                          color: Colors.black)),
                                                  TextSpan(
                                                      text: "$creattimemonth",
                                                      style: TextStyle(
                                                          fontSize: Adapt.pt(15),
                                                          color: Colors.black)),
                                                  TextSpan(
                                                      text: "月",
                                                      style: TextStyle(
                                                          fontSize: Adapt.pt(13),
                                                          color: Colors.black)),
                                                ]),
                                              ),
                                              RichText(
                                                  text: TextSpan(children: [
                                                    TextSpan(
                                                        text: "星期",
                                                        style: TextStyle(
                                                            fontSize: Adapt.pt(12),
                                                            color: Colors.black)),
                                                    TextSpan(
                                                      text: a[
                                                      DateTime(int.parse(creattimeyear), int.parse(creattimemonth), int.parse(creattimeday))
                                                          .weekday -
                                                          1],
                                                      style: TextStyle(
                                                          fontSize: Adapt.pt(12),
                                                          color: Colors.black),
                                                    ),
                                                  ])),
                                            ],
                                          ),
                                          SizedBox(
                                            width: Adapt.pt(20),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "$inside",
                                                  style: TextStyle(
                                                    fontSize: Adapt.pt(15),
                                                    color: Colors.black,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                  softWrap: false,
                                                ),
                                                Text(
                                                  "$creattime" + ":" + "$creattime2",
                                                  style: TextStyle(
                                                      fontSize: Adapt.pt(8),
                                                      color: Color(0xff6b6b6b)),
                                                ),

                                              ],
                                            ),
                                          ),
                                          SizedBox(width: Adapt.pt(40),)
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      height: Adapt.pt(1),
                                      color: Color(0xFFE3E3E3),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          else{
                            return SizedBox.shrink();
                          }





                        });
                  }
                  else{
                    return Align(child: Container(child: Text("没有搜索到关键词",style: TextStyle(fontSize: Adapt.pt(15),color: Colors.grey),),),alignment: Alignment.topCenter,);
                  }

                case ConnectionState.none:
                  return Container();
                case ConnectionState.active:
                  return Container();
              }
            }),
      ),
    );
  }
}





