import 'package:flutter/material.dart';
import 'package:mahva_shop/empty.dart';
import 'package:mahva_shop/footer.dart';
import 'product_detail_page.dart';

// class ProductsPage extends StatelessWidget {
//   const ProductsPage({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: Text('صفحه محصولات')));
// }

// class PortfolioPage extends StatelessWidget {
//   const PortfolioPage({super.key});
//   @override
//   Widget build(BuildContext context) =>
//       const Scaffold(body: Center(child: Text('صفحه نمونه‌کارها')));
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const double maxContentWidth =
      420; // حداکثر عرض محتوای اصلی (عکس + hotspotها)
  static const double imageAspectRatio = 8 / 10; // نسبت اصلی عکس شما
  static const double desktopBreakpoint = 900;
  static const double sideMenuWidth = 240; // عرض منوی دسکتاپ

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showGuide = false;
  bool _showMenu = false; // فقط برای موبایل

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showGuideDialog();
    });
  }

  void _toggleGuide() {
    setState(() => _showGuide = !_showGuide);
  }

  void _closeGuide() {
    if (_showGuide) setState(() => _showGuide = false);
  }

  void _showGuideDialog() {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(
        0.5,
      ), // پس‌زمینه تیره‌تر برای تمرکز
      barrierDismissible: true,
      builder: (dialogContext) {
        // بستن خودکار بعد ۳ ثانیه
        Future.delayed(const Duration(seconds: 3), () {
          if (mounted && Navigator.canPop(dialogContext)) {
            Navigator.pop(dialogContext);
          }
        });

        return GestureDetector(
          onTap: () => Navigator.pop(dialogContext), // تپ هرجا → بستن
          child: Center(
            child: GestureDetector(
              onTap: () {}, // جلوگیری از بستن وقتی روی خود popup تپ می‌کنی
              child: Stack(
                alignment: Alignment.center,
                clipBehavior: Clip.none,
                children: [
                  // تصویر ابر به عنوان پس‌زمینه
                  Image.asset(
                    'assets/images/cloud.png',
                    width: 350, // اندازه دلخواه – تست کن
                    height: 230,
                    fit: BoxFit.contain,
                  ),

                  // متن داخل ابر
                  Padding(
                    padding: const EdgeInsets.fromLTRB(60, 70, 60, 80),
                    child: Material(
                      color: Colors
                          .transparent, // ← شفاف بمونه، فقط استایل پیش‌فرض می‌ده
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          SizedBox(height: 25),
                          Text(
                            'راهنمای فروشگاه',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 121, 107, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 25),
                          Text(
                            'برای مشاهده جزئیات ویترین زوم کنید.\n',
                            style: TextStyle(
                              fontSize: 18,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                            textDirection: TextDirection.rtl,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHotspot({
    required BuildContext context,
    required double leftPercent,
    required double topPercent,
    required double widthPercent,
    required double heightPercent,
    required String name,
    required String description,
    required String imagePath,
    required BoxConstraints constraints,
  }) {
    final double w = constraints.maxWidth;
    final double h = constraints.maxHeight;

    return Positioned(
      left: leftPercent * w,
      top: topPercent * h,
      width: widthPercent * w,
      height: heightPercent * h,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailPage(
                name: name,
                description: description,
                imagePath: imagePath,
              ),
            ),
          );
        },
        child: Tooltip(
          message: name,
          preferBelow: false,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.75),
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(color: Colors.black, fontSize: 15),
          child: Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.red.withOpacity(0.5), width: 4),
              // borderRadius: BorderRadius.circular(12),
              color: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sideMenu({required bool isDesktop}) {
    return Container(
      width: isDesktop ? HomePage.sideMenuWidth : 260,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 12,
            offset: const Offset(-4, 0),
          ),
        ],
        borderRadius: isDesktop
            ? null
            : const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),

          _menuItem(
            title: 'لیست محصولات',
            icon: Icons.shopping_bag_outlined,
            onTap: () {
              if (!isDesktop) Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Empty()),
              );
            },
          ),
          Divider(
            color: Colors.grey[300],
            height: 1,
            thickness: 1,
            indent: 16, // فاصله از چپ
            endIndent: 16, // فاصله از راست
          ),
          // _menuItem(
          //   title: 'نمونه‌کارها',
          //   icon: Icons.photo_library_outlined,
          //   onTap: () {
          //     if (!isDesktop) Navigator.pop(context);
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (_) => const Empty()),
          //     );
          //   },
          // ),
          // Divider(
          //   color: Colors.grey[300],
          //   height: 1,
          //   thickness: 1,
          //   indent: 16, // فاصله از چپ
          //   endIndent: 16, // فاصله از راست
          // ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, color: Colors.teal.shade700, size: 26),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _closeGuide,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110),
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
                  centerTitle: true,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  foregroundColor: Colors.white,
                  flexibleSpace: Container(
                    color: Color(0xffc4fbf5),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'assets/images/Logo.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  title: const SizedBox(),
                ),
              ),
            ),
          ),
        ),

        body: LayoutBuilder(
          builder: (context, constraints) {
            final isDesktop =
                constraints.maxWidth >= HomePage.desktopBreakpoint;
            final double availableWidth = isDesktop
                ? constraints.maxWidth - HomePage.sideMenuWidth
                : constraints.maxWidth;

            return Stack(
              fit: StackFit.expand,
              children: [
                // محتوای اصلی (عکس + hotspotها) با عرض محدود شده
                Padding(
                  padding: EdgeInsets.only(
                    top: 190,
                    right: isDesktop
                        ? HomePage.sideMenuWidth
                        : 0, // ← مهم: فضای منو رو در دسکتاپ خالی نگه می‌داره
                  ),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: HomePage.maxContentWidth,
                        maxHeight: availableWidth / HomePage.imageAspectRatio,
                      ),
                      child: AspectRatio(
                        aspectRatio: HomePage.imageAspectRatio,
                        child: InteractiveViewer(
                          boundaryMargin: const EdgeInsets.all(40),
                          minScale: 1.0,
                          maxScale: 6.0,
                          child: LayoutBuilder(
                            builder: (context, imgConstraints) {
                              return Stack(
                                fit: StackFit.expand,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      'assets/images/bb.jpg',
                                      fit: BoxFit.contain,
                                      width: imgConstraints.maxWidth,
                                      height: imgConstraints.maxHeight,
                                      alignment: Alignment.center,
                                    ),
                                  ),

                                  // همه hotspotها با درصدهای دقیق
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.03,
                                    topPercent: 0.03,
                                    widthPercent: 0.95,
                                    heightPercent: 0.16,
                                    name: 'مجسمه های سفید دکوری',
                                    description: 'مجسمه های سفید دکوری',
                                    imagePath: 'assets/images/products/i1.png',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.06,
                                    topPercent: 0.21,
                                    widthPercent: 0.44,
                                    heightPercent: 0.18,
                                    name: 'تابلو فرش عمودی',
                                    description:
                                        'تابلو فرش شخصی‌سازی‌شده با عکس دلخواه',
                                    imagePath: 'assets/images/products/i2.jpg',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.51,
                                    topPercent: 0.21,
                                    widthPercent: 0.44,
                                    heightPercent: 0.14,
                                    name: 'قاب ساعتی',
                                    description: 'قاب عکس ساعتی با عکس دلخواه',
                                    imagePath: 'assets/images/products/i3.jpg',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.51,
                                    topPercent: 0.36,
                                    widthPercent: 0.44,
                                    heightPercent: 0.15,
                                    name: 'Love قاب قلب بزرگ',
                                    description: 'قاب قلبی بزرگ',
                                    imagePath: 'assets/images/products/i4.jpg',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.11,
                                    topPercent: 0.46,
                                    widthPercent: 0.18,
                                    heightPercent: 0.14,
                                    name: 'تابلو کاشی',
                                    description: 'تابلو های قرآنی',
                                    imagePath: 'assets/images/products/i5.jpg',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.28,
                                    topPercent: 0.46,
                                    widthPercent: 0.21,
                                    heightPercent: 0.14,
                                    name: 'تندیس',
                                    description: 'تندیس',
                                    imagePath: 'assets/images/products/i6.png',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.51,
                                    topPercent: 0.51,
                                    widthPercent: 0.44,
                                    heightPercent: 0.12,
                                    name: 'پایه نگه دارنده موبایل فلزی',
                                    description: 'مجسمه های دکوری فلزی',
                                    imagePath: 'assets/images/products/i7.jpg',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.51,
                                    topPercent: 0.63,
                                    widthPercent: 0.44,
                                    heightPercent: 0.13,
                                    name: 'مجسمه های سفید دکوری',
                                    description: 'مجسمه های سفید دکوری',
                                    imagePath: 'assets/images/products/i8.jpg',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.51,
                                    topPercent: 0.76,
                                    widthPercent: 0.44,
                                    heightPercent: 0.11,
                                    name: 'ماگ‌های چاپی',
                                    description:
                                        'ماگ با چاپ عکس و طرح دلخواه شما',
                                    imagePath: 'assets/images/products/i9.jpg',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.51,
                                    topPercent: 0.88,
                                    widthPercent: 0.44,
                                    heightPercent: 0.11,
                                    name: 'ماگ‌های چاپی خام رنگی',
                                    description:
                                        'ماگ با چاپ عکس و طرح دلخواه شما',
                                    imagePath: 'assets/images/products/i10.jpg',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.06,
                                    topPercent: 0.65,
                                    widthPercent: 0.44,
                                    heightPercent: 0.17,
                                    name: 'قاب عکس پازلی',
                                    description:
                                        'قاب‌های دایره ای و قلبی و مربعی با چاپ عکس',
                                    imagePath: 'assets/images/products/i11.jpg',
                                  ),
                                  _buildHotspot(
                                    context: context,
                                    constraints: imgConstraints,
                                    leftPercent: 0.06,
                                    topPercent: 0.84,
                                    widthPercent: 0.44,
                                    heightPercent: 0.14,
                                    name: 'قاب عکس در اشکال مختلف',
                                    description:
                                        'قاب‌های دایره ای و قلبی و مربعی با چاپ عکس',
                                    imagePath: 'assets/images/products/i12.jpg',
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // منوی ثابت دسکتاپ (راست صفحه)
                if (isDesktop)
                  Positioned(
                    top: 90,
                    bottom: 0,
                    right: 0,
                    width: HomePage.sideMenuWidth,
                    child: _sideMenu(isDesktop: true),
                  ),

                // منوی کشویی موبایل
                if (!isDesktop && _showMenu)
                  SafeArea(
                    // اجازه می‌ده پایین منو بالای فوتر باشه
                    child: GestureDetector(
                      onTap: () => setState(
                        () => _showMenu = false,
                      ), // بستن با تپ خارج منو
                      child: Container(
                        color: Colors.black.withOpacity(
                          0.4,
                        ), // پس‌زمینه نیمه‌شفاف
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap:
                                () {}, // جلوگیری از بسته شدن وقتی روی منو تپ می‌کنی
                            child: AnimatedSlide(
                              offset: _showMenu
                                  ? Offset.zero
                                  : const Offset(1, 0),
                              duration: const Duration(milliseconds: 280),
                              curve: Curves.easeOut,
                              child: Container(
                                // عرض منو ۷۵٪ صفحه (استاندارد موبایل)
                                width: MediaQuery.of(context).size.width * 0.60,
                                // ارتفاع کامل موجود (بین هدر و فوتر)
                                height: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(30),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.25),
                                      blurRadius: 20,
                                      offset: const Offset(-8, 0),
                                    ),
                                  ],
                                ),
                                child: _sideMenu(isDesktop: false),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                // دکمه همبرگر (موبایل)
                if (!isDesktop)
                  Positioned(top: 160, right: 0, child: _buildMenuButton()),

                // دکمه راهنما
                Positioned(top: 160, left: 0, child: _buildGuideButton()),

                // کادر راهنما
                if (_showGuide)
                  Center(
                    child: Container(
                      width: 300,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'راهنمای فروشگاه',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color.fromRGBO(0, 121, 107, 1),
                            ),
                          ),
                          SizedBox(height: 10),
                          RichText(
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            text: TextSpan(
                              children: [
                                // خط اول
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Icon(
                                    Icons.circle,
                                    size: 10, // اندازه کوچک bullet
                                    color: Color(0xFF006064), // رنگ دلخواه شما
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                      ' برای مشاهده جزئیات ویترین زوم کنید.\n',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors
                                        .black87, // یا هر رنگی که برای متن می‌خوای
                                    height: 1.5,
                                  ),
                                ),

                                // خط دوم
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Color(0xFF006064),
                                    ),
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                      ' برای مشاهده توضیحات محصولات روی آیتم‌ها کلیک کنید.\n',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),

                                // خط سوم
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Icon(
                                      Icons.circle,
                                      size: 10,
                                      color: Color(0xFF006064),
                                    ),
                                  ),
                                ),
                                const TextSpan(
                                  text:
                                      ' برای ارتباط با ما از لینک‌های پایین صفحه استفاده کنید.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            );
          },
        ),

        bottomNavigationBar: buildContactFooter(),
      ),
    );
  }

  Widget _buildMenuButton() {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => setState(() => _showMenu = !_showMenu),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              decoration: BoxDecoration(
                color: Color(0xff18cbb5),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  bottomLeft: Radius.circular(14),
                ),
              ),
              child: const Icon(Icons.menu, color: Colors.white, size: 30),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGuideButton() {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: _toggleGuide,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
              decoration: BoxDecoration(
                color: Color(0xff18cbb5),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(14),
                  bottomRight: Radius.circular(14),
                ),
              ),
              child: const Icon(
                Icons.help_outline,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
