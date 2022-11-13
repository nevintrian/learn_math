import 'dart:math';

import 'package:belajar_matematika/ad_helper.dart';
import 'package:flutter/material.dart';
import 'package:function_tree/function_tree.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Subtraction extends StatefulWidget {
  const Subtraction({super.key});

  @override
  State<Subtraction> createState() => _SubtractionState();
}

class _SubtractionState extends State<Subtraction> {
  TextEditingController resultController = TextEditingController();
  int level = 1;
  int score = 0;
  int val1 = 2;
  int val2 = 4;
  int randomVal1a = 1;
  int randomVal1b = 5;
  int randomVal2a = 1;
  int randomVal2b = 5;
  String operation = '-';

  //iklan
  late BannerAd _bannerAd;
  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;
  bool _isBannerAdReady = false;

  random(int min, int max) {
    return min + Random().nextInt(max - min);
  }

  checkLevel() {
    //ketika kelipatan 10 dan genap atau kelipatan 10 dan ganjil
    if (level % 10 == 0) {
      if (int.parse(level.toString()[0]) % 2 == 0) {
        setState(() {
          randomVal1a += 5;
          randomVal1b += 5;
        });
      } else if (int.parse(level.toString()[0]) % 2 != 0) {
        setState(() {
          randomVal2a += 5;
          randomVal2b += 5;
        });
      }
    }
  }

  checkMath() {
    String math = val1.toString() + operation + val2.toString();
    num result = math.interpret();
    return result.round().toString();
  }

  updateScore() {
    setState(() {
      score += 10;
    });
  }

  updateLevel() {
    setState(() {
      level++;
    });
  }

  updateValue() {
    setState(() {
      val1 = random(randomVal1a, randomVal1b);
      val2 = random(randomVal2a, randomVal2b);
    });
  }

  //iklan
  @override
  void initState() {
    _createBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  void _createBannerAd() {
    _bannerAd = BannerAd(
      adUnitId: AdHelper.bannerAdUnitId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          // print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          _interstitialAd = ad;
          _numInterstitialLoadAttempts = 0;
          _showInterstitialAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          _numInterstitialLoadAttempts += 1;
          _interstitialAd = null;
          if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            _createInterstitialAd();
          }
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      // print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Math Subtraction'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Expanded(
                flex: 1,
                child: Container(
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Score : $score",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        "Level : $level",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.purple)),
                          onPressed: () {
                            String math = checkMath();
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Hint'),
                                content: Text(
                                    "Result from $val1 $operation $val2 = $math"),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      _createInterstitialAd();
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            "Hint",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ))
                    ],
                  ),
                )),
            Expanded(
              flex: 8,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$val1 - $val2",
                    style: const TextStyle(
                        fontSize: 50, color: Color.fromARGB(255, 86, 86, 86)),
                  ),
                  Container(
                    padding: const EdgeInsets.all(50),
                    width: 300,
                    child: TextFormField(
                      controller: resultController,
                      onChanged: (value) {
                        if (value == checkMath()) {
                          checkLevel();
                          updateScore();
                          updateLevel();
                          updateValue();
                          resultController.clear();
                        }
                      },
                      style: const TextStyle(
                          fontSize: 50, color: Color.fromARGB(255, 86, 86, 86)),
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: InputBorder.none, hintText: "..."),
                    ),
                  )
                ],
              )),
            ),
            Expanded(
              flex: 1,
              child: Stack(children: [
                Container(color: Colors.yellow),
                const Center(
                    child: Text(
                  "Loading Ads...",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
                if (_isBannerAdReady)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: _bannerAd.size.width.toDouble(),
                      height: _bannerAd.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd),
                    ),
                  ),
              ]),
            )
          ],
        ));
  }
}
