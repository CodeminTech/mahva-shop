import 'package:flutter/material.dart';
import 'package:mahva_shop/footer.dart';
import 'package:mahva_shop/home_page.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
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
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffc4fbf5),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      SizedBox(width: 15),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false, // همه صفحات قبلی رو پاک می‌کنه
                          );
                        },
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Color.fromRGBO(0, 121, 107, 1),
                        ),
                      ),

                      Spacer(),
                      SizedBox(width: 25),
                      Text(
                        'محصولات',
                        style: const TextStyle(
                          fontSize: 20,
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
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                            (route) => false, // همه صفحات قبلی رو پاک می‌کنه
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
      body: Center(child: Text('محتوایی وجود ندارد')),

      bottomNavigationBar: buildContactFooter(),
    );
  }
}
