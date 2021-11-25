import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'db/handbookdb_handler.dart';
import 'db/logdb_handler.dart';
import 'model/protocol.dart';
import 'model/chart.dart';
import 'model/medication.dart';
import 'globals.dart' as globals;

class MedDrawer extends StatefulWidget {
  final int certification;
  final List<Protocol> protocols;
  final List<Medication> medications;

  MedDrawer(@required this.certification, @required this.protocols,
      @required this.medications);

  @override
  _MedDrawerState createState() => _MedDrawerState(
      certification: certification,
      protocols: protocols,
      medications: medications);
}

class _MedDrawerState extends State<MedDrawer>
    with SingleTickerProviderStateMixin {
  final int certification;
  final List<Protocol> protocols;
  final List<Medication> medications;

  _MedDrawerState(
      {required this.certification,
      required this.protocols,
      required this.medications});

  @override
  void initState() {
    super.initState();
  }

  Future addMedication(String name, String dosageInfo, String routeInfo) async {
    DateTime startTime = DateTime.now();
    String formattedTime = DateFormat.Hms().format(startTime);
    medLog newMedication = new medLog(
        type: name,
        dosage: dosageInfo,
        route: routeInfo,
        timeStamp: formattedTime);
    dynamic jsonString = newMedication.toJson();
    await LogDatabase.instance
        .additionalDataUpdate((jsonString.toString()), true);
  }

  /// Grab the ids for a specific certification as a list
  Future<List<Medication>> findMedicationsForCertification(
      int certification) async {
    List<String> medIDs = [];
    protocols.forEach((element) {
      if (element.Certification == certification &&
          element.HasAssociatedMedication == 1 &&
          element.Medications != null) {
        List<String> t = element.Medications.toString()
            .replaceAll(new RegExp(r'[{}]'), '')
            .split(",");
        t.removeWhere((element) => element == '');
        debugPrint("Protocol has medications: " +
            t.toString() +
            " for certification: " +
            certification.toString());
        medIDs = t;
      }
    });
    HandbookDatabase.instance
        .readAllMedications()
        .then((List<Medication> bmedications) async {
      for (var i = 0; i < bmedications.length; i++) {
        debugPrint(
            "Medication Entry >>> " + bmedications[i].toJson().toString());
      }
    });

    List<Medication> meds = [];

    medications.forEach((element) async {
      if (medIDs.contains(element.ID.toString())) {
        meds.add(element);
      }
    });

    return meds;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _textFieldController = TextEditingController();
    return FutureBuilder(
        future: findMedicationsForCertification(certification),
        builder: (ctx, snapshot) {
          // Checking if future is resolved
          if (snapshot.connectionState == ConnectionState.done) {
            // If we got an error
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occured',
                  style: TextStyle(fontSize: 18),
                ),
              );

              // if we got our data
            } else if (snapshot.hasData) {
              List<Medication> certificationMeds =
                  snapshot.data as List<Medication>;
              String dosage = "";
              String _myRoute = '';
              final _formKey = GlobalKey<FormState>();
              return Drawer(
                  // Add a ListView to the drawer. This ensures the user can scroll
                  // through the options in the drawer if there isn't enough vertical
                  // space to fit everything.
                  child: ListView.builder(
                      itemCount: certificationMeds.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new ListTile(
                            title: Text('${certificationMeds[index].Name}'),
                            onTap: () {
                              if (globals.currentLogID != -1) {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                        title: Text('Add Medication'),
                                        content: StatefulBuilder(builder:
                                            (BuildContext context,
                                                StateSetter setState) {
                                          return Form(
                                            key: _formKey,
                                            child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  TextFormField(
                                                    controller:
                                                        _textFieldController,
                                                    decoration: InputDecoration(
                                                        hintText: "Dosage"),
                                                    onSaved: (value) {
                                                      dosage = value!;
                                                    },
                                                    onChanged: (value) {
                                                      setState(() {
                                                        dosage = value;
                                                      });
                                                    },
                                                    validator: (String? value) {
                                                      return (value == null ||
                                                              value.isEmpty)
                                                          ? 'Please Insert Dosage.'
                                                          : null;
                                                    },
                                                  ),
                                                  Container(
                                                    padding: EdgeInsets.all(16),
                                                    child: DropDownFormField(
                                                      titleText: 'Route',
                                                      hintText: 'Insert Route',
                                                      value: _myRoute,
                                                      onSaved: (value) {
                                                        setState(() {
                                                          _myRoute = value;
                                                        });
                                                      },
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _myRoute = value;
                                                        });
                                                      },
                                                      dataSource: [
                                                        {
                                                          "display": "IM",
                                                          "value": "IM",
                                                        },
                                                        {
                                                          "display": "IV",
                                                          "value": "IV",
                                                        },
                                                        {
                                                          "display": "IO",
                                                          "value": "IO",
                                                        },
                                                        {
                                                          "display": "NEB",
                                                          "value": "NEB",
                                                        },
                                                      ],
                                                      textField: 'display',
                                                      valueField: 'value',
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16.0),
                                                    child: ElevatedButton(
                                                        onPressed: () {
                                                          if (_formKey
                                                              .currentState!
                                                              .validate()) {
                                                            addMedication(
                                                                '${certificationMeds[index].Name}',
                                                                dosage,
                                                                _myRoute);
                                                          }
                                                          _textFieldController
                                                              .clear();
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text('Save')),
                                                  )
                                                ]),
                                          );
                                        }));
                                  },
                                );
                              } else {
                                showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                          title: const Text('No Active Log'),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: const <Widget>[
                                                Text(
                                                    'There is no in progress log.'),
                                                Text(
                                                    'Please start a log to add a medication.'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: const Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        ));
                              }
                            });
                      }));
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
