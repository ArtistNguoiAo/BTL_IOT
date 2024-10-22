import 'package:btl_iot/entity/ops_history_entity.dart';

class DataResponse {
  final String id;
  final String time;
  final String fakeA;
  final String fakeB;
  final String fakeC;

  DataResponse({required this.id, required this.time, required this.fakeA, required this.fakeB, required this.fakeC});
}

class FakeData {
  static List<DataResponse> listFake = [
    DataResponse(id: 'ID01', time: '12:00:00', fakeA: '25%C', fakeB: "30%", fakeC: '1000 lux'),
    DataResponse(id: 'ID02', time: '12:00:01', fakeA: '26%C', fakeB: "31%", fakeC: '1001 lux'),
    DataResponse(id: 'ID03', time: '12:02', fakeA: '27%C', fakeB: "32%", fakeC: '1002 lux'),
    DataResponse(id: 'ID04', time: '12:03', fakeA: '28%C', fakeB: "33%", fakeC: '1003 lux'),
    DataResponse(id: 'ID05', time: '12:04', fakeA: '29%C', fakeB: "34%", fakeC: '1004 lux'),
    DataResponse(id: 'ID06', time: '12:05', fakeA: '30%C', fakeB: "35%", fakeC: '1005 lux'),
    DataResponse(id: 'ID07', time: '12:06', fakeA: '31%C', fakeB: "36%", fakeC: '1006 lux'),
    DataResponse(id: 'ID08', time: '12:07', fakeA: '32%C', fakeB: "37%", fakeC: '1007 lux'),
    DataResponse(id: 'ID09', time: '12:08', fakeA: '33%C', fakeB: "38%", fakeC: '1008 lux'),
    DataResponse(id: 'ID10', time: '12:09', fakeA: '34%C', fakeB: "39%", fakeC: '1009 lux'),
    DataResponse(id: 'ID11', time: '12:10', fakeA: '35%C', fakeB: "40%", fakeC: '1010 lux'),
    DataResponse(id: 'ID12', time: '12:11', fakeA: '36%C', fakeB: "41%", fakeC: '1011 lux'),
  ];

  static List<OpsHistoryEntity> listStatus = [

  ];

}