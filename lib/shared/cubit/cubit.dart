// ignore_for_file: avoid_print, invalid_required_positional_param, curly_braces_in_flow_control_structures

import 'package:aetodo/module/archive/archive.dart';
import 'package:aetodo/module/delete/delete.dart';
import 'package:aetodo/module/done/done.dart';
import 'package:aetodo/module/tasks/tasks.dart';
import 'package:aetodo/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int inx = 0;
  late Database db;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  List<Map> deletedTasks = [];
  Icon fltBtn = const Icon(Icons.add);
  bool isShowBottomSheet = false;
  Color clrbg = Colors.blueGrey;
  bool isBody = true;

  List<Widget> screens = [
    const Tasks(),
    const Done(),
    const Archive(),
    const Delete(),
  ];

  List<String> titles = [
    'Tasks',
    'Done',
    'Archive',
    'Trash',
  ];

  void changeInx(int index) {
    inx = index;
    emit(AppChangeBtmNavBarState());
  }

  void bd(
    @required bool bd,
  ) {
    bd = false;
    emit(AppChangeState());
  }

  void createDB() {
    openDatabase(
      'aetodo.db',
      version: 1,
      onCreate: (db, version) {
        print("DB Created");
        db
            .execute(
                'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print("Crt Tbl Tasks Succ");
        }).catchError((error) {
          print("err crt ${error.toString()}");
        });
      },
      onOpen: (db) {
        getDB(db);
        print("DB Opened");
      },
    ).then((value) {
      db = value;
      emit(AppCreateDBState());
    });
  }

  Future insertDB(
    @required String title,
    @required String date,
    @required String time,
  ) async {
    await db.transaction(
      (txn) => txn
          .rawInsert(
              'INSERT INTO Tasks(title, date, time, status) VALUES("$title", "$date", "$time", "New")')
          .then((value) {
        print("$value Tasks Inserted Succ");
        // print("$title /$date /$time /$st");
        emit(AppInsertDBState());
        getDB(db);
      }).catchError(
        (error) {
          print("err ins ${error.toString()}");
        },
      ),
    );
  }

  getDB(db) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    deletedTasks = [];

    db.rawQuery('SELECT * FROM Tasks').then((value) {
      emit(AppLoadingState());

      value.forEach((element) {
        if (element['status'] == 'New')
          newTasks.add(element);
        else if (element['status'] == 'Done')
          doneTasks.add(element);
        else if (element['status'] == 'Archived')
          archivedTasks.add(element);
        else
          deletedTasks.add(element);
      });

      print(value);

      emit(AppGetDBState());
    });
  }

  uptadeDB(
    @required String st,
    @required int id,
  ) async {
    db.rawUpdate('UPDATE Tasks SET status = ? WHERE id = ?', [
      st,
      '$id',
    ]).then((value) {
      emit(AppUptadeDBState());
      getDB(db);
    });
  }

  deleteDB(
    @required int id,
  ) async {
    db.rawDelete(
      'DELETE FROM Tasks WHERE id = ?',
      [id],
    ).then((value) {
      emit(AppDeleteDBState());
      getDB(db);
    });
  }

  void changeBtmBtn({
    required bool isShow,
    required Icon btnIc,
  }) {
    isShowBottomSheet = isShow;
    fltBtn = btnIc;
    emit(AppChangeBtmBtnState());
  }
}
