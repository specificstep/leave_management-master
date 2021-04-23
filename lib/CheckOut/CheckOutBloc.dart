import 'package:rxdart/rxdart.dart';

import 'CheckOutApiResponse.dart';
import 'CheckOutRepository.dart';
import 'CheckOutRequest.dart';
import 'CheckOutResponse.dart';

class CheckOutBloc {
  final CheckOutRepository _repository = CheckOutRepository();
  final BehaviorSubject<CheckOutApiResponse<CheckOutResponse>> _subjectCheckin =
      BehaviorSubject<CheckOutApiResponse<CheckOutResponse>>();

  /// Functions/Methods of get Data from Repository either from db/network
  executeCHeckOut(CheckOutRequest request) {
    _repository.executeCHeckOut(request, _subjectCheckin);
  }

  /// getter of Subject to access outside of class
  BehaviorSubject<CheckOutApiResponse<CheckOutResponse>> get subject => _subjectCheckin;

  /// functions that used to  close the Subject stream
  disposeLoginSubject() {
    _subjectCheckin.close();
  }
}

///final Object of User Bloc
// final userBloc = UserBloc();
