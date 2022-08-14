
class History {
  String? marks;
  String? courseCode;
  String? courseName;
  DateTime? created;

  History();

  Map<String, dynamic> toJson() => {
        'marks': marks,
        'courseCode': courseCode,
        'courseName': courseName,
        'created': created,
      };

  History.fromSnapshot(snapshot)
      : marks = snapshot.data()['marks'],
        courseCode = snapshot.data()['courseCode'],
        courseName = snapshot.data()['courseName'],
        created = snapshot.data()['created'].toDate();
}
