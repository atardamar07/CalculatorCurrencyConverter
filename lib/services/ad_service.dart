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
  bool _isAdShowing = false; // Track if ad is currently showing
  
  static const int _adIntervalMinutes = 2; // Show ad every 2 minutes
  static const String _lastAdDismissedTimestampKey = 'last_ad_dismissed_timestamp';

  // Real AdMob Ad Unit ID
  final String _adUnitId = Platform.isAndroid
      ? 'ca-app-pub-1498129057551982/9357968504'
      : 'ca-app-pub-1498129057551982/9357968504'; // iOS ID (same for now)

  void _initializeAdTimer() async {
    if (_isInitialized) return;
    _isInitialized = true;
    
    // Load last ad dismissed timestamp (when user closed the ad)
    final prefs = await SharedPreferences.getInstance();
    final lastAdDismissedTimestamp = prefs.getInt(_lastAdDismissedTimestampKey);
    
    // Create ad first
    createInterstitialAd();
    
    if (lastAdDismissedTimestamp != null) {
      final lastAdDismissedTime = DateTime.fromMillisecondsSinceEpoch(lastAdDismissedTimestamp);
      final now = DateTime.now();
      final difference = now.difference(lastAdDismissedTime);
      
      // If 2 minutes have passed since last ad was dismissed, show ad after a short delay
      if (difference.inSeconds >= (_adIntervalMinutes * 60)) {
        Future.delayed(const Duration(seconds: 3), () {
          if (!_isAdShowing) {
            showInterstitialAd();
          }
        });
      } else {
        // Calculate remaining time until next ad (in seconds for 2 minutes)
        final remainingSeconds = (_adIntervalMinutes * 60) - difference.inSeconds;
        
        // Schedule ad to show after remaining time
        Future.delayed(Duration(seconds: remainingSeconds), () {
          if (!_isAdShowing) {
            createInterstitialAd();
            Future.delayed(const Duration(seconds: 2), () {
              if (!_isAdShowing && _interstitialAd != null) {
                showInterstitialAd();
              }
            });
          }
        });
      }
    } else {
      // First time - show ad after 2 minutes
      Future.delayed(const Duration(minutes: _adIntervalMinutes), () {
        if (!_isAdShowing) {
          createInterstitialAd();
          Future.delayed(const Duration(seconds: 2), () {
            if (!_isAdShowing && _interstitialAd != null) {
              showInterstitialAd();
            }
          });
        }
      });
    }
    
    // Start periodic timer to check every 30 seconds (more frequent for 2 minute interval)
    _adTimer = Timer.periodic(const Duration(seconds: 30), (timer) {
      _checkAndShowAd().catchError((error) {
        // Handle any errors silently
      });
    });
  }

  Future<void> _checkAndShowAd() async {
    // Don't show ad if one is already showing
    if (_isAdShowing) {
      return;
    }
    
    final prefs = await SharedPreferences.getInstance();
    final lastAdDismissedTimestamp = prefs.getInt(_lastAdDismissedTimestampKey);
    
    if (lastAdDismissedTimestamp == null) {
      // First time - don't show ad immediately, wait for 2 minutes
      return;
    }
    
    final lastAdDismissedTime = DateTime.fromMillisecondsSinceEpoch(lastAdDismissedTimestamp);
    final now = DateTime.now();
    final difference = now.difference(lastAdDismissedTime);
    
    // Show ad only if 2 minutes or more have passed since last ad was dismissed
    if (difference.inSeconds >= (_adIntervalMinutes * 60)) {
      // Make sure we have an ad loaded
      if (_interstitialAd == null) {
        createInterstitialAd();
        // Wait for ad to load (non-blocking)
        Future.delayed(const Duration(seconds: 2), () {
          if (_interstitialAd != null && !_isAdShowing) {
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
    // Don't show if ad is already showing
    if (_isAdShowing) {
      return;
    }
    
    if (_interstitialAd == null) {
      createInterstitialAd(); // Try to load for next time
      return;
    }
    
    // Mark that ad is showing
    _isAdShowing = true;
    
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) {
        // Ad is now showing
      },
      onAdDismissedFullScreenContent: (InterstitialAd ad) async {
        // User closed the ad - save timestamp and reset flag
        _isAdShowing = false;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt(_lastAdDismissedTimestampKey, DateTime.now().millisecondsSinceEpoch);
        
        ad.dispose();
        _interstitialAd = null;
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        // Ad failed to show - reset flag
        _isAdShowing = false;
        ad.dispose();
        _interstitialAd = null;
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
