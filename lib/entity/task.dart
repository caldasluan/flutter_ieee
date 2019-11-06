class Task{
  int scheduleid, userid;
  String title, scheduledescription, duedate;
  bool done;

  Task(Map<String, dynamic> json)
      : scheduleid = json['scheduleid'],
        userid = json['userid'],
        title = json['title'],
        scheduledescription = json['scheduledescription'],
        duedate = json['duedate'],
        done = json['done'];
}