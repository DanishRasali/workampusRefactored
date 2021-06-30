import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateTime currentMoment = DateTime.now();
String usDate = new DateFormat.yMMMMd('en_US').format(currentMoment);
String formattedDate = DateFormat('dd-MM-yyyy').format(currentMoment);
String timeNow = new DateFormat.Hm().format(currentMoment);

DateTime dateTimeFromTimestamp(dynamic val) {
  Timestamp timestamp;
  if (val is Timestamp) {
    timestamp = val;
  } else if (val is Map) {
    timestamp = Timestamp(val['_seconds'], val['_nanoseconds']);
  }
  if (timestamp != null) {
    return timestamp.toDate();
  } else {
    print('Unable to parse Timestamp from $val');
    return null;
  }
}


