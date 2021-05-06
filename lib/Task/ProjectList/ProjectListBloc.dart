import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Task/AllList/AllListRepository.dart';
import 'package:flutter_app/Task/AllList/AllListRequest.dart';
import 'package:flutter_app/Task/ProjectList/ProjectListRepository.dart';
import 'package:flutter_app/Task/ProjectList/ProjectListResponse.dart';
import 'package:rxdart/rxdart.dart';

class ProjectListBloc {
  final ProjectListRepository _repository = ProjectListRepository();
  final BehaviorSubject<ApiResponse<ProjectListResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<ProjectListResponse>>();

  executeLeaveList(AllListRequest request) {
    _repository.executeallList(request, _subjectLogin);
  }

  BehaviorSubject<ApiResponse<ProjectListResponse>> get subject => _subjectLogin;

  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

