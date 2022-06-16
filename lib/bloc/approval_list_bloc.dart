import 'package:dakshattendance/model/approval_list_model.dart';
import 'package:dakshattendance/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ApprovalListBloc {
  final _approvalList = PublishSubject<ApprovalListModel>();
  final _repository = Repository();
  Stream<ApprovalListModel> get approvalListStream => _approvalList.stream;

  Future approvalListSink(String employeeid) async {
    final ApprovalListModel model =
        await _repository.onApprovalListApi(employeeid);
    _approvalList.sink.add(model);
  }

  void dispose() {
    _approvalList.close();
  }
}

final approvalListBloc = ApprovalListBloc();
