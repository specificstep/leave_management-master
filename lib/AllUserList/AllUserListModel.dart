class  AllUserListModel{

  String status;
  String message;
  List<UserList> userlist;

  AllUserListModel(this.userlist);
  AllUserListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    userlist = new List<UserList>();
    if(json.containsKey("user_list")){
      json['user_list'].forEach((v) {
        userlist.add(new UserList.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['status'] = this.status;
    if (this.userlist != null) {
      data['user_list'] = this.userlist.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserList {
  String userid;
  String username;

  UserList(this.userid, this.username);

  UserList.fromJson(Map<String, dynamic> json) {
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