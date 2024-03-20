import 'package:flutter/material.dart';
import 'sizecontrol.dart';

class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  TextEditingController _textcirl = TextEditingController();

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

              },
              child: Text("搜索",style: TextStyle(fontSize: Adapt.pt(15),color: Color(0xFF7B9F4D)),),
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,

                colors: [Colors.white, Color(0xFFEFFCDE)])),
      ),
    );
  }
}
