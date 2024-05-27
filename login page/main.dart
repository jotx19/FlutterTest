import 'package:flutter/material.dart';
import 'package:testing/main.dart';

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
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _LoginPageState();
}

class _LoginPageState extends State<MyHomePage> {
  late TextEditingController _login;
  late TextEditingController _passwords;
  String imageSource = 'images/question-mark.png';

  void _logining() {
    setState(() {
      if (_passwords.text == 'QWERTY123') {
        imageSource = 'images/idea.png';
      } else {
        imageSource = 'images/stop.png';
      }
    });
  }
  @override
  void initState(){

    super.initState();
    _login=TextEditingController();
    _passwords=TextEditingController();
  }

  @override
  void dispose(){

    _login.dispose();
    _passwords.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login page',
        style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 38,

        ),
        ),
        backgroundColor: Colors.white24,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _login,
              decoration: InputDecoration(  labelText: 'Login', labelStyle: TextStyle(fontWeight: FontWeight.bold), // Set font weight of label text
              ),
            ),
            TextField(
              controller: _passwords,
              decoration: InputDecoration(labelText: 'Password', labelStyle: TextStyle(fontWeight: FontWeight.bold)
            ),
              obscureText: true,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _logining,
              child: Text('Login'),
            ),
            SizedBox(height: 40),
            Image.asset(
              imageSource,
              width: 300,
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
