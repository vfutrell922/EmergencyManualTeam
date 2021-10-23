final String tableLogs = 'logs';

class LogFields {
  static final List<String> values = [
    id,
    runNum,
    patientID,
    unitNum,
    runTime,
    additionalData
  ];
  static final String id = '_id';
  static final String runNum = 'runNum';
  static final String patientID = "patientID";
  static final String unitNum = 'unitNum';
  static final String runTime = "runTime";
  static final String additionalData = "additionalData";
}

class Log {
  final int? id;
  final int? runNum;
  final String? patientID;
  final int? unitNum;
  final String? runTime;
  final String? additionalData;

  const Log(
      {this.id,
      this.runNum,
      this.patientID,
      this.unitNum,
      this.runTime,
      this.additionalData});

  Log copy({
    int? id,
    int? runNum,
    String? patientID,
    int? unitNum,
    String? runTime,
    String? additionalData,
  }) =>
      Log(
        id: id ?? this.id,
        runNum: runNum ?? this.runNum,
        patientID: patientID ?? this.patientID,
        unitNum: unitNum ?? this.unitNum,
        runTime: runTime ?? this.runTime,
        additionalData: additionalData ?? this.additionalData,
      );

  static Log fromJson(Map<String, Object?> json) => Log(
        id: json[LogFields.id] as int?,
        runNum: json[LogFields.runNum] as int?,
        patientID: json[LogFields.patientID] as String?,
        unitNum: json[LogFields.unitNum] as int?,
        runTime: json[LogFields.runTime] as String?,
        additionalData: json[LogFields.additionalData] as String?,
      );

  Map<String, Object?> toJson() => {
        LogFields.id: id,
        LogFields.runNum: runNum,
        LogFields.patientID: patientID,
        LogFields.unitNum: unitNum,
        LogFields.runTime: runTime,
        LogFields.additionalData: additionalData,
      };

  //TODO sierra make a function to translate datetime back into correct format
}
