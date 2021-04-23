class  LeaveBalanceModel{

  int status;
  String message;
  List<LeaveBalanceList> leavebalacelist;

  LeaveBalanceModel(this.leavebalacelist);

  LeaveBalanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    leavebalacelist = new List<LeaveBalanceList>();
    json['data'].forEach((v) {
      leavebalacelist.add(new LeaveBalanceList.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if(data.containsValue("data")){
      data['data'] = this.leavebalacelist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveBalanceList {
  String no_leave;
  String leave_name;

  LeaveBalanceList(this.no_leave, this.leave_name);

  LeaveBalanceList.fromJson(Map<String, dynamic> json) {
    no_leave = json['no_leave'];
    leave_name = json['leave_name'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['no_leave'] = this.no_leave;
    data['leave_name'] = this.leave_name;
    return data;
  }
}