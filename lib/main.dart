import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memodio_santa/constant/constant.dart';
import 'package:memodio_santa/controller/studentsController.dart';
import 'package:memodio_santa/firebase_options.dart';

import 'screens/onboarding_screen/onboarding.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((value) => {
       Get.put(Controller()),
  });



  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
        )
      ),
      home: FlutterSplashScreen.fadeIn(
        backgroundColor: Colors.white,
        onInit: () {
          debugPrint("On Init");
        },
        onEnd: () {
          debugPrint("On End");
        },
        childWidget: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset(
            ImageUtils.kLogo,
          ),
        ),
        onAnimationEnd: () => debugPrint("On Fade In End"),
        nextScreen: const OnBoarding(),
      ),
    );
  }
}

