import 'package:dakshattendance/model/get_attendance_model.dart';
import 'package:dakshattendance/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class GetAttendanceBloc {
  final _getAttendance = PublishSubject<GetAttendanceModel>();
  final _repository = Repository();
  Stream<GetAttendanceModel> get getAttenanceStream => _getAttendance.stream;

  Future getAttendanceSink(String employeeid, String year, String month) async {
    final GetAttendanceModel model =
        await _repository.onGetAttendanceApi(employeeid, year, month);
    _getAttendance.sink.add(model);
  }

  void dispose() {
    _getAttendance.close();
  }
}

final getAttendanceBloc = GetAttendanceBloc();
