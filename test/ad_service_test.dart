import 'package:calculator_currency_converter/services/ad_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<AdService> adsInstalledAgo(Duration age) async {
  SharedPreferences.setMockInitialValues({
    'first_launch_at': DateTime.now().subtract(age).millisecondsSinceEpoch,
  });
  final ads = AdService();
  await ads.loadState();
  return ads;
}

void main() {
  test('no interstitials in the first day after install', () async {
    expect((await adsInstalledAgo(const Duration(hours: 2))).inQuietPeriod, isTrue);
    expect((await adsInstalledAgo(const Duration(days: 2))).inQuietPeriod, isFalse);
  });

  test('fresh install records its first launch', () async {
    SharedPreferences.setMockInitialValues({});
    final ads = AdService();
    await ads.loadState();
    expect(ads.inQuietPeriod, isTrue);
    expect((await SharedPreferences.getInstance()).getInt('first_launch_at'), isNotNull);
  });

  test('five rewarded ads give a saved ad-free day and reset the counter', () async {
    final ads = await adsInstalledAgo(const Duration(days: 2));
    for (var i = 0; i < AdService.rewardsForAdFreeDay - 1; i++) {
      await ads.grantReward();
    }
    expect(ads.rewardsWatched, AdService.rewardsForAdFreeDay - 1);
    expect(ads.inQuietPeriod, isFalse);

    await ads.grantReward();
    expect(ads.rewardsWatched, 0);
    expect(ads.inQuietPeriod, isTrue);
    expect(ads.adFreeUntil!.difference(DateTime.now()).inHours, inInclusiveRange(23, 24));
    expect((await SharedPreferences.getInstance()).getInt('ad_free_until'), isNotNull);
  });

  test('a day earned during the ad-free first day starts when that day ends', () async {
    final ads = await adsInstalledAgo(const Duration(hours: 1));
    for (var i = 0; i < AdService.rewardsForAdFreeDay; i++) {
      await ads.grantReward();
    }
    // 23 hours of first day left, then the earned 24
    expect(ads.adFreeUntil!.difference(DateTime.now()).inHours, inInclusiveRange(46, 47));
  });
}
