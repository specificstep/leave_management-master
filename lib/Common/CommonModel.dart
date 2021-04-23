class CommonModel {
  final String message;
  final String status;

  CommonModel(this.status,this.message);

  CommonModel.fromJson(Map<String, dynamic> json)
      : status = json["status"],
        message = json["message"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;

    print("common_data" + data.toString());
    return data;

  }
}
