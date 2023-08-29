import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/jump_button.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  final BuildContext context;
  final String playername;
  final String backgroundcolor;
  PixelAdventure(
      {required this.playername,
      required this.context,
      required this.backgroundcolor}) {
    player = Player(character: playername);
    player.setContext(context);
  }
  @override
  Color backgroundColor() => const Color(0xFF211F30);
  late CameraComponent cam;
  late Player player;
  late JoystickComponent joystick;
  bool showControls = false;
  List<String> levelNames = [
    'Level-01',
    'Level-02',
    'Level-03',
    'Level-04',
    'Level-05',
  ];
  int currentLevelIndex = 0;

  @override
  FutureOr<void> onLoad() async {
    // Load all images into cache
    await images.loadAllImages();

    _loadLevel();

    if (!showControls) {
      addJoystick();
      add(JumpButton());
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!showControls) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      priority: 10,
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Knob.png'),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache('HUD/Joystick.png'),
        ),
      ),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );

    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() async {
    removeWhere((component) => component is Level);

    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      print('win');
      await _retry(context);
      _loadLevel();
    } else {
      print('salina lvls');
      _dialogNolvl(context);
      // no more levels
    }
  }

  void _loadLevel() {
    Future.delayed(const Duration(seconds: 1), () {
      Level world = Level(
        backgroundcolor: backgroundcolor,
        player: player,
        levelName: levelNames[currentLevelIndex],
      );

      cam = CameraComponent.withFixedResolution(
        world: world,
        width: 640,
        height: 360,
      );
      cam.viewfinder.anchor = Anchor.topLeft;

      addAll([cam, world]);
    });
  }

  Future<void> _dialogNolvl(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            content: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.amber),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text(
                    'You Finish !!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Ok',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

//togle
  Future<void> _retry(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.transparent,
            // title: const Text('To the next Level'),
            content: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 100,
                  width: 200,
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(60),
                          bottomRight: Radius.circular(60))),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height - 200,
                  child: SizedBox(
                    height: 80,
                    width: 200,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              print('retry');
                              Navigator.pop(context);
                              currentLevelIndex--;
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/retry.png'))),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print('next');
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/next.png'))),
                            ),
                          ),
                        ]),
                  ),
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height - 280,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 80,
                      width: 180,
                      decoration: BoxDecoration(
                          color: Colors.black38,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Center(
                            child: Text(
                              '10',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            height: 60,
                            width: 60,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/coin.png'))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: Container(
                    height: 60,
                    width: 400,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/win.png'))),
                  ),
                ),
              ],
            ));
      },
    );
  }
}
