final String tableProtocols = 'protocols';

class ProtocolFields {
  static final List<String> values = [
    id,
    Name,
    Certification,
    PatientType,
    GuidelineId,
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
  static final String GuidelineId = 'GuidelineId';
  static final String Guideline = 'Guideline';
  static final String OLMCRequired = 'OLMCRequired';
  static final String HasAssociatedMedication = 'HasAssociatedMedication';
  static final String Medications = 'Medications';
  static final String Chart = 'Chart';
  static final String OtherInformation = 'OtherInformation';
  static final String TreatmentPlan = 'TreatmentPlan';
}

class Protocol {
  final int id;
  final String Name;
  final String Certification;
  final int PatientType;
  final int GuidelineId;
  final String Guideline;
  final bool OLMCRequired;
  final bool? HasAssociatedMedication;
  //TODO: These types are not correct, filler
  final List<String>? Medications;
  final String? Chart;
  final String? OtherInformation;
  final String? TreatmentPlan;

  const Protocol({
    required this.id,
    required this.Name,
    required this.Certification,
    required this.PatientType,
    required this.GuidelineId,
    required this.Guideline,
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
    String? Certification,
    int? PatientType,
    bool? HasAssociatedMedication,
    int? GuidelineId,
    String? Guideline,
    bool? OLMCRequired,
    List<String>? Medications,
    String? Chart,
    String? OtherInformation,
    String? TreatmentPlan,
  }) =>
      Protocol(
        id: id ?? this.id,
        Name: Name ?? this.Name,
        Certification: Certification ?? this.Certification,
        PatientType: PatientType ?? this.PatientType,
        GuidelineId: GuidelineId ?? this.GuidelineId,
        Guideline: Guideline ?? this.Guideline,
        OLMCRequired: OLMCRequired ?? this.OLMCRequired,
        HasAssociatedMedication:
            HasAssociatedMedication ?? this.HasAssociatedMedication,
        Medications: Medications ?? this.Medications,
        OtherInformation: OtherInformation ?? this.OtherInformation,
        TreatmentPlan: TreatmentPlan ?? this.TreatmentPlan,
      );

  static Protocol fromJson(Map<String, Object?> json) => Protocol(
        id: json[ProtocolFields.id] as int,
        Name: json[ProtocolFields.Name] as String,
        Certification: json[ProtocolFields.Certification] as String,
        PatientType: json[ProtocolFields.PatientType] as int,
        GuidelineId: json[ProtocolFields.GuidelineId] as int,
        Guideline: json[ProtocolFields.Guideline] as String,
        OLMCRequired: json[ProtocolFields.OLMCRequired] as bool,
        HasAssociatedMedication:
            json[ProtocolFields.HasAssociatedMedication] as bool?,
        Medications: json[ProtocolFields.Medications] as List<String>?,
        OtherInformation: json[ProtocolFields.OtherInformation] as String?,
        TreatmentPlan: json[ProtocolFields.TreatmentPlan] as String?,
      );

  Map<String, Object?> toJson() => {
        ProtocolFields.id: id,
        ProtocolFields.Name: Name,
        ProtocolFields.Certification: Certification,
        ProtocolFields.PatientType: PatientType,
        ProtocolFields.GuidelineId: GuidelineId,
        ProtocolFields.Guideline: Guideline,
        ProtocolFields.OLMCRequired: OLMCRequired,
        ProtocolFields.HasAssociatedMedication: HasAssociatedMedication,
        ProtocolFields.Medications: Medications,
        ProtocolFields.OtherInformation: OtherInformation,
        ProtocolFields.TreatmentPlan: TreatmentPlan
      };
}
