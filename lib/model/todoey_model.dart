final String tableTodoey = 'todoey';

class Todoey {
  final int? id;
  final String title;
  final String description;
  bool progress;
  final DateTime createdTime;
  final DateTime scheduledTime;

  Todoey({
    this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.createdTime,
    required this.scheduledTime,
  });

  Map<String, Object?> toJson() => {
        TodoeyFields.id: id,
        TodoeyFields.title: title,
        TodoeyFields.description: description,
        TodoeyFields.progress: progress ? 1 : 0,
        TodoeyFields.createdTime: createdTime.toIso8601String(),
        TodoeyFields.scheduledTime: scheduledTime.toIso8601String(),
      };

  static Todoey fromJson(Map<String, Object?> json) => Todoey(
        id: json[TodoeyFields.id] as int?,
        title: json[TodoeyFields.title] as String,
        description: json[TodoeyFields.description] as String,
        progress: json[TodoeyFields.progress] == 1,
        createdTime: DateTime.parse(json[TodoeyFields.createdTime] as String),
        scheduledTime:
            DateTime.parse(json[TodoeyFields.scheduledTime] as String),
      );

  Todoey copy({
    int? id,
    String? title,
    String? description,
    bool? progress,
    DateTime? createdTime,
    DateTime? scheduledTime,
  }) =>
      Todoey(
          id: id ?? this.id,
          title: title ?? this.title,
          description: description ?? this.description,
          progress: progress ?? this.progress,
          createdTime: createdTime ?? this.createdTime,
          scheduledTime: scheduledTime ?? this.scheduledTime);
}

class TodoeyFields {
  static final List<String> values = [
    id,
    title,
    description,
    progress,
    createdTime,
    scheduledTime
  ];

  static final String id = '_id';
  static final String title = 'title';
  static final String description = 'description';
  static final String progress = 'progress';
  static final String createdTime = 'createdTime';
  static final String scheduledTime = 'scheduledTime';
}
