class User {
  final String message;
  final String status;
  final String user_id;
  final String token;
  final String username;
  final String rolename;

  User(this.status,this.message,this.user_id,this.token,this.username,this.rolename);

  User.fromJson(Map<String, dynamic> json)
      : status = json["status"], user_id = json["user_id"],token = json["token"],username = json["username"],rolename = json["rolename"],
        message = json["message"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['token'] = this.token;
    data['user_id'] = this.user_id;
    data['username'] = this.username;
    data['rolename'] = this.rolename;
    return data;
  }
}
