import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // use to remove debug
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
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('ABCDE'),
        actions: [
          OutlinedButton(onPressed: (){}, child: Text("Button 1")),
          OutlinedButton(onPressed: (){}, child: Text("Button 1")),],
      ),
      drawer:Drawer(child:Text("Hi there")),

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
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem( icon: Icon(Icons.camera), label: 'Camera' ),
          BottomNavigationBarItem( icon: Icon(Icons.add_call), label: 'Phone'  ),
        ],
          onTap: (buttonIndex) {  } ,
        )
    );
  }
}