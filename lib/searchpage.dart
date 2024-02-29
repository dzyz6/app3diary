import 'package:flutter/material.dart';
import 'sizecontrol.dart';
class searchpage extends StatefulWidget {
  const searchpage({super.key});

  @override
  State<searchpage> createState() => _searchpageState();
}

class _searchpageState extends State<searchpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(

        ),

        backgroundColor: Color(0xFFFFFFFF),
        leading: Row(
          children: [
            SizedBox(width: Adapt.pt(5),),
            IconButton(
              icon: Icon(Icons.arrow_back_ios,color: Color(0xFF445B28),),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white,Color(0xFFEFFCDE)]
            )
        ),

      ),
    );
  }
}
