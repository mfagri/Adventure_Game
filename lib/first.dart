import 'dart:ffi';

import 'package:flame/components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pixel_adventure/main.dart';
import 'package:pixel_adventure/second.dart';

//Color.fromARGB(255, 253, 167, 105), orange
//const Color.fromARGB(255, 171, 194, 112), green
// Color.fromARGB(255, 71, 60, 51),bron
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

enum SampleItem { itemOne, itemTwo, itemThree }
String soundstate = "On";
Icon soundicon = Icon(Icons.music_note_sharp, size: 30);
class _HomepageState extends State<Homepage> {
  @override
  SampleItem? selectedMenu;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 171, 194, 112),
            image: DecorationImage(
                image: AssetImage('assets/images/a practice, Dan Zhao.png'),
                fit: BoxFit.cover)),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          homebottun(
              Icon(Icons.share), Color.fromARGB(255, 253, 167, 105), () {}),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  homebottun(
                      Icon(Icons.settings), Color.fromARGB(255, 253, 167, 105),
                      () {
                    _dialogExit(context);
                  }),
                  SizedBox(
                    width: 100,
                  ),
                  Container(
                    height: 60,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/coin.png'))),
                          ),
                          Center(
                            child: Text(
                              '1',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                          )
                        ]),
                  )
                ],
              ),
              Playbottun(),
            ],
          ),
          homebottun(Icon(Icons.privacy_tip_outlined),
              Color.fromARGB(255, 171, 194, 112), () {}),
        ]),
      ),
    );
  }

  InkWell Playbottun() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PlayerChoi()),
        );
      },
      child: Container(
        height: 60,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Color.fromARGB(255, 71, 60, 51)),
        child: const Center(
          child: Text(
            'Play',
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  InkWell homebottun(Icon icon, Color color, f()) {
    return InkWell(
      onTap: () {
        f();
      },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: color,
        ),
        child: Center(child: icon),
      ),
    );
  }

  Future<void> _dialogExit(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.transparent,
          title: const Text(''),
          content: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height - 20,
                  width: MediaQuery.of(context).size.height - 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 60,
                          width: 100,
                          color: Colors.white,
                          child: Row(children: [
                            IconButton(
                              onPressed: () {
                                
                                SystemNavigator.pop();
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.exit_to_app,
                                size: 30,
                              ),
                            ),
                            Text('Exit from the Game')
                          ]),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 60,
                          width: 100,
                          color: Colors.white,
                          child: Row(children: [
                            IconButton(
                              onPressed: () {
                               setState(() {
                                if(soundstate == 'On')
                                {
                                  soundicon = Icon(Icons.music_off, size: 30);
                                  soundstate = 'Off';
                                }
                                else
                                {

                                  soundicon = Icon(Icons.music_note_sharp, size: 30);
                                  soundstate = 'On';
                                }
                               });
                                Navigator.pop(context);
                              },
                              icon: soundicon,
                            ),
                            Text('Sound ${soundstate}')
                          ]),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Container(
                      //     height: 60,
                      //     width: 100,
                      //     color: Colors.white,
                      //     child: Row(children: [
                      //       IconButton(
                      //         onPressed: () {
                      //           Navigator.pop(context);
                      //         },
                      //         icon: Icon(Icons.music_off, size: 30),
                      //       ),
                      //       Text('Sound Off')
                      //     ]),
                      //   ),
                      // ),
                    ]),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.topRight,
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white),
                      child: Center(
                        child: IconButton(
                            // alignment: AlignmentDirectional(0,-20),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // actions: <Widget>[

          // ],
        );
      },
    );
  }
}
