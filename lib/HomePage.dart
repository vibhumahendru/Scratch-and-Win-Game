import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  AssetImage circle = AssetImage("images/circle.png");
  AssetImage lucky = AssetImage("images/rupee.png");
  AssetImage unlucky = AssetImage("images/sadFace.png");

  List<String> itemArray;
  int luckyNumber;

  @override
  void initState() {
    super.initState();
    itemArray = List<String>.generate(25, (index)=> "empty");
    generateRandomNumber();
  }

  generateRandomNumber(){
    int random = Random().nextInt(25);
    setState(() {
      luckyNumber = random;
    }); 
  }

  AssetImage getImage(int index){
    String currentState = itemArray[index];
    switch (currentState) {
      case "lucky":
          return lucky;
        break;
      case "unlucky":
          return unlucky;
        break;
      default:
    }
    return circle;
  }

  playGame(int index){
    if (luckyNumber == index) {
      setState((){
        itemArray[index]="lucky";
      });
    } else {
      setState(() {
        itemArray[index]="unlucky";
      });
    }
  }

  showAll(){
    setState(() {
      itemArray = List<String>.filled(25, "unlucky");
      itemArray[luckyNumber] = "lucky";
    });
  }

  resetGame(){
    setState(() {
      itemArray = List<String>.filled(25, "filled");
    });
    generateRandomNumber();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch and Win')
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: itemArray.length,
              itemBuilder: (context, i)=> SizedBox(
                width: 50.0,
                height: 50.0,
                child: RaisedButton(
                  onPressed: (){playGame(i);},
                  child: Image(
                    image: this.getImage(i),
                  ),
                )
              ),
            ),
          ),
          Container(margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: (){
                this.showAll();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text('Show All',
              style:  TextStyle(color: Colors.white, fontSize: 20.0 ),
              ),
            ),
          ),
          Container(margin: EdgeInsets.all(15.0),
            child: RaisedButton(
              onPressed: (){
                this.resetGame();
              },
              color: Colors.pink,
              padding: EdgeInsets.all(20.0),
              child: Text('Reset Game', style:  TextStyle(color: Colors.white, fontSize: 20.0)
              ),
            ),
          ),
        ],
      ),
    );
  }
}