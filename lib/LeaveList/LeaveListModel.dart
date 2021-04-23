class  LeaveListModel{

  String status;
  String message;
  List<LeaveList> leavelist;

  LeaveListModel(this.leavelist,this.message,this.status);

  LeaveListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    leavelist = new List<LeaveList>();
    if(json.containsKey("user_leave_list")){
      json['user_leave_list'].forEach((v) {
        leavelist.add(new LeaveList.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.leavelist != null) {
      data['user_leave_list'] = this.leavelist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeaveList {
  String start_date;
  String end_date;
  String leave_type;
  String full_halfday;
  int total_day;
  String leave_reason;
  String leave_status;
  String users_id;
  String id;

  LeaveList(this.users_id,this.start_date, this.end_date, this.leave_type, this.full_halfday,
      this.total_day, this.leave_reason, this.leave_status,this.id);

  LeaveList.fromJson(Map<String, dynamic> json) {
    users_id = json['users_id'];
    full_halfday = json['fullday/half_day'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    leave_type = json['leave_type'];
    total_day = json['total_day'];
    leave_reason = json['leave_reason'];
    leave_status = json['leave_status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['users_id'] = this.users_id;
    data['fullday/half_day'] = this.full_halfday;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['leave_type'] = this.leave_type;
    data['total_day'] = this.total_day;
    data['leave_reason'] = this.leave_reason;
    data['leave_status'] = this.leave_status;
    data['id'] = this.id;
    return data;
  }
}