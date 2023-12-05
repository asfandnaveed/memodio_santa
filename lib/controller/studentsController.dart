

import 'package:country_picker/country_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:memodio_santa/constant/constant.dart';

import '../model/studentsModel.dart';

class Controller extends GetxController{

  // static Controller studentDataInstance = Get.find();

  Rx<Country> countryData = Country(
      phoneCode: '',
      countryCode: '',
      e164Sc: 0,
      geographic:
      false,
      level: 0,
      name: '',
      displayName: '',
      example: '',
      displayNameNoCountryCode: '',
      e164Key: '').obs;


  RxBool studentStatus = false.obs;



  RxList<StudentsModel> studentList = <StudentsModel>[].obs;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getStudents();


  }

  getStudents() {

    studentList.clear();

    FirebaseDatabase.instance.ref().child(FirebaseConst.kStudentsNode).get().then((snapshot){
      for(var item in snapshot.children){
        print("GETX : ${item.value}");
        StudentsModel studentsModel = StudentsModel.fromJson(item.value as Map<dynamic,dynamic>);
        studentList.add(studentsModel);
      }
    });

  }


}