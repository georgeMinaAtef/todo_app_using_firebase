
import 'package:firebase_and_flutter_app/model/model.dart';

abstract class AppStates{}

class AppInitialState extends AppStates{}

class AppChangeBottomNavBarSheet extends AppStates{}

class AppChangeBottomSheetState extends AppStates{}

class AppInsertDatabaseState extends AppStates{}

class AppErrorDatabaseState extends AppStates{
  final String error;
  AppErrorDatabaseState({ required this.error});
}

class AppErrorDeleteDatabaseState extends AppStates{
  final String error;
  AppErrorDeleteDatabaseState({ required this.error});
}
class AppErrorUpdateDatabaseState extends AppStates{
  final String error;
  AppErrorUpdateDatabaseState({ required this.error});
}

class AppCreateDatabaseState extends AppStates{}

class AppGetDatabaseState extends AppStates{}

class AppGetSuccessDatabaseState extends AppStates{
  final List<ToDoModel> newTasks;
  final List<ToDoModel> doneTasks;
  final List<ToDoModel> archivedTasks;

  AppGetSuccessDatabaseState({
    required this.newTasks,
    required this.doneTasks,
    required this.archivedTasks,
  });
}

class AppGetErrorDatabaseState extends AppStates{
  final String error;
  AppGetErrorDatabaseState({ required this.error});
}

class AppGetDatabaseLoadingState extends AppStates{}

class AppUpdateDatabaseState extends AppStates{}

class AppDeleteSuccessDatabaseState extends AppStates {}
class AppDeleteErrorDatabaseState extends AppStates {
  final String error;
  AppDeleteErrorDatabaseState({ required this.error});
}
