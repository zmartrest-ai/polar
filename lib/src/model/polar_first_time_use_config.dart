import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'dart:io' show Platform;

part 'polar_first_time_use_config.g.dart';

/// Enum representing the training background levels
enum TrainingBackground {
  /// Occasional training (1-2 times per week)
  occasional(10),

  /// Regular training (2-3 times per week)
  regular(20),

  /// Frequent training (3-4 times per week)
  frequent(30),

  /// Heavy training (4-5 times per week)
  heavy(40),

  /// Semi-professional training (5-6 times per week)
  semiPro(50),

  /// Professional training (6+ times per week)
  pro(60);

  /// The numeric value representing the training background level
  final int value;
  const TrainingBackground(this.value);
}

/// Enum representing the typical day activity levels
enum TypicalDay {
  /// Mostly moving throughout the day
  mostlyMoving(1),

  /// Mostly sitting throughout the day
  mostlySitting(2),

  /// Mostly standing throughout the day
  mostlyStanding(3);

  /// The numeric value representing the typical day activity level
  final int value;
  const TypicalDay(this.value);
}

/// Configuration class for First Time Use setup
@JsonSerializable()
class PolarFirstTimeUseConfig {
  /// The gender of the user ('Male' or 'Female')
  final String gender;

  /// The user's birth date
  final DateTime birthDate;

  /// The user's height in centimeters (90-240)
  final int height;

  /// The user's weight in kilograms (15-300)
  final int weight;

  /// The user's maximum heart rate in bpm (100-240)
  final int maxHeartRate;

  /// The user's VO2 max (10-95)
  final int vo2Max;

  /// The user's resting heart rate in bpm (20-120)
  final int restingHeartRate;

  /// The user's training background level
  final TrainingBackground trainingBackground;

  /// The device time in ISO 8601 format
  final String deviceTime;

  /// The user's typical daily activity level
  final TypicalDay typicalDay;

  /// The user's sleep goal in minutes
  final int sleepGoalMinutes;

  /// Creates a new [PolarFirstTimeUseConfig] instance
  PolarFirstTimeUseConfig({
    required this.gender,
    required this.birthDate,
    required this.height,
    required this.weight,
    required this.maxHeartRate,
    required this.vo2Max,
    required this.restingHeartRate,
    required this.trainingBackground,
    required this.deviceTime,
    required this.typicalDay,
    required this.sleepGoalMinutes,
  }) {
    // Validate ranges
    if (height < 90 || height > 240) {
      throw ArgumentError('Height must be between 90 and 240 cm');
    }
    if (weight < 15 || weight > 300) {
      throw ArgumentError('Weight must be between 15 and 300 kg');
    }
    if (maxHeartRate < 100 || maxHeartRate > 240) {
      throw ArgumentError('Max heart rate must be between 100 and 240 bpm');
    }
    if (restingHeartRate < 20 || restingHeartRate > 120) {
      throw ArgumentError('Resting heart rate must be between 20 and 120 bpm');
    }
    if (vo2Max < 10 || vo2Max > 95) {
      throw ArgumentError('VO2 max must be between 10 and 95');
    }
    if (!['Male', 'Female'].contains(gender)) {
      throw ArgumentError('Gender must be either "Male" or "Female"');
    }
  }

  /// Create a PolarFirstTimeUseConfig from JSON
  factory PolarFirstTimeUseConfig.fromJson(Map<String, dynamic> json) =>
      _$PolarFirstTimeUseConfigFromJson(json);

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    final json = _$PolarFirstTimeUseConfigToJson(this);
    // Override the enum values with their integer values for Android
    if (Platform.isAndroid) {
      json['trainingBackground'] = trainingBackground.value;
      json['typicalDay'] = typicalDay.value;
    }
    return json;
  }

  /// Convert to a Map for platform channel
  String toMap() => jsonEncode(toJson());
}
