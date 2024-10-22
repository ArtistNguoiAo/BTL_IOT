class OpsHistoryEntity {
  final int id;
  final bool status;
  final String time;
  final int device;

  OpsHistoryEntity({
    required this.id,
    required this.status,
    required this.time,
    required this.device,
  });

  factory OpsHistoryEntity.fromJson(Map<String, dynamic> json) {
    return OpsHistoryEntity(
      id: json['id'] as int,
      status: json['status'] as bool,
      time: json['time'] as String,
      device: json['device'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'time': time,
      'device': device,
    };
  }
}