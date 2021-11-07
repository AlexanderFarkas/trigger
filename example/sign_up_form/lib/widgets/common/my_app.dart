
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final Widget form;
  const MyApp({Key? key, required this.form}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SafeArea(
        child: Scaffold(
          body: Builder(builder: (context) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => FocusScope.of(context).unfocus(),
              child: form,
            );
          }),
        ),
      ),
    );
  }
}