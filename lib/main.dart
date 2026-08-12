import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mahva_shop/splash_screen.dart';
import 'package:persian_fonts/persian_fonts.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // شفاف بذار تا گرادیانت دیده بشه
      statusBarIconBrightness:
          Brightness.light, // آیکون‌ها سفید بشن (برای هدر تیره)
      statusBarBrightness: Brightness.dark, // برای iOS
      systemNavigationBarColor: Colors.transparent, // نوار پایین هم شفاف
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: PersianFonts
            .shabnamTextTheme, // یا samimTextTheme یا sahelTextTheme
        fontFamily: 'Shabnam', // fallback
      ),
      restorationScopeId:
          'app', // <--- این خط رو اضافه کن (هر رشته‌ای می‌تونی بذاری)
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // صفحه اصلیت
    );
  }
}
