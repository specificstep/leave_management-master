class  BirthdayListModel{

  String status;
  String message;
  List<BirthdayList> birthdaylist;

  BirthdayListModel(this.birthdaylist,this.message,this.status);

  BirthdayListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    birthdaylist = new List<BirthdayList>();
    if(json.containsKey("birthdate_list")){
      json['birthdate_list'].forEach((v) {
        birthdaylist.add(new BirthdayList.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.birthdaylist != null) {
      data['birthdate_list'] = this.birthdaylist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BirthdayList {
  String userid;
  String dob;
  String username;


  BirthdayList(this.userid, this.dob, this.username);

  BirthdayList.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    dob = json['dob'];
    username = json['username'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['dob'] = this.dob;
    data['username'] = this.username;
    return data;
  }
}