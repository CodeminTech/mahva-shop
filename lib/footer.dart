import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildContactFooter() {
  return Container(
    height: 120,
    decoration: BoxDecoration(
      color: Color(0xffc4fbf5),
      borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 15,
          offset: const Offset(0, -5),
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                final Uri url = Uri(scheme: 'tel', path: '09965551306');
                if (await canLaunchUrl(url)) await launchUrl(url);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24, // کمی بیشتر کردیم که جا برای آیکون باز بشه
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff18cbb5),
                      const Color.fromARGB(255, 75, 92, 90),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 5,
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 6,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize:
                      MainAxisSize.min, // دکمه فقط به اندازه محتوا بزرگ بشه
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons
                          .phone_in_talk, // یا Icons.call یا Icons.phone_in_talk
                      color: Colors.white,
                      size: 20, // کوچیک و مناسب دکمه
                    ),
                    const SizedBox(width: 10), // فاصله بین آیکون و متن
                    const Text(
                      'تماس بگیرید',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Vazir',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _socialIcon(
                'assets/images/whatsapp.png',
                'https://wa.me/989965551306', // واتساپ (شماره بدون صفر)
              ),
              _socialIcon(
                'assets/images/telegram.png',
                'https://t.me/YourTelegramChannel', // لینک کانال یا آیدی واقعی
              ),
              _socialIcon(
                'assets/images/robika.png',
                'https://rubika.ir/YourRubikaID', // آیدی روبیکا
              ),
              _socialIcon(
                'assets/images/instagram.png',
                'https://instagram.com/YourInstagramUsername', // نام کاربری اینستاگرام
              ),
              _socialIcon(
                'assets/images/eita.png',
                'https://eitaa.com/YourEitaaChannel', // لینک ایتا
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _socialIcon(String asset, String url) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: () async {
        final Uri uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: Color(0xff18cbb5),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.grey,
              blurRadius: 6,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Center(
          child: Image.asset(asset, width: 20, height: 20, color: Colors.white),
        ),
      ),
    ),
  );
}
