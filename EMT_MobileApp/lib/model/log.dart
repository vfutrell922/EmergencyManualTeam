final String tableLogs = 'logs';

class LogFields {
  static final List<String> values = [
    id,
    runNum,
    startTime,
    endTime,
    additionalData
  ];
  static final String id = '_id';
  static final String runNum = 'runNum';
  static final String startTime = "startTime";
  static final String endTime = "endTime";
  static final String additionalData = "additionalData";
}

class Log {
  final int? id;
  final int? runNum;
  final String? startTime;
  final String? endTime;
  final String? additionalData;

  const Log(
      {this.id,
      this.runNum,
      this.startTime,
      this.endTime,
      this.additionalData});

  Log copy({
    int? id,
    int? runNum,
    String? startTime,
    String? endTime,
    String? additionalData,
  }) =>
      Log(
        id: id ?? this.id,
        runNum: runNum ?? this.runNum,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        additionalData: additionalData ?? this.additionalData,
      );

  static Log fromJson(Map<String, Object?> json) => Log(
        id: json[LogFields.id] as int?,
        runNum: json[LogFields.runNum] as int?,
        startTime: json[LogFields.startTime] as String?,
        endTime: json[LogFields.endTime] as String?,
        additionalData: json[LogFields.additionalData] as String?,
      );

  Map<String, Object?> toJson() => {
        LogFields.id: id,
        LogFields.runNum: runNum,
        LogFields.startTime: startTime,
        LogFields.endTime: endTime,
        LogFields.additionalData: additionalData,
      };

  //TODO sierra make a function to translate datetime back into correct format
}
