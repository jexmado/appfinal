import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Battle',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int playerHealth = 30;
  int opponentHealth = 30;

  void attack() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("選擇招式"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                useSpark();
                Navigator.of(context).pop();
              },
              child: Text("火花"),
            ),
            TextButton(
              onPressed: () {
                useTackle();
                Navigator.of(context).pop();
              },
              child: Text("撞擊"),
            ),
          ],
        );
      },
    );
  }

  void opponentAction() {
    Random random = Random();
    int choice;
    if (playerHealth <= 10 && opponentHealth <= 15) {
      choice = random.nextInt(60) + 1;
    } else if (playerHealth > 10 && opponentHealth <= 15) {
      choice = random.nextInt(70) + 30;
    } else {
      choice = random.nextInt(50) + 1;
    }
    print(choice);

    if (choice <= 50) {
      int opponentDamage = random.nextInt(7) + 7;
      print("對手對你造成了 $opponentDamage 點傷害");
      setState(() {
        playerHealth -= opponentDamage;
        if (playerHealth <= 0) {
          playerHealth = 0;
          _showMessage("失敗", "你輸了！");
        }
      });
    } else {
      setState(() {
        opponentHealth = 30;
        print("對手使用回覆藥，回復了30滴血量");
      });
    }

    if (opponentHealth <= 0) {
      opponentHealth = 0;
      _showMessage("勝利", "你贏了！");
    }
  }

  void useSpark() {
    Random random = Random();
    int n = random.nextInt(5) + 6;
    print("小火龍使用火花，造成 $n 傷害");
    setState(() {
      opponentHealth -= n;
      if (opponentHealth <= 0) {
        opponentHealth = 0;
        _showMessage("勝利", "你贏了！");
      }
    });
    opponentAction();
  }

  void useTackle() {
    int n = 8;
    print("小火龍使用撞擊，造成 $n 傷害");
    setState(() {
      opponentHealth -= n;
      if (opponentHealth <= 0) {
        opponentHealth = 0;
        _showMessage("勝利", "你贏了！");
      }
    });
    opponentAction();
  }

  void usePotion() {
    setState(() {
      playerHealth += 30;
      if (playerHealth > 30) {
        playerHealth = 30;
      }
      print("你使用了回復藥，回復了30點血量");
    });
    opponentAction();
  }

  void escape() {
    _showMessage("逃跑", "你想逃跑喔??????你超爛ㄟ，可惜面對挑戰者不可以逃跑喔 ㄏㄏ");
  }

  void _showMessage(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokemon Battle"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Player: Charmander ($playerHealth/30)"),
          Image.asset('assets/Charmander.png', height: 100),
          SizedBox(height: 20),
          Text("Opponent: Pikachu ($opponentHealth/30)"),
          Image.asset('assets/Pikachu.png', height: 100),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: attack,
                child: Text("攻擊"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: usePotion,
                child: Text("背包"),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: escape,
                child: Text("逃跑"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
