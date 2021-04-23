class  AttendanceListModel{

  String status;
  String message;
  List<AttendanceList> attendancelist;

  AttendanceListModel(this.attendancelist);

  AttendanceListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    attendancelist = new List<AttendanceList>();
    if(json.containsKey("show_attendance_list")){
      json['show_attendance_list'].forEach((v) {
        attendancelist.add(new AttendanceList.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['status'] = this.status;
    if (this.attendancelist != null) {
      data['show_attendance_list'] = this.attendancelist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttendanceList {
  String start_time;
  String leave_status;
  String difference;

  AttendanceList(this.start_time, this.leave_status,this.difference);

  AttendanceList.fromJson(Map<String, dynamic> json) {
    start_time = json['start_date'];
    leave_status = json['leave_status'];
    difference = json['difference'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.start_time;
    data['leave_status'] = this.leave_status;
    data['difference'] = this.difference;
    return data;
  }
}