
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_app/AllApiCall/ApiConstants.dart';

class AddKRARequest {

  String userid;
  String token;
  String employee_id;
  String finacial_year;
  String kra_salary;
  String work_responsibility;
  String work_responsibility_feedback;
  String com_behaviour;
  String comp_feedback;
  String team_player;
  String team_player_feed_back;
  String task_delivery;
  String task_delivery_feedback;
  String kra_per;
  String kra_salary_with_performance;
  String total;
  String final_kra_salary;


  AddKRARequest(
      this.userid,
      this.token,
      this.employee_id,
      this.finacial_year,
      this.kra_salary,
      this.work_responsibility,
      this.work_responsibility_feedback,
      this.com_behaviour,
      this.comp_feedback,
      this.team_player,
      this.team_player_feed_back,
      this.task_delivery,
      this.task_delivery_feedback,
      this.kra_per,
      this.kra_salary_with_performance,
      this.total,
      this.final_kra_salary);

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = new Map();
    map[ApiConstants.USERID] = userid;
    map[ApiConstants.CHECKINOUT_TOKEN] = token;
    map["employee_id"] = employee_id;
    map["finacial_year"] = finacial_year;
    map["kra_salary"] = kra_salary;
    map["work_responsibility"] = work_responsibility;
    map["work_responsibility_feedback"] = work_responsibility_feedback;
    map["com_behaviour"] = com_behaviour;
    map["comp_feedback"] = comp_feedback;
    map["team_player"] = team_player;
    map["team_player_feed_back"] = team_player_feed_back;
    map["task_delivery"] = task_delivery;
    map["task_delivery_feedback"] = task_delivery_feedback;
    map["kra_per"] = kra_per;
    map["kra_salary_with_performance"] = kra_salary_with_performance;
    map["total"] = total;
    map["final_kra_salary"] = final_kra_salary;
    print("AddKRARequest : " + map.toString());
    return map;
  }

}
