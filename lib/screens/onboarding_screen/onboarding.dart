import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_screen_onboarding_flutter/introduction.dart';
import 'package:intro_screen_onboarding_flutter/introscreenonboarding.dart';
import 'package:memodio_santa/constant/constant.dart';
import 'package:memodio_santa/controller/studentsController.dart';

import '../home_screen/home.dart';


class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {



  final List<Introduction> list = [
    Introduction(
      title: 'Lorem Ipsum',
      subTitle: 'The app will track childrens names, their home countries, and whether they have been naughty or nice',
      imageUrl: ImageUtils.kOnBoarding1,
    ),
    Introduction(
      title: 'Lorem Ipsum',
      subTitle: 'The app will track childrens names, their home countries, and whether they have been naughty or nice',
      imageUrl: ImageUtils.kOnBoarding2,
    ),
    Introduction(
      title: 'Lorem Ipsum',
      subTitle: 'The app will track childrens names, their home countries, and whether they have been naughty or nice',
      imageUrl: ImageUtils.kOnBoarding3,
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroScreenOnboarding(

        introductionList: list,
        onTapSkipButton: () {
          Get.to(()=> const HomePage());
        }

      ),
    );
  }
}
