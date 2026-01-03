import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';
import 'providers/favorites_provider.dart';
import 'screens/main_screen.dart';
import 'theme/app_theme.dart';
import 'localization/app_localizations.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
        ChangeNotifierProvider(create: (context) => FavoritesProvider()),
      ],
      child: const FoodCompareApp(),
    ),
  );
}

class FoodCompareApp extends StatelessWidget {
  const FoodCompareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, LanguageProvider>(
      builder: (context, themeProvider, languageProvider, child) {
        return MaterialApp(
          title: 'Food Delivery Compare',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.themeMode,
          // Always use English locale for Flutter's Material widgets
          // since Kurdish/Arabic might have issues with some widgets default localizations
          // or just to be safe as per previous fix, but Arabic IS supported by GlobalMaterialLocalizations
          // However for consistency and since the user had issues, let's keep English for Material 
          // BUT wait, Arabic is fully supported by Flutter. Kurdish is the one not supported.
          // So we should allow 'ar' to pass through.
          locale: const Locale('en'), 
          // Actually, let's try to support 'ar' properly for MaterialLocalizations if possible.
          // If I force 'en', then Arab date pickers etc will be in English.
          // But previously I forced 'en' to fix a crash.
          // Let's keep it simple: Use 'en' for Material to avoid crashes, use custom for App strings.
          supportedLocales: const [
            Locale('en'),
          ],
          localizationsDelegates: [
            _AppLocalizationsWithLanguageProvider(languageProvider.locale),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          builder: (context, child) {
            return Directionality(
              textDirection: languageProvider.isRTL ? TextDirection.rtl : TextDirection.ltr,
              child: child!,
            );
          },
          home: const MainScreen(),
        );
      },
    );
  }
}

class _AppLocalizationsWithLanguageProvider extends LocalizationsDelegate<AppLocalizations> {
  final Locale userLocale;
  
  _AppLocalizationsWithLanguageProvider(this.userLocale);
  
  @override
  bool isSupported(Locale locale) => true;
  
  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(userLocale);
  }
  
  @override
  bool shouldReload(_AppLocalizationsWithLanguageProvider old) {
    return old.userLocale != userLocale;
  }
}
