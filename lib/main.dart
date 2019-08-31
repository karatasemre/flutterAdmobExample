import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'MobileId';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );

  InterstitialAd _interstitialAd;
  RewardedVideoAd _rewardedVideoAd;

  bool isRewardVideoLoaded = false;


  InterstitialAd createInterstitialAd() {
    _interstitialAd =  InterstitialAd(
        adUnitId: InterstitialAd.testAdUnitId,
        //Change Interstitial AdUnitId with Admob ID
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {
          switch(event){
            case MobileAdEvent.loaded:
              // TODO: Handle this case.
              print("loaded");
              break;
            case MobileAdEvent.failedToLoad:
              // TODO: Handle this case.
              print("failedToLoad");
              break;
            case MobileAdEvent.clicked:
              // TODO: Handle this case.
              print("clicked");
              break;
            case MobileAdEvent.impression:
              // TODO: Handle this case.
              print("impression");
              break;
            case MobileAdEvent.opened:
              // TODO: Handle this case.
              print("opened");
              break;
            case MobileAdEvent.leftApplication:
              // TODO: Handle this case.
              print("leftApplication");
              break;
            case MobileAdEvent.closed:
              // TODO: Handle this case.
              print("closed");
              break;
          }
        });
    return _interstitialAd;
  }

  @override
  void initState() {
    FirebaseAdMob.instance.initialize(appId: BannerAd.testAdUnitId);
    _rewardedVideoAd = RewardedVideoAd.instance;
    super.initState();

    loadRewardAd();
    createInterstitialAd();

    _rewardedVideoAd.listener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      switch(event){
        case RewardedVideoAdEvent.loaded:
          // TODO: Handle this case.
        print("RewardAd: loaded");
        isRewardVideoLoaded = true;
          break;
        case RewardedVideoAdEvent.failedToLoad:
          // TODO: Handle this case.
          print("RewardAd: loaded");
          isRewardVideoLoaded = false;
          break;
        case RewardedVideoAdEvent.opened:
          // TODO: Handle this case.
          print("RewardAd: opened");
          break;
        case RewardedVideoAdEvent.leftApplication:
          // TODO: Handle this case.
          print("RewardAd: leftApplication");
          break;
        case RewardedVideoAdEvent.closed:
          // TODO: Handle this case.
          print("RewardAd: closed");
          loadRewardAd();
          break;
        case RewardedVideoAdEvent.rewarded:
          // TODO: Handle this case.
          print("RewardAd: rewarded");
          break;
        case RewardedVideoAdEvent.started:
          // TODO: Handle this case.
          print("RewardAd: started");
          break;
        case RewardedVideoAdEvent.completed:
          // TODO: Handle this case.
          print("RewardAd: completed");
          break;
      }
    };
  }

  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }

  loadRewardAd(){
    _rewardedVideoAd.load(adUnitId: RewardedVideoAd.testAdUnitId, targetingInfo: targetingInfo);
  }

  showRewardAd(){
    if(isRewardVideoLoaded){
      _rewardedVideoAd.show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Ads App"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                child: Text('Interstitial Ad'),
                onPressed: () {
                  createInterstitialAd()
                    ..load()
                    ..show();
                },
              ),
              RaisedButton(
                child: Text("Reward Ad"),
                onPressed: () {
                  showRewardAd();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
