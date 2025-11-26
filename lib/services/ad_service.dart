import 'dart:async';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdService {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal() {
    _initializeAdTimer();
  }

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;
  int maxFailedLoadAttempts = 3;
  Timer? _adTimer;
  bool _isInitialized = false;
  
  static const int _adIntervalMinutes = 5; // Show ad every 5 minutes
  static const String _lastAdTimestampKey = 'last_ad_timestamp';

  // Test ID for Interstitial Ad
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712'
      : 'ca-app-pub-3940256099942544/4411468910';

  void _initializeAdTimer() async {
    if (_isInitialized) return;
    _isInitialized = true;
    
    // Load last ad timestamp
    final prefs = await SharedPreferences.getInstance();
    final lastAdTimestamp = prefs.getInt(_lastAdTimestampKey);
    
    // Create ad first
    createInterstitialAd();
    
    if (lastAdTimestamp != null) {
      final lastAdTime = DateTime.fromMillisecondsSinceEpoch(lastAdTimestamp);
      final now = DateTime.now();
      final difference = now.difference(lastAdTime);
      
      // If 5 minutes have passed since last ad, show ad after a short delay
      if (difference.inMinutes >= _adIntervalMinutes) {
        Future.delayed(const Duration(seconds: 3), () {
          showInterstitialAd();
        });
      } else {
        // Calculate remaining time until next ad
        final remainingSeconds = (_adIntervalMinutes * 60) - difference.inSeconds;
        
        // Schedule ad to show after remaining time
        Future.delayed(Duration(seconds: remainingSeconds), () {
          createInterstitialAd();
          Future.delayed(const Duration(seconds: 2), () {
            showInterstitialAd();
          });
        });
      }
    } else {
      // First time - show ad after 5 minutes
      Future.delayed(const Duration(minutes: _adIntervalMinutes), () {
        createInterstitialAd();
        Future.delayed(const Duration(seconds: 2), () {
          showInterstitialAd();
        });
      });
    }
    
    // Start periodic timer to check every minute
    _adTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkAndShowAd().catchError((error) {
        // Handle any errors silently
      });
    });
  }

  Future<void> _checkAndShowAd() async {
    final prefs = await SharedPreferences.getInstance();
    final lastAdTimestamp = prefs.getInt(_lastAdTimestampKey);
    
    if (lastAdTimestamp == null) {
      // First time - don't show ad immediately, wait for 5 minutes
      return;
    }
    
    final lastAdTime = DateTime.fromMillisecondsSinceEpoch(lastAdTimestamp);
    final now = DateTime.now();
    final difference = now.difference(lastAdTime);
    
    // Show ad if 5 minutes or more have passed
    if (difference.inMinutes >= _adIntervalMinutes) {
      // Make sure we have an ad loaded
      if (_interstitialAd == null) {
        createInterstitialAd();
        // Wait for ad to load (non-blocking)
        Future.delayed(const Duration(seconds: 2), () {
          if (_interstitialAd != null) {
            showInterstitialAd();
          }
        });
      } else {
        showInterstitialAd();
      }
    }
  }

  void createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  void showInterstitialAd() async {
    if (_interstitialAd == null) {
      createInterstitialAd(); // Try to load for next time
      return;
    }
    
    // Save current timestamp
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastAdTimestampKey, DateTime.now().millisecondsSinceEpoch);
    
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        ad.dispose();
        createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void dispose() {
    _adTimer?.cancel();
    _adTimer = null;
  }
}
