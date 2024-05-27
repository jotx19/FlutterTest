import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

void closeDrawer(BuildContext context) {
  Navigator.of(context).pop();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(),
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Menu'),
        actions: [
          // OutlinedButton(onPressed: (){}, child: Text("Button 1")),
          // OutlinedButton(onPressed: (){}, child: Text("Button 2")),
        ],
      ),
      drawer: Drawer(
        child: Center(
            child:ElevatedButton(onPressed: ()=> closeDrawer(context), child: Text("X"),),

        ),
      ),




      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(child: Text("BROWSE CATEGORIES", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
            Center(child: Text("Not sure about exactly which recipe you're looking for? Do a search, or dive into our most popular categories.", textAlign: TextAlign.left)),
            Center(child: Text("BY MEAT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imageWithCenterText("Beef", "images/beef.jpeg"),
                imageWithCenterText("Chicken", "images/chicken.jpeg"),
                imageWithCenterText("Pork", "images/pork.jpeg"),
                imageWithCenterText("Seafood", "images/seafood.jpeg"),
              ],
            ),
            Center (child: Text("BY COURSE", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imageWithTextBelow("Main Dishes", "images/maindishes.jpeg"),
                imageWithTextBelow("Salad Recipes", "images/salad.jpeg"),
                imageWithTextBelow("Side Dishes", "images/side_dishes.jpeg"),
                imageWithTextBelow("Crockpot", "images/crockpot.jpeg"),
              ],
            ),
            Center(child: Text("BY DESSERT", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                imageWithTextBelow("Ice Cream", "images/ice_cream.jpeg"),
                imageWithTextBelow("Brownies", "images/brownies.jpeg"),
                imageWithTextBelow("Pies", "images/pies.jpeg"),
                imageWithTextBelow("Cookies", "images/cookies.jpeg"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget imageWithCenterText(String text, String imagePath) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipOval(
        child: Image.asset(imagePath, width: 80, height: 80, fit: BoxFit.cover),
        ),
        Text(text,
          style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget imageWithTextBelow(String text, String imagePath) {
    return Column(
      children: [
        ClipOval(
          child: Image.asset(
            imagePath,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 8), // Adjusts the space between the image and text
        Text(text,
          style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

}
