import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.red,
      ),
      home: const IntroPage(title: 'Fira Platform'),
    );
  }
}

class IntroPage extends StatefulWidget {
  const IntroPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<IntroPage> createState() => _IntroPage();
}

class _IntroPage extends State<IntroPage> {
  final pageviewController = PageController();

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  Widget buildPage({
    required Color color,
    required String urlImage,
    required String title,
    required String subtitle,
  }) =>
      Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              urlImage,
              // fit: BoxFit.cover,
              width: 262,
              height: 253,
            ),
            const SizedBox(width: 311, height: 64),
            Text(
              title,
              style: TextStyle(
                color: HexColor('#075056'),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 215, height: 22),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                subtitle,
                style: TextStyle(color: HexColor('#78789D'), fontSize: 16),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(bottom: 80),
        child: PageView(
          controller: pageviewController,
          children: [
            buildPage(
                color: Colors.white,
                urlImage: 'assets/intro1.png',
                title: 'Quick and Easy\nBooking',
                subtitle: 'We offer a 3-step booking\nwhich solves your problem\nquickly and easily'),
            buildPage(
                color: Colors.white,
                urlImage: 'assets/intro2.png',
                title: 'Security and\nProfessionalism',
                subtitle: 'All our domestic workers have\ntransparent background and\nare well-trained'),
            buildPage(
                color: Colors.white,
                urlImage: 'assets/intro3.png',
                title: 'Give your home\na Wow feeling',
                subtitle: 'We care about every small\ndetails to sastisfy your needs\nwhen you use our service'),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: SmoothPageIndicator(
                controller: pageviewController,
                count: 3,
                effect: ExpandingDotsEffect(
                    spacing: 10,
                    dotWidth: 9,
                    dotHeight: 5,
                    radius: 5,
                    dotColor: HexColor('#F6F6F6'),
                    activeDotColor: HexColor('#F58A2B')),
                onDotClicked: (index) => pageviewController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 145,
                  height: 50,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side:
                              BorderSide(width: 1, color: HexColor('#FF3600')),
                        ),
                      ),
                    ),
                    child: const Text('SKIP'),
                    onPressed: () => pageviewController.jumpToPage(2),
                  ),
                ),
                SizedBox(
                  width: 145,
                  height: 50,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(
                              width: 145, color: HexColor('#FF3600')),
                        ),
                      ),
                    ),
                    child: const Text('NEXT'),
                    onPressed: () => pageviewController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
