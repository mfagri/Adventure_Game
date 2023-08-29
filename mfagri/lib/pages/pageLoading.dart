import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multi_ads/multi_ads.dart';
import 'package:pixel_adventure/widget/toas.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';
import 'first.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    fetchAdsData();
  }

  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isLoading
                  ? Row(
                      children: [Image.asset("assets/loading-bar.gif")],
                    )
                  : ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.yellow)),
                      onPressed: () {
                        fetchAdsData();
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: const Text(
                        "Try again",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Future<void> fetchAdsData() async {
    try {
      var url = Uri.parse(Constants.jsonConfigUrl);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var data2 = json.decode(response.body);
        g_ads = MultiAds(response.body);
        await g_ads.init();
        await g_ads.loadAds();
        setState(() {
          configApp = data2["config"];
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Homepage()),
          );
        });
      } else {
        await Future.delayed(const Duration(seconds: 2), () {
          toas(context, "YOU ARE NOT CONNECTED");
          setState(() {
            isLoading = false;
          });
        });
      }
    } catch (e) {
      await Future.delayed(const Duration(seconds: 2), () {
        toas(context, "YOU ARE NOT CONNECTED");
        setState(() {
          isLoading = false;
        });
      });
    }
  }
}
