class AllListModel {
  String status;
  String message;
  List<ManagerListModel> managerlist;
  List<EmployeeListModel> employee_list;
  
  AllListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    managerlist = new List<ManagerListModel>();
    employee_list = new List<EmployeeListModel>();

    if (json.containsKey("manager_list")) {
      json['manager_list'].forEach((v) {
        managerlist.add(new ManagerListModel.fromJson(v));
      });
    }
    if (json.containsKey("employee_list")) {
      json['employee_list'].forEach((v) {
        employee_list.add(new EmployeeListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['status'] = this.status;

    if (this.managerlist != null) {
      data['manager_list'] = this.managerlist.map((v) => v.toJson()).toList();
    }
    if (this.employee_list != null) {
      data['employee_list'] = this.employee_list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class EmployeeListModel {
  String userid;
  String username;
  bool emp_selected = true;

  EmployeeListModel(this.userid, this.username);

  EmployeeListModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['username'] = this.username;
    return data;
  }
}

class ManagerListModel {
  String userid;
  String username;
  bool manager_selected = true;

  ManagerListModel(this.userid, this.username);

  ManagerListModel.fromJson(Map<String, dynamic> json) {
    userid = json['userid'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userid'] = this.userid;
    data['username'] = this.username;
    return data;
  }
}
