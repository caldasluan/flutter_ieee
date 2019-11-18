import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ieee/helper/schedule_helper.dart';
import 'dart:developer' as developer;
import 'add_schedule.dart';

class SchedulesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SchedulesPageState();
  }
}

class SchedulesPageState extends State<SchedulesPage> {
  BuildContext _context;
  List<dynamic> _list = List();

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (context, index) {
            final item = _list[index];

            if (item["done"]) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Card(
                  child: ListTile(
                    title: Text(item["title"]),
                    subtitle: Text(item["scheduledescription"]),
                    enabled: !item["done"],
                  ),
                ),
              );
            }
            else {
              return Dismissible(
                  key: Key(item["scheduleid"].toString()),
                  onDismissed: (direction) {
                    setState(() {
                      _list[index]["done"] = true;
                      _list.add(_list[index]);
                      _list.removeAt(index);

                      ScheduleHelper.finishSchedule(item["scheduleid"].toString());
                    });

                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Finalizado!")
                      )
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 16),
                    child: Card(
                      child: ListTile(
                        title: Text(item["title"]),
                        subtitle: Text(item["scheduledescription"]),
                        enabled: !item["done"],
                      ),
                    ),
                  )
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSchedule,
        child: Icon(Icons.add),
      ),
    );
  }

  _addSchedule() {
    Navigator.push(
        _context,
        MaterialPageRoute(builder: (_context) => AddSchedulePage())
    );
  }

  Future<Null> _refresh() {
    return ScheduleHelper.getSchedule().then((Response value) {
      developer.log(value.toString(), name: "getSchedules");

      setState(() {
        _list = value.data;
        _list.sort((o1, o2) => o1["done"] ? 1 : -1);
      });
    });
  }
}