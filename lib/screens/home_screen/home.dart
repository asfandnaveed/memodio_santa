import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memodio_santa/constant/constant.dart';

import 'package:memodio_santa/controller/studentsController.dart';

import '../add_students/add_students.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // final database = FirebaseDatabase.instance.ref();
  final Controller studentDataInstance = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.kBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [

                Card(
                  color: Colors.white,
                  elevation: 8.0,
                  shadowColor: Colors.black45,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          ImageUtils.kSantaHeader,
                          height: 170,
                          width: Get.width,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Hero(
                        tag: 'header',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            ImageUtils.kSnow,
                            height: 170,
                            width: Get.width,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 170,
                        width: Get.width,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Lorem Ipsum',
                                          style: GoogleFonts.poppins(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white
                                          ),
                                        ),
                                        Text(
                                          'Dummy text of the printing and typesetting industry',
                                          style: GoogleFonts.poppins(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle
                                    ),
                                    child: Image.asset(
                                      ImageUtils.kAvatar
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                    onPressed: () async {

                                      Get.to(()=> const AddStudents(),transition: Transition.fadeIn);
                                      // await database.child(FirebaseConst.kStudentsNode).push().set({
                                      //   "name": "Paul Zimmermann",
                                      //   "country_flag":"🇩🇪",
                                      //   "country_code":"",
                                      //   "status":"0",
                                      //   "created_at":DateTime.now().toString(),
                                      // });

                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 5.0,
                                      shadowColor: ColorUtils.kPrimary.withOpacity(0.4),
                                      backgroundColor: ColorUtils.kPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                    ),
                                    child: Text(
                                      'Add Students',
                                      style: GoogleFonts.poppins(

                                      ),
                                    ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Obx(() => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // number of items in each row
                      mainAxisSpacing: 8.0, // spacing between rows
                      crossAxisSpacing: 8.0, // spacing between columns
                    ),
                    itemCount: studentDataInstance.studentList.length,
                    itemBuilder: (context , index){
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 5,bottom: 10),
                                        child: CircleAvatar(
                                          backgroundColor: ColorUtils.kPrimary,
                                          radius: 22,
                                          child:  Text(
                                            studentDataInstance.studentList[index].name![0],
                                            style: GoogleFonts.poppins(
                                              fontSize:24,
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Text(
                                          '${studentDataInstance.studentList[index].countryFlag}',
                                          style: const TextStyle(
                                            fontSize: 25,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 5,),
                                  Flexible(
                                    child: Text(
                                      '${studentDataInstance.studentList[index].name}',
                                      style: GoogleFonts.poppins(
                                          fontSize:16,
                                          fontWeight: FontWeight.w500,
                                          height: 1.3
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.location_pin,
                                      size: 18,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${studentDataInstance.studentList[index].countryName}',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Spacer(),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          studentDataInstance.studentList[index].status=='0'?ImageUtils.kNaughty:ImageUtils.kNice,
                                          width: 25,
                                        ),
                                        const SizedBox(height: 5,),
                                        Container(
                                          decoration: BoxDecoration(
                                              color: studentDataInstance.studentList[index].status=='0'? ColorUtils.kNaughty:ColorUtils.kNice,
                                              borderRadius: BorderRadius.circular(40)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                                            child: Text(
                                              studentDataInstance.studentList[index].status=='0'?'Naughty':'Nice',
                                              style: GoogleFonts.poppins(
                                                fontSize: 14,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      );
                    }
                )),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
