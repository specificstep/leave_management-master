class KRAEmployeeListModel {
  String status;
  String message;
  List<KRAEmployeeList> kraemployeelist;

  KRAEmployeeListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    kraemployeelist = new List<KRAEmployeeList>();

    if (json.containsKey("kra_employee_list")) {
      json['kra_employee_list'].forEach((v) {
        kraemployeelist.add(new KRAEmployeeList.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['status'] = this.status;
    if (this.kraemployeelist != null) {
      data['kra_employee_list'] = this.kraemployeelist.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class KRAEmployeeList {
  String userid;
  String username;

  KRAEmployeeList(this.userid, this.username);

  KRAEmployeeList.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() =>
      {
        "userid": userid,
        "username": username,
      };

}
