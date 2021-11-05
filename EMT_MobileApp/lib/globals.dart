import 'db/logdb_handler.dart';
import 'model/log.dart';

int nextLogID = 1;

void initNextLogID() async {
  List<Log> dbList = await LogDatabase.instance.readAll();
  if (dbList.length > 0) {
    nextLogID = dbList[dbList.length - 1].id!;
    nextLogID++;
  }
  print(nextLogID);
}

int currentLogID = -1;
