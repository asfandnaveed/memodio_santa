

class StudentsModel {

  String? name;
  String? countryCode;
  String? countryFlag;
  String? status;
  String? countryName;
  String? created_at;

  StudentsModel ({
    this.name,
    this.countryCode,
    this.countryFlag,
    this.status,
    this.countryName,
    this.created_at,
});

  StudentsModel.fromJson(Map<dynamic,dynamic> json){
    name = json["name"];
    countryCode = json["country_code"];
    countryFlag = json["country_flag"];
    status = json["status"];
    countryName = json["country_name"];
    created_at = json["created_at"];
  }



}