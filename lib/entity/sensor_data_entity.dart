class SensorDataEntity {
  final int id;
  final String temperature;
  final String humidity;
  final String light;
  final String wind;
  final String time;

  SensorDataEntity({
    required this.id,
    required this.temperature,
    required this.humidity,
    required this.light,
    required this.wind,
    required this.time,
  });

  factory SensorDataEntity.fromJson(Map<String, dynamic> json) {
    return SensorDataEntity(
      id: json['id'] as int,
      temperature: json['temperature'] as String,
      humidity: json['humidity'] as String,
      light: json['light'] as String,
      wind: json['wind'] as String,
      time: json['time'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'temperature': temperature,
      'humidity': humidity,
      'light': light,
      'wind': wind,
      'time': time,
    };
  }
}
