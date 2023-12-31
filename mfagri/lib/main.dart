import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/pages/pageLoading.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

// Import your Flame game
class GameScreen extends StatefulWidget {
  @override
  State<GameScreen> createState() => _GameScreenState();
  final String playername;
  final String backgroundcolor;
  GameScreen({required this.playername, required this.backgroundcolor});
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 60, 51),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: GameWidget(
              game: PixelAdventure(
                  context: context,
                  playername: widget.playername,
                  backgroundcolor: widget.backgroundcolor),
            ),
          ),
        ],
      ),
    );
  }
}
