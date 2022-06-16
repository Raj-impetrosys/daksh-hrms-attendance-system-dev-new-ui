import 'package:dakshattendance/model/check_in_model.dart';
import 'package:dakshattendance/repository/repository.dart';

import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CheckInAttendanceBloc {
  final _chekcinAttendance = PublishSubject<CheckInModel>();
  final _repository = Repository();
  Stream<CheckInModel> get checkAttendanceStream => _chekcinAttendance.stream;

  Future checkAttendanceSink(
      String employeeid,
      String employeename,
      String tdate,
      String intime,
      String outtime,
      String latitude,
      String longitude,
      String location) async {
    final CheckInModel model = await _repository.oncheckinAttendance(employeeid,
        employeename, tdate, intime, outtime, latitude, longitude, location);
    _chekcinAttendance.sink.add(model);
  }

  void dispose() {
    _chekcinAttendance.close();
  }
}

final checkInAttendanceBloc = CheckInAttendanceBloc();
