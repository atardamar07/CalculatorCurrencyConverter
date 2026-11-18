import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Interstitials appear only at natural breaks (when the user comes back from
// another screen), at most once per [_minInterval], never on launch, never in
// the first day after install and never during an ad-free day earned with
// rewarded ads. The main screen never shows ads.
class AdService extends ChangeNotifier {
  static final AdService _instance = AdService._internal();
  factory AdService() => _instance;
  AdService._internal();

  static const Duration _minInterval = Duration(minutes: 3);
  static const Duration _adFreePeriod = Duration(hours: 24);
  static const int rewardsForAdFreeDay = 5;

  // Debug builds use Google's test units so we never click our own live ads.
  static const String _adUnitId = kReleaseMode
      ? 'ca-app-pub-1498129057551982/9357968504'
      : 'ca-app-pub-3940256099942544/1033173712';
  // Release: paste the ID of the "Rewarded" unit created in AdMob. While it is
  // empty the "earn an ad-free day" option stays hidden.
  static const String _rewardedUnitId = kReleaseMode
      ? ''
      : 'ca-app-pub-3940256099942544/5224354917';

  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool _adsRemoved = false; // set by PurchaseService
  bool _started = false;
  bool _privacyOptionsRequired = false;
  DateTime _lastShown = DateTime.now(); // app start counts as a shown ad: none on launch
  DateTime? _firstLaunch;
  DateTime? _adFreeUntil;
  int _rewardsWatched = 0;

  bool get adsRemoved => _adsRemoved;
  bool get privacyOptionsRequired => _privacyOptionsRequired;
  bool get rewardedAvailable => _rewardedUnitId.isNotEmpty;
  int get rewardsWatched => _rewardsWatched;
  DateTime? get adFreeUntil {
    final until = _adFreeUntil;
    return until != null && DateTime.now().isBefore(until) ? until : null;
  }

  // First day after install or an earned ad-free day: no interstitials.
  bool get inQuietPeriod {
    final first = _firstLaunch;
    return first == null || DateTime.now().difference(first) < _adFreePeriod || adFreeUntil != null;
  }

  // Asks for consent where the law requires it (EEA/UK), then starts the SDK.
  void init() {
    loadState();
    ConsentInformation.instance.requestConsentInfoUpdate(
      ConsentRequestParameters(),
      () {
        if (_adsRemoved) return; // paying users are never asked about ads
        ConsentForm.loadAndShowConsentFormIfRequired((_) => _startIfAllowed());
      },
      (_) => _startIfAllowed(),
    );
    _startIfAllowed(); // consent given in an earlier session is enough to start now
  }

  @visibleForTesting
  Future<void> loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final first = prefs.getInt('first_launch_at');
    if (first == null) {
      await prefs.setInt('first_launch_at', DateTime.now().millisecondsSinceEpoch);
    }
    _firstLaunch = first == null ? DateTime.now() : DateTime.fromMillisecondsSinceEpoch(first);
    final until = prefs.getInt('ad_free_until');
    _adFreeUntil = until == null ? null : DateTime.fromMillisecondsSinceEpoch(until);
    _rewardsWatched = prefs.getInt('rewarded_watched') ?? 0;
    notifyListeners();
  }

  Future<void> _startIfAllowed() async {
    _privacyOptionsRequired = await ConsentInformation.instance.getPrivacyOptionsRequirementStatus() ==
        PrivacyOptionsRequirementStatus.required;
    notifyListeners();
    if (!await ConsentInformation.instance.canRequestAds() || _started || _adsRemoved) return;
    _started = true;
    await MobileAds.instance.initialize();
    _load();
    _loadRewarded();
  }

  // Lets users change their ad consent (shown in the drawer when required).
  void showPrivacyOptions() {
    ConsentForm.showPrivacyOptionsForm((_) {});
  }

  void setAdsRemoved(bool removed) {
    _adsRemoved = removed;
    if (removed) {
      _interstitialAd?.dispose();
      _interstitialAd = null;
      _rewardedAd?.dispose();
      _rewardedAd = null;
    }
    notifyListeners();
  }

  void _load() {
    if (!_started || _adsRemoved || inQuietPeriod || _interstitialAd != null) return;
    InterstitialAd.load(
      adUnitId: _adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          if (_adsRemoved) {
            ad.dispose();
          } else {
            _interstitialAd = ad;
          }
        },
        onAdFailedToLoad: (error) => _interstitialAd = null, // retried at the next transition
      ),
    );
  }

  // Call when the user returns from another screen.
  void showAtTransition() {
    if (_adsRemoved || inQuietPeriod) return;
    final ad = _interstitialAd;
    if (ad == null) {
      _load();
      return;
    }
    if (DateTime.now().difference(_lastShown) < _minInterval) return;
    _interstitialAd = null;
    _lastShown = DateTime.now();
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _load();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _load();
      },
    );
    ad.show();
  }

  void _loadRewarded() {
    if (!_started || _adsRemoved || !rewardedAvailable || _rewardedAd != null) return;
    RewardedAd.load(
      adUnitId: _rewardedUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) => _rewardedAd = ad,
        onAdFailedToLoad: (error) => _rewardedAd = null,
      ),
    );
  }

  // The user chose to watch a rewarded ad. Returns false when none is ready.
  bool showRewardedAd() {
    final ad = _rewardedAd;
    if (ad == null) {
      _loadRewarded();
      return false;
    }
    _rewardedAd = null;
    ad.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _loadRewarded();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _loadRewarded();
      },
    );
    // The reward only arrives if the ad was watched to the end.
    ad.show(onUserEarnedReward: (_, _) => grantReward());
    return true;
  }

  // Every [rewardsForAdFreeDay] watched rewarded ads give 24 hours without interstitials.
  @visibleForTesting
  Future<void> grantReward() async {
    _rewardsWatched++;
    if (_rewardsWatched >= rewardsForAdFreeDay) {
      _rewardsWatched = 0;
      // The earned day starts when the ad-free first day is over, not inside it.
      final now = DateTime.now();
      final firstDayEnd = _firstLaunch?.add(_adFreePeriod);
      final start = firstDayEnd != null && firstDayEnd.isAfter(now) ? firstDayEnd : now;
      _adFreeUntil = start.add(_adFreePeriod);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('rewarded_watched', _rewardsWatched);
    final until = _adFreeUntil;
    if (until != null) await prefs.setInt('ad_free_until', until.millisecondsSinceEpoch);
  }
}
