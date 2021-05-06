import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:flutter_app/Task/AllList/AllListRepository.dart';
import 'package:flutter_app/Task/AllList/AllListResponse.dart';
import 'package:flutter_app/Task/AllList/AllListRequest.dart';
import 'package:rxdart/rxdart.dart';

class AllListBloc {
  final AllListRepository _repository = AllListRepository();
  final BehaviorSubject<ApiResponse<AllListResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<AllListResponse>>();

  executeLeaveList(AllListRequest request) {
    _repository.executeallList(request, _subjectLogin);
  }

  BehaviorSubject<ApiResponse<AllListResponse>> get subject => _subjectLogin;

  disposeLoginSubject() {
    _subjectLogin.close();
  }
}

