import 'package:flutter/material.dart';
import 'package:mahva_shop/footer.dart';
// import 'portfolio_page.dart';
import 'package:mahva_shop/data/sample_data.dart';

class ProductDetailPage extends StatelessWidget {
  final String name;
  final String description;
  final String imagePath; // ← پارامتر جدید: مسیر عکس محصول

  const ProductDetailPage({
    Key? key,
    required this.name,
    required this.description,
    required this.imagePath, // ← جدید
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    // محاسبه تعداد ستون‌ها (اینجا تعریف می‌شه)
    int crossAxisCount = 2;
    if (screenWidth < 600) {
      crossAxisCount = 1;
    } else if (screenWidth < 900) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    // گرفتن نمونه‌ها (اگر نبود → از default استفاده می‌کنه)
    final samples = productSamples[name] ?? productSamples['default'] ?? [];

    // اگر نمونه واقعی نداشت، ۳ کارت با عکس همون محصول می‌سازیم
    final displaySamples = samples.isNotEmpty
        ? samples
        : List.generate(
            3,
            (index) => {
              'image': imagePath, // ← اینجا عکس محصول فعلی رو می‌ذاریم
              'title': 'نمونه کار ${index + 1}',
              'desc': 'اینجا بعداً عکس واقعی قرار می‌گیره',
            },
          );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
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
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: Color.fromRGBO(0, 121, 107, 1),
                    size: 28,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                flexibleSpace: Container(
                  color: Color(0xffc4fbf5),
                  child: Row(
                    children: [
                      Spacer(),
                      SizedBox(width: 25),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: screenWidth < 600 ? 18 : 20,
                          color: Color.fromARGB(255, 2, 7, 65),
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Samim',
                          letterSpacing: 1.0,
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Spacer(),
                      Image.asset(
                        'assets/images/Logo.png',
                        width: 60,
                        height: 60,
                        fit: BoxFit.contain,
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
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 100, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // عکس محصول – حالا از imagePath استفاده می‌شه
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image.asset(
                imagePath, // ← تغییر اصلی: عکس محصول مربوطه نمایش داده می‌شه
                width: double.infinity,
                height: screenWidth < 600 ? 250 : 320,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  // اگر عکس پیدا نشد، یه عکس پیش‌فرض نشون بده
                  return Image.asset(
                    'assets/images/bb.jpg',
                    width: double.infinity,
                    height: screenWidth < 600 ? 250 : 320,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
            // const SizedBox(height: 30),

            // Text(
            //   name,
            //   style: TextStyle(
            //     fontSize: screenWidth < 600 ? 26 : 30,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.teal.shade700,
            //     fontFamily: 'Samim',
            //   ),
            //   textAlign: TextAlign.center,
            //   textDirection: TextDirection.rtl,
            //   softWrap: true,
            //   maxLines: 2,
            // ),
            // const SizedBox(height: 20),
            // Text(
            //   description,
            //   style: TextStyle(
            //     fontSize: screenWidth < 600 ? 17 : 19,
            //     height: 1.8,
            //     color: Colors.grey.shade800,
            //     fontFamily: 'Samim',
            //   ),
            //   textAlign: TextAlign.center,
            //   textDirection: TextDirection.rtl,
            //   softWrap: true,
            // ),
            const SizedBox(height: 30),
            Text(
              'این محصول به صورت کاملاً شخصی‌سازی‌شده و با بهترین مواد ساخته می‌شود.\n'
              'می‌توانید عکس، متن یا طرح دلخواه خود را روی آن چاپ کنید.\n'
              'مناسب برای هدیه، دکوراسیون منزل یا یادگاری خاص.',
              style: TextStyle(
                fontSize: screenWidth < 600 ? 15 : 17,
                color: Colors.grey.shade600,
                height: 1.7,
                fontFamily: 'Samim',
              ),
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              softWrap: true,
            ),
            // const SizedBox(height: 40),

            // GestureDetector(
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (_) => PortfolioPage(productName: name),
            //       ),
            //     );
            //   },
            //   child: Container(
            //     width: double.infinity,
            //     padding: EdgeInsets.symmetric(
            //       horizontal: screenWidth < 600 ? 20 : 20,
            //       vertical: 15,
            //     ),
            //     decoration: BoxDecoration(
            //       gradient: LinearGradient(
            //         colors: [
            //           Color(0xff18cbb5),
            //           const Color.fromARGB(255, 75, 92, 90),
            //         ],
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //       ),
            //       borderRadius: BorderRadius.circular(30),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.3),
            //           blurRadius: 12,
            //           offset: const Offset(0, 6),
            //           spreadRadius: 2,
            //         ),
            //       ],
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: const [
            //         Icon(
            //           Icons.photo_library_outlined,
            //           color: Colors.white,
            //           size: 28,
            //         ),
            //         SizedBox(width: 16),
            //         Text(
            //           'مشاهده نمونه کارها',
            //           style: TextStyle(
            //             color: Colors.white,
            //             fontSize: 19,
            //             fontWeight: FontWeight.bold,
            //             fontFamily: 'Samim',
            //             letterSpacing: 0.8,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(height: 40),
            // بخش نمونه کارها
            Text(
              'نمونه کارهای $name',
              style: TextStyle(
                fontSize: screenWidth < 600 ? 22 : 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
                fontFamily: 'Samim',
              ),
              textAlign: TextAlign.center,
            ),

            // const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: screenWidth < 600 ? 0.85 : 0.75,
              ),
              itemCount: displaySamples.length,
              itemBuilder: (context, index) {
                final sample = displaySamples[index];
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        Expanded(
                          flex: screenWidth < 600 ? 5 : 6,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                sample['image']!,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
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
                                // Text(
                                //   sample['desc']!,
                                //   style: TextStyle(
                                //     fontSize: screenWidth < 600 ? 14 : 13,
                                //     color: Colors.grey.shade700,
                                //     fontFamily: 'Samim',
                                //   ),
                                //   textAlign: TextAlign.center,
                                //   textDirection: TextDirection.rtl,
                                //   softWrap: true,
                                //   overflow: TextOverflow.visible,
                                //   maxLines: 3,
                                // ),
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

            const SizedBox(height: 40),
          ],
        ),
      ),
      bottomNavigationBar: buildContactFooter(),
    );
  }
}
