class CheckInOutStatusModel {
  final String message;
  final String status;
  final String checkinoutstatus;
  final String time;

  CheckInOutStatusModel(
      this.status, this.message, this.checkinoutstatus, this.time);

  CheckInOutStatusModel.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        checkinoutstatus = json["checkinoutstatus"],
        time = json["time"],
        message = json["message"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['checkinoutstatus'] = this.checkinoutstatus;
    data['time'] = this.time;
    return data;
  }
}
