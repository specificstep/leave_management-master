class ManageLeaveModel {
  String status;
  String message;
  List<ManageLeaveList> birthdaylist;

  ManageLeaveModel(this.birthdaylist, this.message, this.status);

  ManageLeaveModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    birthdaylist = new List<ManageLeaveList>();
    if (json.containsKey("member_leave_list")) {
      json['member_leave_list'].forEach((v) {
        birthdaylist.add(new ManageLeaveList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.birthdaylist != null) {
      data['member_leave_list'] =
          this.birthdaylist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ManageLeaveList {
  String id;
  String users_id;
  String user_name;
  String start_date;
  String end_date;
  String leave_type;
  String leave_type_id;
  String fullhalf_day;
  int total_day;
  String leave_reason;
  String leave_status;
  String leave_status_id;
  String remark;

  ManageLeaveList(
      this.id,
      this.users_id,
      this.user_name,
      this.start_date,
      this.end_date,
      this.leave_type,
      this.leave_type_id,
      this.fullhalf_day,
      this.total_day,
      this.leave_reason,
      this.leave_status,
      this.leave_status_id,
      this.remark);

  ManageLeaveList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    users_id = json['users_id'];
    user_name = json['user_name'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    leave_type = json['leave_type'];
    leave_type_id = json['leave_type_id'];
    fullhalf_day = json['fullday/half_day'];
    total_day = json['total_day'];
    leave_reason = json['leave_reason'];
    leave_status = json['leave_status'];
    leave_status_id = json['leave_status_id'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['users_id'] = this.users_id;
    data['user_name'] = this.user_name;
    data['start_date'] = this.start_date;
    data['end_date'] = this.end_date;
    data['leave_type'] = this.leave_type;
    data['leave_type_id'] = this.leave_type_id;
    data['fullday/half_day'] = this.fullhalf_day;
    data['total_day'] = this.total_day;
    data['leave_reason'] = this.leave_reason;
    data['leave_status'] = this.leave_status;
    data['leave_status_id'] = this.leave_status_id;
    data['remark'] = this.remark;
    return data;
  }
}
