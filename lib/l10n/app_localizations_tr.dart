// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'Viikkonro';

  @override
  String get wordmark => 'Viikko nyt';

  @override
  String get home => 'Ana sayfa';

  @override
  String get weeks => 'Haftalar';

  @override
  String get calendar => 'Takvim';

  @override
  String get tools => 'Hesaplayıcılar';

  @override
  String get more => 'Daha fazla';

  @override
  String get settings => 'Ayarlar';

  @override
  String get eyebrow => 'HAFTA NUMARASI ARACI';

  @override
  String get homeTitle => 'Hangi haftadayız?';

  @override
  String get homeLead => 'Hafta numaraları, tarihler ve önemli takvim günleri tek bir yerde.';

  @override
  String get rightNow => 'TAM ŞU AN';

  @override
  String get week => 'Hafta';

  @override
  String weekLabel(int number) {
    return 'Hafta $number';
  }

  @override
  String weekShort(int number) {
    return 'Hf $number';
  }

  @override
  String yearLabel(int number) {
    return 'Yıl $number';
  }

  @override
  String weekOf(int current, int total) {
    return 'Hafta $current / $total';
  }

  @override
  String yearProgress(int percent) {
    return 'Yılın % $percent kadarı geçti';
  }

  @override
  String get weeksTotal => '52/53 hafta';

  @override
  String get previous => 'Önceki';

  @override
  String get next => 'Sonraki';

  @override
  String get today => 'Bugün';

  @override
  String get thisWeek => 'Bu hafta';

  @override
  String get thisMonth => 'Bu ay';

  @override
  String get thisYear => 'Bu yıl';

  @override
  String get lookupTitle => 'Herhangi bir tarihin hafta numarasını bulun';

  @override
  String get chooseDate => 'Tarih seçin';

  @override
  String get dateToWeek => 'Tarihten haftaya';

  @override
  String get weekToDate => 'Haftadan tarihlere';

  @override
  String get weekdayCalculator => 'Haftanın günü';

  @override
  String get openWeek => 'Hafta ayrıntılarını aç';

  @override
  String get year => 'Yıl';

  @override
  String get month => 'Ay';

  @override
  String get weekNumber => 'Hafta numarası';

  @override
  String get dayOfYear => 'Yılın günü';

  @override
  String get daysRemaining => 'Kalan gün';

  @override
  String get quarter => 'Çeyrek';

  @override
  String quarterLabel(int number) {
    return '$number. çeyrek';
  }

  @override
  String get weekRange => 'Pazartesiden pazara';

  @override
  String dayCount(int count) {
    return '$count gün';
  }

  @override
  String weekDaysResult(int weeks, int days) {
    return '$weeks hafta ve $days gün';
  }

  @override
  String get holidays => 'Resmî tatiller';

  @override
  String get flagDays => 'Bayrak günleri';

  @override
  String get schoolHolidays => 'Okul tatilleri';

  @override
  String get nextHoliday => 'Sonraki resmî tatil';

  @override
  String get noEvents => 'Anma günü yok';

  @override
  String get official => 'Resmî tatil';

  @override
  String get observance => 'Anma günü';

  @override
  String get all => 'Tümü';

  @override
  String get confirmed => 'Onaylandı';

  @override
  String get estimated => 'tahmini';

  @override
  String get unknown => 'Henüz yayımlanmadı';

  @override
  String get noSchoolData => 'Bu yıl için yayımlanmış okul tatili verisi yok.';

  @override
  String get schoolCoverage => 'Okulunuzun tarihleri belediye takviminden farklı olabilir.';

  @override
  String get winterBreak => 'Yarıyıl tatili';

  @override
  String get autumnBreak => 'Sonbahar tatili';

  @override
  String get city => 'Şehir';

  @override
  String get source => 'Kaynak';

  @override
  String verifiedAt(String date) {
    return '$date tarihinde doğrulandı';
  }

  @override
  String get daysBetween => 'İki tarih arasındaki günler';

  @override
  String get workingDaysBetween => 'İş günü hesaplayıcı';

  @override
  String get workingDays => 'İş günleri';

  @override
  String get weekends => 'Hafta sonları';

  @override
  String get weekdayHolidays => 'Hafta içi resmî tatiller';

  @override
  String get totalDays => 'Toplam gün';

  @override
  String get firstDate => 'Başlangıç tarihi';

  @override
  String get lastDate => 'Bitiş tarihi';

  @override
  String get invalidRange => 'Bitiş tarihi, başlangıç tarihiyle aynı veya ondan sonra olmalıdır.';

  @override
  String get distanceNote => 'Sonuç, tarihler arasındaki mesafedir. Sıra önemli değildir.';

  @override
  String get workingNote => 'Her iki tarih de sayılır. İş günleri, resmî tatiller hariç pazartesiden cumaya kadardır. Noel arifesi ve yaz ortası arifesi iş günü sayılır.';

  @override
  String get yearWeeks => 'Yılın tüm haftaları';

  @override
  String get yearCalendar => 'Yıllık takvim';

  @override
  String get firstHalf => 'İlk yarıyıl';

  @override
  String get secondHalf => 'İkinci yarıyıl';

  @override
  String get wholeYear => 'Tüm yıl';

  @override
  String get yearWorkingDays => 'Yıllık iş günleri';

  @override
  String get monthWorkingDays => 'Aylık iş günleri';

  @override
  String get share => 'Paylaş';

  @override
  String get openWebsite => 'Web sitesini aç';

  @override
  String get copy => 'Kopyala';

  @override
  String get copied => 'Kopyalandı';

  @override
  String get printPdf => 'Yazdır / PDF kaydet';

  @override
  String get exportCsv => 'CSV dışa aktar';

  @override
  String get exportCalendar => 'Takvimi dışa aktar (.ics)';

  @override
  String get exportFailed => 'Dışa aktarma başarısız oldu. Tekrar deneyin.';

  @override
  String get openFailed => 'Bağlantı açılamadı.';

  @override
  String get language => 'Dil';

  @override
  String get finnish => 'Fince';

  @override
  String get english => 'İngilizce';

  @override
  String get theme => 'Görünüm';

  @override
  String get system => 'Sistem';

  @override
  String get light => 'Açık';

  @override
  String get dark => 'Koyu';

  @override
  String get firstScreen => 'Başlangıç ekranı';

  @override
  String get privacyNote => 'Çevrimdışı çalışır. Hesap yok, analiz yok, reklam yok.';

  @override
  String get dataCoverage => 'Takvim verileri: 2020–2035. Okul tatilleri yalnızca yayımlanmış yıllar için mevcuttur.';

  @override
  String get about => 'Uygulama hakkında';

  @override
  String get licenses => 'Açık kaynak lisansları';

  @override
  String get info => 'Hafta numaraları hakkında';

  @override
  String get faq => 'Sık sorulan sorular';

  @override
  String get methodology => 'Yöntem';

  @override
  String get sources => 'Veri kaynakları';

  @override
  String get editorial => 'Yayın ilkeleri';

  @override
  String get usComparison => 'Finlandiya ve ABD';

  @override
  String get isoWeek => 'ISO haftası';

  @override
  String get usWeek => 'ABD haftası';

  @override
  String get isoExplanation => 'Hafta pazartesi başlar. Yılın ilk ISO haftası 4 Ocak’ı içerir. ISO hafta yılı takvim yılından farklı olabilir.';

  @override
  String get openData => 'Açık veri';

  @override
  String get dataExplorer => 'Takvim verilerini incele';

  @override
  String get bundledData => 'Birlikte gelen veri kümesi';

  @override
  String get dataCopyNote => 'Seçili yılı JSON olarak kopyalayın.';

  @override
  String get websiteResources => 'Web sitesinde daha fazlası';

  @override
  String get websiteResourcesNote => 'Web sitesinin diğer hizmetleri tarayıcıda açılır ve internet bağlantısı gerektirir.';

  @override
  String get contact => 'İletişim';

  @override
  String get privacy => 'Gizlilik';

  @override
  String get terms => 'Koşullar';

  @override
  String get timeManagement => 'Zaman yönetimi';

  @override
  String get sun => 'Helsinki’de güneş';

  @override
  String get sunrise => 'Gün doğumu';

  @override
  String get sunset => 'Gün batımı';

  @override
  String get daylight => 'Gün uzunluğu';

  @override
  String get polarDay => 'Gece yarısı güneşi';

  @override
  String get polarNight => 'Kutup gecesi';

  @override
  String hoursMinutes(int hours, int minutes) {
    return '$hours sa $minutes dk';
  }

  @override
  String get weekNotes => 'Hafta notu';

  @override
  String get noteHint => 'Bu hafta için bir not yazın…';

  @override
  String get saved => 'Bu cihaza kaydedildi';

  @override
  String get save => 'Kaydet';

  @override
  String get cancel => 'İptal';

  @override
  String get notFound => 'Sayfa bulunamadı';

  @override
  String get outOfRange => '2020 ile 2035 arasında bir yıl seçin.';

  @override
  String get backHome => 'Ana sayfaya dön';

  @override
  String get loadingError => 'Takvim verileri yüklenemedi.';

  @override
  String get retry => 'Yeniden dene';

  @override
  String get menu => 'Menüyü aç';

  @override
  String get dayDetails => 'Gün ayrıntıları';

  @override
  String get close => 'Kapat';

  @override
  String get holidayRule => 'Tarih kuralı';

  @override
  String get fiContent => 'Web sitesinin kaynak materyali Fincedir.';

  @override
  String get nameDaysUnavailable => 'İsim günleri, lisans doğrulandıktan sonra eklenecektir.';

  @override
  String get weekList => 'Hafta listesi';
}
