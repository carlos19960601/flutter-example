import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GuidePage extends StatefulWidget {
  const GuidePage({super.key});

  @override
  State<GuidePage> createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> with TickerProviderStateMixin {
  AnimationController? baseAnimationController; // 标题动画

  late Animation<double> titleAnim;
  int activePage = 1;

  // 主要维护标题动画
  void initBaseAnim() {
    // 图片缩放动画
    baseAnimationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    titleAnim =
        baseAnimationController!.drive(CurveTween(curve: Curves.fastOutSlowIn));
    titleAnim.addStatusListener((AnimationStatus status) {});
  }

  @override
  void initState() {
    super.initState();
    initBaseAnim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: Stack(
          children: [
            Container(
              color: const Color(0xFF181818),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(20, 80, 10, 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizeTransition(
                    sizeFactor: titleAnim,
                    child: Text(
                      "Cc Clip",
                      style: GoogleFonts.akayaKanadaka(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (activePage == 1)
              Container(
                padding: const EdgeInsets.only(bottom: 260),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SizedBox(
                  height: 400,
                  child: Image.asset(
                    'assets/guide/flame-space-adventures.gif',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
