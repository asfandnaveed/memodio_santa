import 'package:country_picker/country_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memodio_santa/constant/constant.dart';
import 'package:memodio_santa/controller/studentsController.dart';

class AddStudents extends StatefulWidget {
  const AddStudents({super.key});

  @override
  State<AddStudents> createState() => _AddStudentsState();
}

class _AddStudentsState extends State<AddStudents> {
  final Controller controller = Get.find();

  TextEditingController studentName = TextEditingController();


  Future addStudentData () async{
    final database = FirebaseDatabase.instance.ref();

    await database.child(FirebaseConst.kStudentsNode).push().set({
      FirebaseConst.kStudentsName: studentName.text,
      FirebaseConst.kStudentsCountryFlag: controller.countryData.value.flagEmoji,
      FirebaseConst.kStudentsCountryName: controller.countryData.value.name,
      FirebaseConst.kStudentsCountryCode: controller.countryData.value.countryCode,
      FirebaseConst.kStudentsStatus: controller.studentStatus.value==true?"1":"0",
      FirebaseConst.kStudentsCreateAt: DateTime.now().toString(),


    });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Hero(
            tag: 'header',
            child: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Image.asset(
                ImageUtils.kSantaHeader,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: Get.width * 0.9,
            margin: EdgeInsets.symmetric(vertical: Get.height * 0.1, horizontal: Get.width * 0.05),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back),
                      Text(
                        'Back',
                        style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Add Students',
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TextFormField(
                    controller: studentName,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Student Name',
                      labelStyle: GoogleFonts.poppins(
                        color: ColorUtils.kPrimary,
                      ),
                      filled: true,
                      fillColor: ColorUtils.kPrimary.withOpacity(0.1),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: ColorUtils.kPrimary),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: InkWell(
                    onTap: () {
                      showCountryPicker(
                        context: context,
                        favorite: <String>['DE', 'US'],
                        countryListTheme: CountryListThemeData(
                          searchTextStyle: GoogleFonts.poppins(color: ColorUtils.kPrimary),
                          flagSize: 35,
                          backgroundColor: Colors.white,
                          textStyle: GoogleFonts.poppins(fontSize: 19, color: ColorUtils.kPrimary),
                          // Optional. Country list modal height
                          //Optional. Sets the border radius for the bottomsheet.
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40.0),
                            topRight: Radius.circular(40.0),
                          ),
                          //Optional. Styles the search field.
                          inputDecoration: InputDecoration(
                            labelText: 'Search',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: ColorUtils.kPrimary,
                              ),
                            ),
                          ),
                        ),
                        onSelect: (Country country) {
                          controller.countryData.value = country;

                          debugPrint('COUNTRY ${controller.countryData.value.name}');
                        },
                      );
                    },
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                        color: ColorUtils.kPrimary.withOpacity(0.1),
                        border: Border.all(
                          color: ColorUtils.kPrimary,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [

                              Obx(
                                () => Text(
                                  controller.countryData.value.name==''?'Select Country':controller.countryData.value.flagEmoji,
                                  style: GoogleFonts.poppins(
                                      fontSize: controller.countryData.value.name==''?17:30,
                                      color: ColorUtils.kPrimary),
                                ),
                              ),
                            const SizedBox(
                              width: 10,
                            ),
                            // if (controller.countryData != null)
                              Obx(
                                () => Text(
                                  controller.countryData.value.name,
                                  style: GoogleFonts.poppins(fontSize: 17, color: ColorUtils.kPrimary),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: (){
                        controller.studentStatus.value= !controller.studentStatus.value;
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        elevation: 6.0,
                        child: Container(
                          width: Get.width*0.35,
                          decoration: BoxDecoration(
                              color:controller.studentStatus.value==false? ColorUtils.kPrimary:Colors.white,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageUtils.kNaughty,
                                      width: 35,
                                    ),
                                    const SizedBox(height: 5,),
                                    Container(
                                      decoration: BoxDecoration(
                                          color:  ColorUtils.kNaughty,
                                          borderRadius: BorderRadius.circular(40)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                                        child: Text(
                                          'Naughty',
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
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        controller.studentStatus.value= !controller.studentStatus.value;
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        elevation: 6.0,
                        child: Container(
                          width: Get.width*0.35,
                          decoration: BoxDecoration(
                              color:controller.studentStatus.value==true? ColorUtils.kPrimary:Colors.white,
                              borderRadius: BorderRadius.circular(12)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 40.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      ImageUtils.kNice,
                                      width: 35,
                                    ),
                                    const SizedBox(height: 5,),
                                    Container(
                                      decoration: BoxDecoration(
                                          color:  ColorUtils.kNice,
                                          borderRadius: BorderRadius.circular(40)
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2),
                                        child: Text(
                                          ' Nice ',
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
                        ),
                      ),
                    ),
                  ],
                ),),
                const Spacer(),
                ElevatedButton(
                    onPressed: () async {

                      if(studentName.text.isNotEmpty && controller.countryData.value.name !=''){
                        await addStudentData().then((value) => {
                          controller.getStudents(),
                          Get.back(),
                        });
                      }else{
                        Get.snackbar(
                          'ERROR',
                          'Please Fill All The Fields',
                          icon: Icon(Icons.error,color: Colors.red,)
                        );
                      }

                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorUtils.kPrimary,
                      elevation: 7.0,
                      shadowColor: ColorUtils.kPrimary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'Save Student Data',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ),
                const SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


