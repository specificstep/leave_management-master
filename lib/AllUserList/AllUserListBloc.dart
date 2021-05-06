import 'package:flutter_app/AllUserList/AllUserListRepository.dart';
import 'package:flutter_app/AllUserList/AllUserListResponse.dart';
import 'package:flutter_app/Common/CommonRequest.dart';
import 'package:flutter_app/Login/ApiResponse.dart';
import 'package:rxdart/rxdart.dart';

class AllUserListBloc {
  final AllUserListRepository _repository = AllUserListRepository();
  final BehaviorSubject<ApiResponse<AllUserListResponse>> _subjectLogin =
      BehaviorSubject<ApiResponse<AllUserListResponse>>();

  executeAllUserList(CommonRequest request) {
    _repository.executeAllUserList(request, _subjectLogin);
  }

  BehaviorSubject<ApiResponse<AllUserListResponse>> get subject =>
      _subjectLogin;

  disposeLoginSubject() {
    _subjectLogin.close();
  }
}
