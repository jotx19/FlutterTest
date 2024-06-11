import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

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

  void snackMan(String message) {
    final snackBar = SnackBar(
      content: Text(message),
      action: SnackBarAction(
        label: 'Clear',
        onPressed: () {
          clearData();
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void window() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Save?'),
        content: const Text('Save the credentials?'),
        actions: [
          ElevatedButton(
            onPressed: () {
              saver();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () {
              clearData();
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
        ],
      ),
    );
  }

  void saver() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("LoginName", _login.text);
    await prefs.setString("Password", _passwords.text);
  }

  void loader() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? loginName = prefs.getString("LoginName");
    String? password = prefs.getString("Password");

    if (loginName != null && password != null) {
      setState(() {
        _login.text = loginName;
        _passwords.text = password;
      });
      snackMan('Fields are loaded');
    }
  }

  void clearData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("LoginName");
    await prefs.remove("Password");
    setState(() {
      _login.clear();
      _passwords.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _login = TextEditingController();
    _passwords = TextEditingController();
    loader();
  }

  @override
  void dispose() {
    _login.dispose();
    _passwords.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login page',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 38,
          ),
        ),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _login,
              decoration: InputDecoration(
                labelText: 'Login',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: _passwords,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(fontWeight: FontWeight.bold),
              ),
              obscureText: true,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                _logining();
                window();
              },
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
