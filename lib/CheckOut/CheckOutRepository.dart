import 'package:rxdart/rxdart.dart';

import 'CHeckOutCall.dart';
import 'CheckOutApiResponse.dart';
import 'CheckOutRequest.dart';
import 'CheckOutResponse.dart';


class CheckOutRepository {

  executeCHeckOut(CheckOutRequest request,
      BehaviorSubject<CheckOutApiResponse<CheckOutResponse>> responseSubject) {
    new CHeckOutCall(request, responseSubject).execute();
  }

}
