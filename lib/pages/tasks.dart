import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ieee/entity/task.dart';
import 'package:flutter_ieee/helper/task_helper.dart';
import 'dart:developer' as developer;
import 'add_task.dart';

class TasksPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TasksPageState();
  }
}

class TasksPageState extends State<TasksPage> {
  BuildContext _context;
  List<Widget> _list = List();

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        title: Text("Tarefas"),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ListView(
          children: _list,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: Icon(Icons.add),
      ),
    );
  }

  _addTask() {
    Navigator.push(
        _context,
        MaterialPageRoute(builder: (_context) => AddTaskPage())
    );
  }

  Future<Null> _refresh() {
    return TaskHelper.getTasks().then((Response value) {
      developer.log(value.toString(), name: "getTasks");

      setState(() {
        List<Widget> list = List();
        for (final task in value.data) {
          list.add(TaskCard(task["title"], task["scheduledescription"]));
        }
        _list = list;
      });
    });
  }
}

class TaskCard extends StatefulWidget {
  final String _title;
  final String _description;

  TaskCard(this._title, this._description);

  @override
  State<StatefulWidget> createState() {
    return TaskCardState(_title, _description);
  }
}

class TaskCardState extends State<TaskCard> {
  String _title;
  String _description;

  TaskCardState(this._title, this._description);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Card(
        child: ListTile(
          title: Text(_title),
          subtitle: Text(_description),
        ),
      ),
    );
  }
}