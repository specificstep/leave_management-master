class ProjectListShowModel {
  String status;
  String message;
  List<ProjectListModel> projectlist;

  
  ProjectListShowModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    projectlist = new List<ProjectListModel>();

    if (json.containsKey("project_list")) {
      json['project_list'].forEach((v) {
        projectlist.add(new ProjectListModel.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['status'] = this.status;
    if (this.projectlist != null) {
      data['project_list'] = this.projectlist.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ProjectListModel {
  String id;
  String project_name;
  bool selected = true;

  ProjectListModel(this.id, this.project_name);

  ProjectListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    project_name = json['project_name'];
  }

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "project_name": project_name,
      };

}
