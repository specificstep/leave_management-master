class ViewTaskModel {
  String status;
  String message;
  List<ViewTask> viewtask;

  
  ViewTaskModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    viewtask = new List<ViewTask>();

    if (json.containsKey("show_all_task")) {
      json['show_all_task'].forEach((v) {
        viewtask.add(new ViewTask.fromJson(v));
      });
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['status'] = this.status;
    if (this.viewtask != null) {
      data['show_all_task'] = this.viewtask.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class ViewTask {
  String taskid;
  String userid;
  String start_date;
  String end_date;
  String title;
  String subject;
  String description;
  String manager_id;
  String manager_name;
  String employee_id;
  String employee_name;
  String working_id;
  String working_name;
  String priority;
  String priority_id;
  String task_status;
  String task_status_id;
  String task_per;
  String attechment;

  ViewTask.fromJson(Map<String, dynamic> json) {
    taskid = json['taskid'];
    userid = json['userid'];
    start_date = json['start_date'];
    end_date = json['end_date'];
    title = json['title'];
    subject = json['subject'];
    description = json['description'];
    manager_id = json['manager_id'];
    manager_name = json['manager_name'];
    employee_id = json['employee_id'];
    employee_name = json['employee_name'];
    working_id = json['working_id'];
    working_name = json['working_name'];
    priority = json['priority'];
    priority_id = json['priority_id'];
    task_status = json['task_status'];
    task_status_id = json['task_status_id'];
    task_per = json['task_per'];
    attechment = json['attechment'];
  }

  Map<String, dynamic> toJson() =>
      {
        "taskid": taskid,
        "userid": userid,
        "start_date": start_date,
        "end_date": end_date,
        "title": title,
        "subject": subject,
        "description": description,
        "manager_id": manager_id,
        "manager_name": manager_name,
        "employee_id": employee_id,
        "employee_name": employee_name,
        "working_id": working_id,
        "working_name": working_name,
        "priority": priority,
        "priority_id": priority_id,
        "task_status": task_status,
        "task_status_id": task_status_id,
        "task_per": task_per,
        "attechment": attechment,
      };

}
