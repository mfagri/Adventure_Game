import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pixel_adventure/constants.dart';
import 'package:pixel_adventure/main.dart';

class PlayerChoi extends StatefulWidget {
  const PlayerChoi({super.key});

  @override
  State<PlayerChoi> createState() => _PlayerChoiState();
}

List<String> test = [
  'assets/images/Main Characters/Shin Chan/LINE Official Stickers - Get Up and Move, Crayon Shin-chan! Example with GIF Animation.gif',
  'assets/images/1.png',
  'assets/images/2.png',
  'assets/images/3.png',
  'assets/images/4.png',
];
List<String> names = [
  'Shin Chan',
  'Mask Dude',
  'Ninja Frog',
  'Pink Man',
  'Virtual Guy',
];
List<String> back = [
  'assets/images/Background/Blue.png',
  'assets/images/Background/Brown.png',
  'assets/images/Background/Gray.png',
  'assets/images/Background/Green.png',
  'assets/images/Background/Pink.png',
  'assets/images/Background/Purple.png',
  'assets/images/Background/Yellow.png',
];
List<String> back1 = [
  'Blue',
  'Brown',
  'Gray',
  'Green',
  'Pink',
  'Purple',
  'Yellow',
];
int i = 0;
int indexRewarded = 9;
int j = 0;

class _PlayerChoiState extends State<PlayerChoi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 71, 60, 51),
        elevation: 0,
      ),
      body: Container(
        color: const Color.fromARGB(255, 171, 194, 112),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 1.7,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 171, 194, 112),
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/Skull Island, Rasool Ahmadi.png'),
                      fit: BoxFit.cover)),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Text(
                      //         'Character',
                      //         style: TextStyle(
                      //             fontSize: 30,
                      //             fontWeight: FontWeight.bold,
                      //             color: Colors.white),
                      //       ),
                      Container(
                        height: 40,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: back.length,
                            itemBuilder: (BuildContext context, int indexh) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      j = indexh;
                                    });
                                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2, color: Colors.black),
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                            image: AssetImage(back[indexh]),
                                            fit: BoxFit.cover)),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: 200,
                            width: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(test[i]), fit: BoxFit.fill),
                              borderRadius: BorderRadius.circular(15),
                              // border:
                              //     Border.all(width: 0, color: Colors.black87)
                            ),
                          ),
                          //         if(i >= 2)

                          Container(
                            height: 60,
                            width: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.yellow,
                                image: DecorationImage(
                                    image: AssetImage(back[j]),
                                    fit: BoxFit.cover),
                                border: Border.all(
                                    width: 2, color: Colors.black87)),
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          // if(i >= 2)
                          // {
                          // }
                          // else
                          // {
                          g_ads.interInstance.showInterstitialAd();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GameScreen(
                                      backgroundcolor: back1[j],
                                      playername: names[i],
                                    )),
                          );
                          // }
                        },
                        child: Container(
                          height: 40,
                          width: 150,
                          decoration: BoxDecoration(
                              // border: Border.all(width: 6, color: Colors.black),
                              color: const Color.fromARGB(255, 253, 167, 105),
                              borderRadius: BorderRadius.circular(15)),
                          child: const Center(
                            child: Text(
                              'Play',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 253, 167, 105),
                  image: const DecorationImage(
                      image: AssetImage(
                          'assets/images/Skull Island, Rasool Ahmadi.png'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(15)),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width / 3,
              child: MasonryGridView.builder(
                itemCount: test.length,
                gridDelegate:
                    const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                        onTap: () {
                          print(i);
                          if (index == 0)
                            ;
                          else {
                            // alert bax tkolih bax itfrj f rewared 3ad itl3 ads
                            g_ads.rewardInstance.showRewardAd(() {
                              setState(() {
                                indexRewarded = index;
                                i = index;
                              });
                            });
                          }

                          // if (itas == 1) {
                          //   interstitalAd?.show();
                          //   I_nitInterstitialAd();
                          // }
                          // Navigator.of(context)
                          //     .push(MaterialPageRoute(
                          //         builder: (context) => Painting(
                          //             image: s[index], imageKey: widget.imageKey)))
                          //     .then((value) => {setState(() {})});
                        },
                        child: SizedBox(
                          height: 90,
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 90,
                                child: Center(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                              255, 253, 167, 105),
                                          border: Border.all(
                                              width: 2, color: Colors.black),
                                          image: DecorationImage(
                                              image: AssetImage(test[index]),
                                              fit: BoxFit.fill),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      )),
                                ),
                              ),
                              (i != index ||
                                      (index != indexRewarded && index != i))
                                  ? Container(
                                      padding: const EdgeInsets.all(15),
                                      height: 90,
                                      width: 90,
                                      decoration: BoxDecoration(
                                        color: const Color(0x77555555),
                                        border: Border.all(
                                            width: 2, color: Colors.black),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Image.asset(
                                        "assets/icons/lock.png",
                                      ),
                                    )
                                  : Container()
                            ],
                          ),
                        ))),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
