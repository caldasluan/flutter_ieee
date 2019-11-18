import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ieee/helper/schedule_helper.dart';
import 'package:flutter_ieee/pages/schedules.dart';
import 'dart:developer' as developer;

class LoginPage extends StatelessWidget {
  final loginController = new TextEditingController();
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/img/splash.png",
                width: 128,
                height: 128,
              ),
              Container(
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "Olá! Para continuar, digite seu nome de usuário",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: TextField(
                  controller: loginController,
                  decoration: InputDecoration(
                    labelText: "Login"
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 16),
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _saveLogin,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    "Continuar",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              )
            ],
          ),
        )
        ),
    );
  }

  _saveLogin() {
    ScheduleHelper.loginUser(loginController.text).then((Response value){
      developer.log(value.toString(), name: "loginUser");
      ScheduleHelper.idUser = value.toString();
      Navigator.push(
          _context,
          MaterialPageRoute(builder: (_context) => SchedulesPage())
      );
    });
  }
}