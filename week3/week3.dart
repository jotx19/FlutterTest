import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
            onPressed: () {},
        child: Text('Button 1'),
            ),
        ElevatedButton(
          onPressed: () {},
          child: Text('Button 2'),
        ),
            ElevatedButton(
              onPressed: () {},
              child: Text('Button 3'),
            ),

          ],
        ),
      ),
    );
  }
}
