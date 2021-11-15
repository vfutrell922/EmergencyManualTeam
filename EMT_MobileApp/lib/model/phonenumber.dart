import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

final String tablePhoneNumbers = 'phonenum';

class PhoneNumberFields {
  static final List<String> values = [
    Id,
    hospitalName,
    numberString,
  ];

  static final String Id = 'Id';
  static final String hospitalName = 'hospitalName';
  static final String numberString = 'numberString';
}

class PhoneNumber {
  final int? Id;
  final String hospitalName;
  final String numberString;

  const PhoneNumber({
    this.Id,
    required this.hospitalName,
    required this.numberString,
  });

  PhoneNumber copy({
    int? Id,
    String? hospitalName,
    String? numberString,
  }) =>
      PhoneNumber(
        Id: Id ?? this.Id,
        hospitalName: hospitalName ?? this.hospitalName,
        numberString: numberString ?? this.numberString,
      );

  static String MakeHospitalName(String? hn) {
    if (hn == null) {
      return "Unspecified Hospital";
    } else
      return hn;
  }

  static String MakeNumber(String? pn) {
    if (pn == null) {
      return "Unspecified";
    } else
      return pn;
  }

  static PhoneNumber fromWebJson(Map<String, Object?> json) => PhoneNumber(
        Id: json[PhoneNumberFields.Id] as int?,
        hospitalName:
            MakeHospitalName(json[PhoneNumberFields.hospitalName] as String?),
        numberString:
            MakeNumber(json[PhoneNumberFields.numberString] as String?),
      );

  static PhoneNumber fromJson(Map<String, Object?> json) => PhoneNumber(
        Id: json[PhoneNumberFields.Id] as int?,
        hospitalName: json[PhoneNumberFields.hospitalName] as String,
        numberString: json[PhoneNumberFields.numberString] as String,
      );
  Map<String, Object?> toJson() => {
        PhoneNumberFields.Id: Id,
        PhoneNumberFields.hospitalName: hospitalName,
        PhoneNumberFields.numberString: numberString,
      };
}
