import 'package:diary/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:diary/login.dart/interface.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Styling Demo';
    return RestartWidget(
      child: MaterialApp(
          routes: {
            '/':(BuildContext context) =>  Interface(),
          '/login': (BuildContext context) =>  Interface(),
        }, 
        title: appTitle,
      ),
    );
  }
}

class RestartWidget extends StatefulWidget {
  RestartWidget({required this.child});
 
  final Widget child;
 
  static void restartApp(BuildContext context) {
    //查找顶层_RestartWidgetState并重启
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }
 
  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}
 
class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();
 
  void restartApp() {
    setState(() {
      key = UniqueKey();//重新生成key导致控件重新build
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}
