import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // App
      'appTitle': 'Food Delivery Compare',
      'home': 'Home',
      'favorites': 'Favorites',
      'settings': 'Settings',
      
      // Home Screen
      'searchHint': 'Search restaurants or cuisines...',
      'filters': 'Filters',
      'results': 'results',
      'noRestaurants': 'No restaurants found',
      'adjustFilters': 'Try adjusting your filters or search',
      'comparing': 'Comparing',
      
      // Filters
      'clearAll': 'Clear All',
      'sortBy': 'Sort By',
      'cuisine': 'Cuisine',
      'all': 'All',
      'minRating': 'Minimum Rating',
      'minDiscount': 'Min Discount',
      'deliveryTime': 'Delivery Time',
      'maxPrice': 'Max Price',
      'deliveryOptions': 'Delivery Options',
      'freeDeliveryOnly': 'Free Delivery Only',
      'providers': 'Providers',
      'cancel': 'Cancel',
      'applyFilters': 'Apply Filters',
      'under': 'Under',
      'upto': 'Up to',
      'min': 'min',
      
      // Sort Options
      'rating': 'Rating',
      'priceLowHigh': 'Price: Low to High',
      'priceHighLow': 'Price: High to Low',
      'discount': 'Discount',
      
      // Comparison Card
      'bestPrice': 'BEST PRICE',
      'exclusive': 'EXCLUSIVE',
      'originalPrice': 'Original Price',
      'deliveryFee': 'Delivery Fee',
      'totalPrice': 'Total Price',
      'free': 'FREE',
      'off': 'OFF',
      'open': 'Open',
      'demo': 'Demo',
      
      // Settings
      'language': 'Language',
      'english': 'English',
      'kurdish': 'کوردی',
      'arabic': 'العربية',
      'theme': 'Theme',
      'lightMode': 'Light Mode',
      'darkMode': 'Dark Mode',
      'systemDefault': 'System Default',
      'about': 'About',
      'version': 'Version',
      'appDescription': 'Compare food delivery prices across Talabat, Toters, and Lezzo in Sulaymaniyah.',
      
      // Cuisines
      'kebab': 'Kebab',
      'traditionalIraqi': 'Traditional Iraqi',
      'kurdishCuisine': 'Kurdish Cuisine',
      'shawarma': 'Shawarma',
      'fastFood': 'Fast Food',
      'pizza': 'Pizza',
      'friedChicken': 'Fried Chicken',
      'grilledFish': 'Grilled Fish',
      'biryani': 'Biryani',
      'falafel': 'Falafel',
      'desserts': 'Desserts',
      'cafe': 'Cafe',
      'juices': 'Juices',
      'healthy': 'Healthy',
      'lahmajun': 'Lahmajun',
      'kubba': 'Kubba',
      'breakfast': 'Breakfast',
      'iceCream': 'Ice Cream',
      'sandwiches': 'Sandwiches',
      'sushi': 'Sushi',
      'chinese': 'Chinese',
      'italian': 'Italian',
      'lebanese': 'Lebanese',
      'salads': 'Salads',
      'vegan': 'Vegan',
      'burgers': 'Burgers',
      'steak': 'Steak',
      'seafood': 'Seafood',
      'fineDining': 'Fine Dining',
    },
    'ku': {
      // App
      'appTitle': 'بەراوردی گەیاندنی خواردن',
      'home': 'ماڵەوە',
      'favorites': 'دڵخوازەکان',
      'settings': 'ڕێکخستنەکان',
      
      // Home Screen
      'searchHint': 'گەڕان بۆ چێشتخانە یان جۆری خواردن...',
      'filters': 'فلتەرەکان',
      'results': 'ئەنجام',
      'noRestaurants': 'هیچ چێشتخانەیەک نەدۆزرایەوە',
      'adjustFilters': 'تکایە فلتەرەکان یان گەڕانەکە بگۆڕە',
      'comparing': 'بەراوردکردن',
      
      // Filters
      'clearAll': 'سڕینەوەی هەموو',
      'sortBy': 'ڕیزکردن بەپێی',
      'cuisine': 'جۆری خواردن',
      'all': 'هەموو',
      'minRating': 'کەمترین هەڵسەنگاندن',
      'minDiscount': 'کەمترین داشکاندن',
      'deliveryTime': 'کاتی گەیاندن',
      'maxPrice': 'زۆرترین نرخ',
      'deliveryOptions': 'هەڵبژاردنەکانی گەیاندن',
      'freeDeliveryOnly': 'گەیاندنی بێبەرامبەر تەنها',
      'providers': 'خزمەتگوزارەکان',
      'cancel': 'پاشگەزبوونەوە',
      'applyFilters': 'جێبەجێکردن',
      'under': 'کەمتر لە',
      'upto': 'تا',
      'min': 'خولەک',
      
      // Sort Options
      'rating': 'هەڵسەنگاندن',
      'priceLowHigh': 'نرخ: کەم بۆ زۆر',
      'priceHighLow': 'نرخ: زۆر بۆ کەم',
      'discount': 'داشکاندن',
      
      // Comparison Card
      'bestPrice': 'باشترین نرخ',
      'exclusive': 'تایبەت',
      'originalPrice': 'نرخی ڕەسەن',
      'deliveryFee': 'کرێی گەیاندن',
      'totalPrice': 'کۆی نرخ',
      'free': 'بێبەرامبەر',
      'off': 'داشکاندن',
      'open': 'کردنەوە',
      'demo': 'تاقیکاری',
      
      // Settings
      'language': 'زمان',
      'english': 'English',
      'kurdish': 'کوردی',
      'arabic': 'العربية',
      'theme': 'ڕووکار',
      'lightMode': 'ڕووناکی',
      'darkMode': 'تاریکی',
      'systemDefault': 'بەپێی سیستەم',
      'about': 'دەربارە',
      'version': 'وەشان',
      'appDescription': 'بەراوردکردنی نرخی گەیاندنی خواردن لە تالابات، تۆتەرز، و لێزۆ لە سلێمانی.',
      
      // Cuisines
      'kebab': 'کەباب',
      'traditionalIraqi': 'خواردنی عێراقی',
      'kurdishCuisine': 'خواردنی کوردی',
      'shawarma': 'شاورما',
      'fastFood': 'خواردنی خێرا',
      'pizza': 'پیتزا',
      'friedChicken': 'مریشکی سوورکراو',
      'grilledFish': 'ماسی بریژاو',
      'biryani': 'بریانی',
      'falafel': 'فەلافل',
      'desserts': 'شیرینی',
      'cafe': 'کافێ',
      'juices': 'شەربەت',
      'healthy': 'تەندروست',
      'lahmajun': 'لحم بعجين',
      'kubba': 'کوبە',
      'breakfast': 'نانی بەیانی',
      'iceCream': 'ئایس کرێم',
      'sandwiches': 'ساندویچ',
      'sushi': 'سوشی',
      'chinese': 'چینی',
      'italian': 'ئیتاڵی',
      'lebanese': 'لوبنانی',
      'salads': 'زەڵاتە',
      'vegan': 'ڤیگن',
      'burgers': 'بەرگر',
      'steak': 'ستەیک',
      'seafood': 'خواردنی دەریایی',
      'fineDining': 'خواردنی گرانبەها',
    },
    'ar': {
      // App
      'appTitle': 'مقارنة توصيل الطعام',
      'home': 'الرئيسية',
      'favorites': 'المفضلة',
      'settings': 'الإعدادات',
      
      // Home Screen
      'searchHint': 'ابحث عن مطاعم أو مأكولات...',
      'filters': 'تصفية',
      'results': 'نتائج',
      'noRestaurants': 'لم يتم العثور على مطاعم',
      'adjustFilters': 'حاول تعديل الفلاتر أو البحث',
      'comparing': 'مقارنة',
      
      // Filters
      'clearAll': 'مسح الكل',
      'sortBy': 'ترتيب حسب',
      'cuisine': 'المطبخ',
      'all': 'الكل',
      'minRating': 'أقل تقييم',
      'minDiscount': 'أقل خصم',
      'deliveryTime': 'وقت التوصيل',
      'maxPrice': 'أقصى سعر',
      'deliveryOptions': 'خيارات التوصيل',
      'freeDeliveryOnly': 'توصيل مجاني فقط',
      'providers': 'مزودي الخدمة',
      'cancel': 'إلغاء',
      'applyFilters': 'تطبيق الفلاتر',
      'under': 'أقل من',
      'upto': 'حتى',
      'min': 'دقيقة',
      
      // Sort Options
      'rating': 'التقييم',
      'priceLowHigh': 'السعر: من الأقل للأعلى',
      'priceHighLow': 'السعر: من الأعلى للأقل',
      'discount': 'الخصم',
      
      // Comparison Card
      'bestPrice': 'أفضل سعر',
      'exclusive': 'حصري',
      'originalPrice': 'السعر الأصلي',
      'deliveryFee': 'رسوم التوصيل',
      'totalPrice': 'الإجمالي',
      'free': 'مجاني',
      'off': 'خصم',
      'open': 'فتح',
      'demo': 'تجريبي',
      
      // Settings
      'language': 'اللغة',
      'english': 'English',
      'kurdish': 'کوردی',
      'arabic': 'العربية',
      'theme': 'المظهر',
      'lightMode': 'الوضع الفاتح',
      'darkMode': 'الوضع الداكن',
      'systemDefault': 'افتراضي النظام',
      'about': 'حول',
      'version': 'الإصدار',
      'appDescription': 'قارن أسعار توصيل الطعام عبر طلبات، توترز، و ليزو في السليمانية.',
      
      // Cuisines
      'kebab': 'كباب',
      'traditionalIraqi': 'عراقي تقليدي',
      'kurdishCuisine': 'مطبخ كردي',
      'shawarma': 'شاورما',
      'fastFood': 'وجبات سريعة',
      'pizza': 'بيتزا',
      'friedChicken': 'دجاج مقلي',
      'grilledFish': 'سمك مشوي',
      'biryani': 'برياني',
      'falafel': 'فلافل',
      'desserts': 'حلويات',
      'cafe': 'مقهى',
      'juices': 'عصائر',
      'healthy': 'صحي',
      'lahmajun': 'لحم بعجين',
      'kubba': 'كبة',
      'breakfast': 'فطور',
      'iceCream': 'آيس كريم',
      'sandwiches': 'سندويشات',
      'sushi': 'سوشي',
      'chinese': 'صيني',
      'italian': 'إيطالي',
      'lebanese': 'لبناني',
      'salads': 'سلطات',
      'vegan': 'نباتي',
      'burgers': 'برغر',
      'steak': 'ستيك',
      'seafood': 'مأكولات بحرية',
      'fineDining': 'فاخر',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? 
           _localizedValues['en']?[key] ?? 
           key;
  }

  bool get isKurdish => locale.languageCode == 'ku';
  bool get isArabic => locale.languageCode == 'ar';
  bool get isRTL => locale.languageCode == 'ku' || locale.languageCode == 'ar';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ku', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
