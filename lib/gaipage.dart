import 'package:flutter/material.dart';
import 'sizecontrol.dart';

class Gaipage extends StatefulWidget {
  const Gaipage({super.key});

  @override
  State<Gaipage> createState() => _GaipageState();
}

class _GaipageState extends State<Gaipage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(
              width: Adapt.pt(95),
            ),
            Text(
              "新建日记",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        backgroundColor: Color(0xFF7B9F4D),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            FocusScope.of(context).unfocus();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pop(context);
            });
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
