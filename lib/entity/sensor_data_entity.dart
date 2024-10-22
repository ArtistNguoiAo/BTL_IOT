class SensorDataEntity {
  final int id;
  final double temperature;
  final double humidity;
  final double light;
  final String time;

  SensorDataEntity({
    required this.id,
    required this.temperature,
    required this.humidity,
    required this.light,
    required this.time,
  });

  factory SensorDataEntity.fromJson(Map<String, dynamic> json) {
    return SensorDataEntity(
      id: json['id'] as int,
      temperature: json['temperature'] as double,
      humidity: json['humidity'] as double,
      light: json['light'] as double,
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'temperature': temperature,
      'humidity': humidity,
      'light': light,
      'time': time,
    };
  }
}
