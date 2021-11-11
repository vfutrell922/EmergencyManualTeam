import 'package:flutter/rendering.dart';

final String tableMedications = 'medication';

class MedicationFields {
  static final List<String> values = [
    ID,
    PrimaryKey,
    Name,
    Action,
    Indication,
    Contraindication,
    Precaution,
    AdverseEffects,
    AdultDosage,
    ChildDosage,
    Max
  ];

  static final String ID = 'ID';
  static final String PrimaryKey = '_PrimaryKey';
  static final String Name = 'Name';
  static final String Action = 'Action';
  static final String Indication = 'Indication';
  static final String Contraindication = 'Contraindication';
  static final String Precaution = 'Precaution';
  static final String AdverseEffects = 'AdverseEffects';
  static final String AdultDosage = 'AdultDosage';
  static final String ChildDosage = 'ChildDosage';
  static final String Max = 'Max';
}

class Medication {
  final int ID;
  final int? PrimaryKey;
  final String Name;
  final String Action;
  final String Indication;
  final String Contraindication;
  final String Precaution;
  final String AdverseEffects;
  final String? AdultDosage;
  final String? ChildDosage;
  final String? Max;

  const Medication({
    required this.ID,
    this.PrimaryKey,
    required this.Name,
    required this.Action,
    required this.Indication,
    required this.Contraindication,
    required this.Precaution,
    required this.AdverseEffects,
    this.AdultDosage,
    this.ChildDosage,
    this.Max,
  });

  Medication copy({
    int? ID,
    int? PrimaryKey,
    String? Name,
    String? Action,
    String? Indication,
    String? Contraindication,
    String? Precaution,
    String? AdverseEffects,
    String? AdultDosage,
    String? ChildDosage,
    String? Max,
  }) =>
      Medication(
        ID: ID ?? this.ID,
        PrimaryKey: PrimaryKey ?? this.PrimaryKey,
        Name: Name ?? this.Name,
        Action: Action ?? this.Action,
        Indication: Indication ?? this.Indication,
        Contraindication: Contraindication ?? this.Contraindication,
        Precaution: Precaution ?? this.Precaution,
        AdverseEffects: AdverseEffects ?? this.AdverseEffects,
        AdultDosage: AdultDosage ?? this.AdultDosage,
        ChildDosage: ChildDosage ?? this.ChildDosage,
        Max: Max ?? this.Max,
      );

  static Medication fromWebJson(Map<String, Object?> json) => Medication(
        ID: json[MedicationFields.ID] as int,
        PrimaryKey: json[MedicationFields.PrimaryKey] as int,
        Name: json[MedicationFields.Name] as String,
        Action: json[MedicationFields.Action] as String,
        Indication: json[MedicationFields.Indication] as String,
        Contraindication: json[MedicationFields.Contraindication] as String,
        Precaution: json[MedicationFields.Precaution] as String,
        AdverseEffects: json[MedicationFields.AdverseEffects] as String,
        AdultDosage: json[MedicationFields.AdultDosage] as String,
        ChildDosage: json[MedicationFields.ChildDosage] as String,
        Max: json[MedicationFields.Max] as String,
      );

  static Medication fromJson(Map<String, Object?> json) => Medication(
      ID: json[MedicationFields.ID] as int,
      PrimaryKey: json[MedicationFields.PrimaryKey] as int,
      Name: json[MedicationFields.Name] as String,
      Action: json[MedicationFields.Action] as String,
      Indication: json[MedicationFields.Indication] as String,
      Contraindication: json[MedicationFields.Contraindication] as String,
      Precaution: json[MedicationFields.Precaution] as String,
      AdverseEffects: json[MedicationFields.AdverseEffects] as String,
      AdultDosage: json[MedicationFields.AdultDosage] as String,
      ChildDosage: json[MedicationFields.ChildDosage] as String,
      Max: json[MedicationFields.Max] as String);

  Map<String, Object?> toJson() => {
        MedicationFields.ID: ID,
        MedicationFields.PrimaryKey: PrimaryKey,
        MedicationFields.Name: Name,
        MedicationFields.Action: Action,
        MedicationFields.Indication: Indication,
        MedicationFields.Contraindication: Contraindication,
        MedicationFields.Precaution: Precaution,
        MedicationFields.AdverseEffects: AdverseEffects,
        MedicationFields.AdultDosage: AdultDosage,
        MedicationFields.ChildDosage: ChildDosage,
        MedicationFields.Max: Max,
      };
}
