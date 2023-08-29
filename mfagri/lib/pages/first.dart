import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multi_ads/multi_ads.dart';
import 'package:pixel_adventure/second.dart';

import '../constants.dart';

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
        decoration: const BoxDecoration(
            color: Color.fromARGB(255, 171, 194, 112),
            image: DecorationImage(
                image: AssetImage('assets/images/a practice, Dan Zhao.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // height: 70,
                  // width: 300,
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child:
                      CustomBanner(key: UniqueKey(), ads: g_ads.bannerInstance),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                homebottun(const Icon(Icons.settings),
                    const Color.fromARGB(255, 253, 167, 105), () {
                  _dialogExit(context);
                }),
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
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/images/coin.png'))),
                        ),
                        const Center(
                          child: Text(
                            '1',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        )
                      ]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 50),
                  child: homebottun(const Icon(Icons.share),
                      const Color.fromARGB(255, 253, 167, 105), () {}),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 50),
                  child: homebottun(const Icon(Icons.privacy_tip_outlined),
                      const Color.fromARGB(255, 171, 194, 112), () {}),
                ),
              ],
            ),
            playBottun(),
            const SizedBox()
          ],
        ),
      ),
    );
  }

  InkWell playBottun() {
    return InkWell(
      onTap: () {
        g_ads.openAdsInstance.showAdIfAvailableOpenAds();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const PlayerChoi()),
        );
      },
      child: Container(
        height: 60,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: const Color.fromARGB(255, 71, 60, 51)),
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
                                  if (soundstate == 'On') {
                                    soundicon = Icon(Icons.music_off, size: 30);
                                    soundstate = 'Off';
                                  } else {
                                    soundicon =
                                        Icon(Icons.music_note_sharp, size: 30);
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
