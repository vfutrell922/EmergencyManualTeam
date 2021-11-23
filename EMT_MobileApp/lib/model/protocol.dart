// EMT Medic Manual App for Mountain West Ambulance
// by Molly Clare, Vincent Futrell, Andrew Stender, and Sierra Johnson
// for their Senior Project 2021 at the University of Utah.

final String tableProtocols = 'protocols';

class ProtocolFields {
  static final List<String> values = [
    id,
    Name,
    Certification,
    PatientType,
    Guideline,
    OLMCRequired,
    HasAssociatedMedication,
    Medications,
    Chart,
    OtherInformation,
    TreatmentPlan,
  ];

  static final String id = '_id';
  static final String Name = 'Name';
  static final String Certification = 'Certification';
  static final String PatientType = 'PatientType';
  static final String Guideline = 'Guideline';
  static final String OLMCRequired = 'OLMCRequired';
  static final String HasAssociatedMedication = 'HasAssociatedMedication';
  static final String Medications = 'Medications';
  static final String Chart = 'Chart';
  static final String OtherInformation = 'OtherInformation';
  static final String TreatmentPlan = 'TreatmentPlan';
}

class Protocol {
  final int? id;
  final String Name;
  final int Certification;
  final int PatientType;
  final String? Guideline;
  final int OLMCRequired;
  final int? HasAssociatedMedication;
  final String? Medications;
  final String? Chart;
  final String? OtherInformation;
  final String? TreatmentPlan;

  const Protocol({
    this.id,
    required this.Name,
    required this.Certification,
    required this.PatientType,
    this.Guideline,
    required this.OLMCRequired,
    this.HasAssociatedMedication,
    this.Medications,
    this.Chart,
    this.OtherInformation,
    this.TreatmentPlan,
  });

  Protocol copy({
    int? id,
    String? Name,
    int? Certification,
    int? PatientType,
    int? HasAssociatedMedication,
    String? Medications,
    String? Guideline,
    int? OLMCRequired,
    String? Chart,
    String? OtherInformation,
    String? TreatmentPlan,
  }) =>
      Protocol(
        id: id ?? this.id,
        Name: Name ?? this.Name,
        Certification: Certification ?? this.Certification,
        PatientType: PatientType ?? this.PatientType,
        Guideline: Guideline ?? this.Guideline,
        OLMCRequired: OLMCRequired ?? this.OLMCRequired,
        HasAssociatedMedication:
            HasAssociatedMedication ?? this.HasAssociatedMedication,
        Medications: Medications ?? this.Medications,
        OtherInformation: OtherInformation ?? this.OtherInformation,
        TreatmentPlan: TreatmentPlan ?? this.TreatmentPlan,
      );

  /// Parse a json object from the web API response, if possible.
  static Protocol fromWebJson(
          Map<String, Object?> json, String? medicationsList) =>
      Protocol(
        id: json[ProtocolFields.id] as int?,
        Name: json[ProtocolFields.Name] as String,
        Certification: json[ProtocolFields.Certification] as int,
        PatientType: json[ProtocolFields.PatientType] as int,
        Guideline: json[ProtocolFields.Guideline] as String?,
        // SQLflite does not accept booleans, so convert to int
        OLMCRequired: ((json[ProtocolFields.OLMCRequired] as bool) ? 1 : 0),
        // since this is nullable, do two checks to return int?
        HasAssociatedMedication:
            ((json[ProtocolFields.HasAssociatedMedication] as bool?) == null
                ? null
                : (json[ProtocolFields.HasAssociatedMedication] as bool)
                    ? 1
                    : 0),
        Medications: medicationsList,
        OtherInformation: json[ProtocolFields.OtherInformation] as String?,
        TreatmentPlan: json[ProtocolFields.TreatmentPlan] as String?,
      );

  /// Parse json object as protocol, not from the web api, if already in the form of the SQLflite table
  static Protocol fromJson(Map<String, Object?> json) => Protocol(
        id: json[ProtocolFields.id] as int?,
        Name: json[ProtocolFields.Name] as String,
        Certification: json[ProtocolFields.Certification] as int,
        PatientType: json[ProtocolFields.PatientType] as int,
        Guideline: json[ProtocolFields.Guideline] as String?,
        OLMCRequired: (json[ProtocolFields.OLMCRequired] as int),
        HasAssociatedMedication:
            (json[ProtocolFields.HasAssociatedMedication] as int?),
        Medications: (json[ProtocolFields.Medications] as String?),
        OtherInformation: json[ProtocolFields.OtherInformation] as String?,
        TreatmentPlan: json[ProtocolFields.TreatmentPlan] as String?,
      );

  Map<String, Object?> toJson() => {
        ProtocolFields.id: id,
        ProtocolFields.Name: Name,
        ProtocolFields.Certification: Certification,
        ProtocolFields.PatientType: PatientType,
        ProtocolFields.Guideline: Guideline,
        ProtocolFields.OLMCRequired: OLMCRequired,
        ProtocolFields.HasAssociatedMedication: HasAssociatedMedication,
        ProtocolFields.Medications: Medications,
        ProtocolFields.OtherInformation: OtherInformation,
        ProtocolFields.TreatmentPlan: TreatmentPlan
      };
}
