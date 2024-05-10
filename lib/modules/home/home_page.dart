import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:game_notion/models/enum/game_state_enum.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import './home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(title: const Text('Game Notion')),
        body: Container(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final db = FirebaseFirestore.instance;
            final user = FirebaseAuth.instance.currentUser;
            db
                .collection('/123' + user!.uid)
                .doc('4')
                .set({'name': 'John Doe', 'age': 30, 'email': '123'});
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: SnakeNavigationBar.color(
          currentIndex: controller.pageGameState.value.index,
          showUnselectedLabels: context.isTablet,
          showSelectedLabels: true,
          snakeViewColor: context.theme.primaryColor,
          unselectedItemColor: context.theme.primaryColor,
          snakeShape: SnakeShape.rectangle,
          onTap: (index) {
            controller.pageGameState.value = GameState.values[index];
          },
          items: GameState.values.map((e) {
            return BottomNavigationBarItem(
              icon: Icon(e.icon),
              label: e.label,
            );
          }).toList(),
        ),
      );
    });
  }
}
