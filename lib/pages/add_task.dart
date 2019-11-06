import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ieee/helper/task_helper.dart';
import 'dart:developer' as developer;

class AddTaskPage extends StatelessWidget {
  BuildContext _context;
  final _titleController = new TextEditingController();
  final _descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar tarefa"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Título"
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: "Descrição"
              ),
            ),
            RaisedButton(
              onPressed: _saveTask,
              color: Theme.of(context).primaryColor,
              child: Text(
                "SALVAR",
                style: TextStyle(
                  color: Colors.white
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  _saveTask() {
    String title = _titleController.text;
    String description = _descriptionController.text;

    TaskHelper.newTask(title, description).then((Response value) {
      developer.log(value.toString(), name: "newTask");
      Navigator.pop(_context);
    });
  }
}