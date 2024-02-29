import 'package:diary/changepage.dart';
import 'package:flutter/material.dart';
import 'sizecontrol.dart';
import 'package:diary/searchpage.dart';

class diarypage extends StatefulWidget {
  const diarypage({super.key});

  @override
  State<diarypage> createState() => _diarypageState();
}

class _diarypageState extends State<diarypage> {
  String _image="lib/assets/images/rabbit1.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          //类微信头部
          automaticallyImplyLeading: false,
          // backgroundColor: Color(0xFF7B9F4D),
          pinned: true,
          snap: false,
          floating: false,
          expandedHeight: 250,
          actions: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>searchpage()));
                  },
                  icon: Icon(
                    Icons.search_outlined,
                    size: Adapt.pt(35),
                  ),
                ),
              ],
            )
          ],
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: Stack(
              children: [
                Container(
                  child: Image.asset(
                    _image,
                    fit: BoxFit.cover,
                  ),
                  height: Adapt.pt(260),
                  width: Adapt.pt(430),
                ),
                Positioned(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: Container(
                      child: Image.asset("lib/assets/images/rabbit8.jpg"),
                      height: Adapt.pt(70),
                      width: Adapt.pt(70),
                    ),
                  ),
                  top: Adapt.pt(220),
                  right: Adapt.pt(25),
                ),
                Positioned(
                    top: Adapt.pt(240),
                    left: Adapt.pt(5),
                    child: GestureDetector(
                      onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>changepage())).then((value) {setState(() {
                               _image=value;
                             });} );
                             ;

                           ;


                      },
                      child: Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.terrain,
                              size: 15,
                            ),
                            Text(
                              "更换背景",
                              style: TextStyle(fontSize: Adapt.pt(10)),
                            )
                          ],
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
