final String tableLogs = 'logs';

class LogFields {
  static final List<String> values = [id, logData];
  static final String id = '_id';
  static final String logData = "logData";
}

class Log {
  final int? id;
  final String logData;

  const Log({
    this.id,
    required this.logData,
  });

  Log copy({
    int? id,
    String? logData,
  }) =>
      Log(
        id: id ?? this.id,
        logData: logData ?? this.logData,
      );

  static Log fromJson(Map<String, Object?> json) => Log(
        id: json[LogFields.id] as int?,
        logData: json[LogFields.logData] as String,
      );

  Map<String, Object?> toJson() =>
      {LogFields.id: id, LogFields.logData: logData};

  //TODO sierra make a function to translate datetime back into correct format
}
