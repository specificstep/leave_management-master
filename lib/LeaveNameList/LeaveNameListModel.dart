class  LeaveNameListModel{

  String status;
  String message;
  List<LeaveNameList> leavenamelist;

  LeaveNameListModel(this.leavenamelist);

  LeaveNameListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    leavenamelist = new List<LeaveNameList>();
    json['leavename_list'].forEach((v) {
      leavenamelist.add(new LeaveNameList.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['status'] = this.status;
    if (this.leavenamelist != null) {
      data['leavename_list'] = this.leavenamelist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveNameList {
  String id;
  String leave_name;

  LeaveNameList(this.id, this.leave_name);

  LeaveNameList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leave_name = json['leave_name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leave_name'] = this.leave_name;
    return data;
  }
}