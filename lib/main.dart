import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _counter = 0;
  var myFontSize = 30.0;
  var isChecked = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void buttonClicked(){

  }

  void setNewValue(double value)
  {
    setState(() {
      _counter = value.toInt();
      myFontSize = value;
    });
  }

  void _incrementCounter() {
    setState(() {
      if(_counter < 99.0)
        _counter++;
      myFontSize = _counter.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Text('You have pushed the button this many times:', style: TextStyle(fontSize: myFontSize, color: Colors.black), // Link to myFontSize
            ),
            // Image.asset("images/algonquin.jpg", width: 200, height:200),
            TextField(controller: _controller,
                decoration: InputDecoration(
                    hintText:"Type here",
                    border: OutlineInputBorder(),
                    labelText: "First name"
                )),
            Text('$_counter', style: TextStyle(fontSize: myFontSize, color:Colors.red) ,),
            Slider(value:_counter.toDouble(), max:100.0, onChanged: setNewValue, min:0.0 ),
            ElevatedButton(
              onPressed: buttonClicked,
               child: Image.asset("images/algonquin.jpg", width: 200, height:200)
          ),
            Checkbox(value: isChecked, onChanged:(newValue) { setState( () { isChecked = newValue !; } ); }),
            Switch(value: isChecked, onChanged:(newValue) { setState( () { isChecked = newValue !; } ); })

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
