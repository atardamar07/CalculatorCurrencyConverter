# Calculator & Currency

Tek ekranda hesap makinesi (standart + bilimsel) ve döviz çevirici. Android, Flutter.
Paket: `com.minicoreapps.calculator`

- Kurlar: [ExchangeRate-API](https://www.exchangerate-api.com) açık uç noktası (USD tabanlı, günde bir güncellenir, cihazda önbelleğe alınır, atıf zorunlu).
- Reklam: AdMob tam ekran reklam yalnızca başka bir ekrandan dönerken çıkar; en fazla 3 dakikada bir, kurulumdan sonraki ilk 24 saatte hiç çıkmaz. Ana ekranda hiç reklam yok.
  - Ödüllü reklam: kullanıcı isterse 5 kısa reklam izler ve 24 saat reklamsız kullanır.
  - AB/UK için Google onay formu (UMP) var.
  - Debug derlemeler Google'ın test reklamlarını gösterir.
- Satın alma: `remove_ads` (tek seferlik) reklamları kaldırır.
- Diller: 30 dil (`lib/l10n/*.arb`, `flutter gen-l10n` ile üretilir). Para birimi adları telefonun dilinde Android'den gelir (`MainActivity.kt`).
- Gizlilik politikası: [`docs/privacy-policy.md`](docs/privacy-policy.md), GitHub Pages ile yayınlanır.

## Geliştirme

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

## Yayın (Google Play)

Her sürümde:
1. `pubspec.yaml` içindeki `version` değerini artır (`+` sonrası sayı her yüklemede büyümeli) ve aynı sürümü `lib/widgets/app_drawer.dart` içindeki `appVersion` sabitine yaz.
2. `flutter build appbundle --release --obfuscate --split-debug-info=build/symbols` çalıştır. Çıkan `build/app/outputs/bundle/release/app-release.aab` dosyasını Play Console'a yükle.
3. `build/symbols` klasörünü o sürüm için sakla; çökme raporlarını okumak için gerekir.

İmzalama `android/key.properties` ve `android/app/upload-keystore.jks` ile yapılır. İkisi de git dışındadır; **ikisini de şifreleriyle birlikte güvenli bir yere yedekle.**

### İlk yayından önce bir kez yapılacaklar
- **GitHub Pages:** Repo public olmalı. Settings → Pages → Branch: `main`, klasör: `/docs`. Ardından https://atardamar07.github.io/CalculatorCurrencyConverter/privacy-policy adresinin açıldığını kontrol et.
- **AdMob:**
  - Privacy & messaging → European regulations bölümünde GDPR mesajı oluşturup yayınla. Bu yapılmazsa onay formu hiç çıkmaz.
  - Bir **Ödüllü** reklam birimi oluştur ve ID'sini `lib/services/ad_service.dart` içindeki `_rewardedUnitId` sabitine yaz. ID boş kaldıkça "Reklamsız gün kazan" seçeneği gizli kalır.
  - Uygulama mağazada yayınlanınca AdMob'da Play Store sayfasına bağla.
  - `app-ads.txt`: GitHub'da `atardamar07.github.io` adında bir repo aç, köküne `app-ads.txt` koy. İçeriği tek satır: `google.com, pub-1498129057551982, DIRECT, f08c47fec0942fa0`. Play mağaza sayfasındaki web sitesi alanına `https://atardamar07.github.io` yaz.
- **Fiyat:** Play Console → Para kazanma → Uygulama içi ürünler → `remove_ads`.
  - Varsayılan fiyatı USD olarak gir (öneri $2.99); Play diğer ülkeler için yerel fiyat önerir.
  - Satın alma gücü düşük ülkelerde elle düşür (≈ $0.99–1.49).
  - "Fiyat denemeleri" ile farklı fiyatları karşılaştır.
- **Play Console:**
  - Para kazanma → Uygulama içi ürünler bölümünde `remove_ads` tek seferlik ürününü oluştur ve etkinleştir.
  - Uygulama içeriği:
    - Gizlilik politikası URL'si: yukarıdaki adres.
    - Reklamlar: Evet.
    - Reklam kimliği: Evet, reklamlar için.
    - Hedef kitle: 13+ veya 18+. 13 yaş altını seçmek Families politikasını devreye sokar.
    - İçerik derecelendirmesi anketi.
  - Veri güvenliği formu:
    - AdMob tarafından toplananlar: cihaz veya diğer kimlikler, uygulama etkileşimleri, tanılama bilgileri, yaklaşık konum.
    - Google Play tarafından: satın alma geçmişi.
    - Veriler aktarım sırasında şifrelenir. Hesap olmadığı için hesap silme gerekmez.
  - Mağaza sayfası: metinler [`docs/store-listing.md`](docs/store-listing.md) içinde. İkon, öne çıkan görsel ve ekran görüntüleri [`docs/store/`](docs/store) klasöründe.
  - Önemli sıra: önce internal testing'e bir AAB yükle; uygulama içi ürün ancak ondan sonra oluşturulabiliyor.
- **Kapalı test:** Kişisel geliştirici hesabı 13 Kasım 2023'ten sonra açıldıysa, üretime çıkmadan önce en az 12 test kullanıcısıyla 14 gün kapalı test gerekir.
- **Satın almayı dene:** Ürünler ve mağaza fiyatı ancak uygulama bir test kanalına (internal testing) yüklenince görünür. Test hesabıyla satın al → reklamlar hemen kalkmalı. Uygulamayı yeniden kur → "Satın Alımları Geri Yükle" çalışmalı.
