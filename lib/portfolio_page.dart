import 'package:flutter/material.dart';
import 'package:mahva_shop/footer.dart';
import 'package:mahva_shop/home_page.dart';

class PortfolioPage extends StatelessWidget {
  final String productName;

  const PortfolioPage({Key? key, required this.productName}) : super(key: key);

  final List<Map<String, String>> samples = const [
    {
      'image': 'assets/images/shop_window.jpg',
      'title': 'نمونه ۱ -تابلو فرش عمودی',
      'desc': 'تابلو فرش شخصی‌سازی‌شده با عکس دلخواه',
    },
    {
      'image': 'assets/images/shop_window.jpg',
      'title': 'نمونه ۲ - طرح عاشقانه',
      'desc': ' قاب قلب بزرگ Love',
    },
    {
      'image': 'assets/images/shop_window.jpg',
      'title': 'نمونه ۳ - ماگ تولد',
      'desc': 'ماگ با چاپ عکس و متن تبریک',
    },
    {
      'image': 'assets/images/shop_window.jpg',
      'title': 'نمونه ۴ - مجسمه شخصی',
      'desc': 'مجسمه سفارشی با طرح دلخواه',
    },
    {
      'image': 'assets/images/shop_window.jpg',
      'title': 'نمونه ۵ - قاب ساعتی',
      'desc': 'قاب عکس ساعتی با عکس دلخواه',
    },
    {
      'image': 'assets/images/shop_window.jpg',
      'title': 'نمونه ۶ - نقاشی روی ظروف',
      'desc': 'طراحی روی ظروف دلخواه مثل بشقاب سفالی',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // تشخیص اندازه صفحه برای تغییر تعداد ستون‌ها
    final double screenWidth = MediaQuery.of(context).size.width;

    int crossAxisCount = 2;
    if (screenWidth < 600) {
      crossAxisCount = 1; // موبایل یا پنجره خیلی کوچک → ۱ ستون
    } else if (screenWidth < 900) {
      crossAxisCount = 2; // تبلت → ۲ ستون
    } else {
      crossAxisCount = 3; // دسکتاپ → ۲ ستون
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(65),
        child: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 15,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
              child: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading:
                    false, // ← این خط کلیدی: دکمه بک خودکار رو حذف می‌کنه

                leading: IconButton(
                  // ← دکمه بک سفارشی سفید سمت چپ
                  icon: const Icon(
                    Icons
                        .arrow_back_ios_new_rounded, // یا Icons.arrow_back (هر کدوم خوشگل‌تره)
                    color: Color.fromRGBO(0, 121, 107, 1),
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pop(context); // ← برمی‌گرده به صفحه قبل
                  },
                ),

                flexibleSpace: Container(
                  decoration: BoxDecoration(color: Color(0xffc4fbf5)),
                  child: Row(
                    children: [
                      Spacer(),
                      SizedBox(width: 35),
                      // فضای خالی سمت چپ برای دکمه بک (جای leading)
                      Center(
                        child: Text(
                          'نمونه کارها\n$productName',
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 2, 7, 65),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Samim',
                            letterSpacing: 1.0,
                            height: 1.2,
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          maxLines: 3,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false,
                          );
                        },
                        child: Image.asset(
                          'assets/images/Logo.png',
                          width: 60,
                          height: 60,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(width: 15),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: screenWidth < 600
                ? 0.85
                : 0.75, // در موبایل کارت‌ها بلندتر
          ),
          itemCount: samples.length,
          itemBuilder: (context, index) {
            final sample = samples[index];
            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      flex: screenWidth < 600 ? 5 : 6,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          sample['image']!,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade300,
                              child: const Icon(
                                Icons.image_not_supported,
                                size: 60,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: screenWidth < 600 ? 3 : 4,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              sample['title']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth < 600 ? 15 : 14,
                                fontFamily: 'Samim',
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              sample['desc']!,
                              style: TextStyle(
                                fontSize: screenWidth < 600 ? 14 : 13,
                                color: Colors.grey.shade700,
                                fontFamily: 'Samim',
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                              softWrap: true,
                              overflow: TextOverflow.visible,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: buildContactFooter(),
    );
  }
}
