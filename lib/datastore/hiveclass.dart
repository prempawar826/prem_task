import 'package:hive/hive.dart';

part 'hiveclass.g.dart'; 

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  int duration; // total seconds

  @HiveField(4)
  DateTime? startTime;

  @HiveField(5)
  bool isRunning;

  @HiveField(6)
  bool isCompleted;
  
  @HiveField(7)
  int mainduration;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.duration,
    this.startTime,
    this.isRunning = false,
    this.isCompleted = false,
    required this.mainduration,
  });

  int getRemainingSeconds() {
    if (!isRunning || startTime == null) return duration;
    final elapsed = DateTime.now().difference(startTime!).inSeconds;
    final remaining = duration - elapsed;
    return remaining > 0 ? remaining : 0;
  }
}