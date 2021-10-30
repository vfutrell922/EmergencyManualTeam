import 'package:flutter/rendering.dart';

final String tableMedications = 'medication';

class MedicationFields {
  static final List<String> values = [
    id,
    Name,
    Action,
    Indication,
    Contraindication,
    Precaution,
    AdverseEffects,
    AdultDosage,
    ChildDosage,
  ];

  static final String id = '_id';
  static final String Name = 'Name';
  static final String Action = 'Action';
  static final String Indication = 'Indication';
  static final String Contraindication = 'Contraindication';
  static final String Precaution = 'Precaution';
  static final String AdverseEffects = 'AdverseEffects';
  static final String AdultDosage = 'AdultDosage';
  static final String ChildDosage = 'ChildDosage';
}

class Medication {
  final int? id;
  final String Name;
  final String Action;
  final String Indication;
  final String Contraindication;
  final String Precaution;
  final String AdverseEffects;
  final String? AdultDosage;
  final String? ChildDosage;

  const Medication({
    this.id,
    required this.Name,
    required this.Action,
    required this.Indication,
    required this.Contraindication,
    required this.Precaution,
    required this.AdverseEffects,
    this.AdultDosage,
    this.ChildDosage,
  });

  Medication copy({
    int? id,
    String? Name,
    String? Action,
    String? Indication,
    String? Contraindication,
    String? Precaution,
    String? AdverseEffects,
    String? AdultDosage,
    String? ChildDosage,
  }) =>
      Medication(
        id: id ?? this.id,
        Name: Name ?? this.Name,
        Action: Action ?? this.Action,
        Indication: Indication ?? this.Indication,
        Contraindication: Contraindication ?? this.Contraindication,
        Precaution: Precaution ?? this.Precaution,
        AdverseEffects: AdverseEffects ?? this.AdverseEffects,
        AdultDosage: AdultDosage ?? this.AdultDosage,
        ChildDosage: ChildDosage ?? this.ChildDosage,
      );

  static Medication fromWebJson(Map<String, Object?> json) => Medication(
        id: json[MedicationFields.id] as int?,
        Name: json[MedicationFields.Name] as String,
        Action: json[MedicationFields.Action] as String,
        Indication: json[MedicationFields.Indication] as String,
        Contraindication: json[MedicationFields.Contraindication] as String,
        Precaution: json[MedicationFields.Precaution] as String,
        AdverseEffects: json[MedicationFields.AdverseEffects] as String,
        AdultDosage: json[MedicationFields.AdultDosage] as String,
        ChildDosage: json[MedicationFields.ChildDosage] as String,
      );

  static Medication fromJson(Map<String, Object?> json) => Medication(
        id: json[MedicationFields.id] as int?,
        Name: json[MedicationFields.Name] as String,
        Action: json[MedicationFields.Action] as String,
        Indication: json[MedicationFields.Indication] as String,
        Contraindication: json[MedicationFields.Contraindication] as String,
        Precaution: json[MedicationFields.Precaution] as String,
        AdverseEffects: json[MedicationFields.AdverseEffects] as String,
        AdultDosage: json[MedicationFields.AdultDosage] as String,
        ChildDosage: json[MedicationFields.ChildDosage] as String,
      );

  Map<String, Object?> toJson() => {
        MedicationFields.id: id,
        MedicationFields.Name: Name,
        MedicationFields.Action: Action,
        MedicationFields.Indication: Indication,
        MedicationFields.Contraindication: Contraindication,
        MedicationFields.Precaution: Precaution,
        MedicationFields.AdverseEffects: AdverseEffects,
        MedicationFields.AdultDosage: AdultDosage,
        MedicationFields.ChildDosage: ChildDosage,
      };
}
