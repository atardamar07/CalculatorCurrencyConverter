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
  bool _isAdShowing = false;
  bool _adsRemoved = false; // Track if user purchased "Remove Ads"
  
  static const int _adIntervalMinutes = 2;
  static const String _lastAdDismissedTimestampKey = 'last_ad_dismissed_timestamp';

  // Real AdMob Ad Unit ID
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-1498129057551982/9357968504'
      : 'ca-app-pub-1498129057551982/9357968504';

  // Check if ads are removed
  bool get adsRemoved => _adsRemoved;

  // Set ads removed status (called from PurchaseService)
  void setAdsRemoved(bool removed) {
    _adsRemoved = removed;
    if (removed) {
      // Cancel timer and dispose ads
      _adTimer?.cancel();
      _adTimer = null;
      _interstitialAd?.dispose();
      _interstitialAd = null;
    }
  }

  void _initializeAdTimer() async {
    if (_isInitialized) return;
    _isInitialized = true;
    
    // Check if ads are removed
    final prefs = await SharedPreferences.getInstance();
    _adsRemoved = prefs.getBool('ads_removed') ?? false;
    
    if (_adsRemoved) {
      return; // Don't show ads
    }
    
    final lastAdDismissedTimestamp = prefs.getInt(_lastAdDismissedTimestampKey);
    
    createInterstitialAd();
    
    if (lastAdDismissedTimestamp != null) {
      final lastAdDismissedTime = DateTime.fromMillisecondsSinceEpoch(lastAdDismissedTimestamp);
      final now = DateTime.now();
      final difference = now.difference(lastAdDismissedTime);
      
      if (difference.inSeconds >= (_adIntervalMinutes * 60)) {
        Future.delayed(const Duration(seconds: 3), () {
          if (!_isAdShowing && !_adsRemoved) {
            showInterstitialAd();
          }
        });
      } else {
        final remainingSeconds = (_adIntervalMinutes * 60) - difference.inSeconds;
        
        Future.delayed(Duration(seconds: remainingSeconds), () {
          if (!_isAdShowing && !_adsRemoved) {
            createInterstitialAd();
            Future.delayed(const Duration(seconds: 2), () {
              if (!_isAdShowing && _interstitialAd != null && !_adsRemoved) {
                showInterstitialAd();
              }
            });
          }
        });
      }
    } else {
      Future.delayed(const Duration(minutes: _adIntervalMinutes), () {
        if (!_isAdShowing && !_adsRemoved) {
          createInterstitialAd();
          Future.delayed(const Duration(seconds: 2), () {
            if (!_isAdShowing && _interstitialAd != null && !_adsRemoved) {
              showInterstitialAd();
            }
          });
        }
      });
    }
    
    _adTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (!_adsRemoved) {
        _checkAndShowAd().catchError((error) {});
      }
    });
  }

  Future<void> _checkAndShowAd() async {
    if (_isAdShowing || _adsRemoved) {
      return;
    }
    
    final prefs = await SharedPreferences.getInstance();
    final lastAdDismissedTimestamp = prefs.getInt(_lastAdDismissedTimestampKey);
    
    if (lastAdDismissedTimestamp == null) {
      return;
    }
    
    final lastAdDismissedTime = DateTime.fromMillisecondsSinceEpoch(lastAdDismissedTimestamp);
    final now = DateTime.now();
    final difference = now.difference(lastAdDismissedTime);
    
    if (difference.inSeconds >= (_adIntervalMinutes * 60)) {
      if (_interstitialAd == null) {
        createInterstitialAd();
        Future.delayed(const Duration(seconds: 2), () {
          if (_interstitialAd != null && !_isAdShowing && !_adsRemoved) {
            showInterstitialAd();
          }
        });
      } else {
        showInterstitialAd();
      }
    }
  }

  void createInterstitialAd() {
    if (_adsRemoved) return;
    
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
    if (_isAdShowing || _adsRemoved) {
      return;
    }
    
    if (_interstitialAd == null) {
      createInterstitialAd();
      return;
    }
    
    _isAdShowing = true;
    
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {},
      onAdDismissedFullScreenContent: (InterstitialAd ad) async {
        _isAdShowing = false;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(_lastAdDismissedTimestampKey, DateTime.now().millisecondsSinceEpoch);
        
        ad.dispose();
        _interstitialAd = null;
        if (!_adsRemoved) {
          createInterstitialAd();
        }
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        _isAdShowing = false;
        ad.dispose();
        _interstitialAd = null;
        if (!_adsRemoved) {
          createInterstitialAd();
        }
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
