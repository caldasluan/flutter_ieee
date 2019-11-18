import 'package:dio/dio.dart';

class ScheduleHelper {
  static final dio = Dio();
  static String _idUser;

  static String _getUrl(String path) {
    return "http://flutter-iee.herokuapp.com/" + path;
  }

  static Future<Response> loginUser(String user) {
    return dio.post(_getUrl("user"), data: {"name": user});
  }

  static Future<Response> newSchedule(String title, String description) {
    return dio.post(_getUrl("schedule"), data: {"userId": _idUser, "title": title, "description": description});
  }

  static Future<Response> getSchedule() {
    return dio.get(_getUrl("userSchedules/$_idUser"));
  }
  
  static Future<Response> finishSchedule(String id) {
    return dio.put(_getUrl("finnishSchedule/$id"));
  }

  static String get idUser => _idUser;

  static set idUser(String value) {
    _idUser = value;
  }
}