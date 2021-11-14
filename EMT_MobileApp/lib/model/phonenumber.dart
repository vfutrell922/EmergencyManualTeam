import 'package:flutter/rendering.dart';

final String tablePhoneNumbers = 'phonenum';

class PhoneNumberFields {
  static final List<String> values = [
    ID,
    HospitalName,
    Number,
  ];

  static final String ID = 'ID';
  static final String HospitalName = 'HospitalName';
  static final String Number = 'Number';
}

class PhoneNumber {
  final int? ID;
  final String? HospitalName;
  final String? Number;

  const PhoneNumber({
    this.ID,
    this.HospitalName,
    this.Number,
  });

  PhoneNumber copy({
    int? ID,
    String? HospitalName,
    String? Number,
  }) =>
      PhoneNumber(
        ID: ID ?? this.ID,
        HospitalName: HospitalName ?? this.HospitalName,
        Number: Number ?? this.Number,
      );

  static PhoneNumber fromJson(Map<String, Object?> json) => PhoneNumber(
        ID: json[PhoneNumberFields.ID] as int?,
        HospitalName: json[PhoneNumberFields.HospitalName] as String?,
        Number: json[PhoneNumberFields.Number] as String?,
      );
  Map<String, Object?> toJson() => {
        PhoneNumberFields.ID: ID,
        PhoneNumberFields.HospitalName: HospitalName,
        PhoneNumberFields.Number: Number,
      };
}
