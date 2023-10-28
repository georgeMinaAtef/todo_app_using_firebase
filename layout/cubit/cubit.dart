
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_and_flutter_app/layout/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/model.dart';
import '../../module/archived_task.dart';
import '../../module/done_task.dart';
import '../../module/new_task.dart';
import '../../shared/component/component.dart';



class AppCubit extends Cubit<AppStates>
{

  AppCubit(): super(AppInitialState());

  // ................... AppCubit get(context) ..............................
  static AppCubit get(context) => BlocProvider.of(context);


  //...................  Lists To Add newTasks or doneTasks or archivedTasks ...
  late List<ToDoModel> newTasks = [];
  late List<ToDoModel> doneTasks = [];
  late List<ToDoModel> archivedTasks = [];

  // ...................  Database .............................................
  // late Database database;

  // ................... void changeBottomSheet  ...............................
  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheet(
  {
    required bool isShow ,
    required IconData icon
  })
  {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  // ................... List<String> label .................................
  List<String> label = [
    'New Task',
    'Done Task',
    'Archived Task'
  ];

  // ................... List<Widget> screens ..................................
  List<Widget> screens = [
    const NewTask(),
    const DoneTask(),
    const ArchivedTask(),
  ];

  // ................... void changeIndex ......................................
  int currentIndex = 0;
  void changeIndex(int index)
  {
    currentIndex = index;
    emit(AppChangeBottomNavBarSheet());
  }

  // ................... insertToDatabase ....................................

  final todoCollection = FirebaseFirestore.instance.collection('TodoApp');

  Future<void> addData(ToDoModel data) async {
    try {
      emit(AppGetDatabaseLoadingState());
      Map<String, dynamic> dataMap = data.toMap(); // Convert ToDoModel to Map
      await FirebaseFirestore.instance
          .collection('TodoApp').doc().set(dataMap)
          .then((value) {
        emit(AppInsertDatabaseState());
        getData();
      });
    } catch (e) {
      emit(AppErrorDatabaseState(error: e.toString()));
    }
  }



  void updateStatus({required ToDoModel model, required String status}) async {
    try {
      emit(AppGetDatabaseLoadingState());
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('TodoApp')
          .where('id', isEqualTo: model.id)
          .where('descriptionTask', isEqualTo: model.descriptionTask)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('TodoApp')
            .doc(documentId)
            .update({'status': status});

        emit(AppUpdateDatabaseState());
        getData();
      } else {
        emit(AppErrorDatabaseState(error: 'Document not found'));
      }
    } catch (e) {
      emit(AppErrorDatabaseState(error: e.toString()));
    }
  }



  void deleteModel({required ToDoModel model,}) async {
    try {
      emit(AppGetDatabaseLoadingState());
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('TodoApp')
          .where('id', isEqualTo: model.id)
          .where('descriptionTask', isEqualTo: model.descriptionTask)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs[0].id;
        await FirebaseFirestore.instance
            .collection('TodoApp')
            .doc(documentId)
            .delete();

        emit(AppDeleteSuccessDatabaseState());
        getData();
      } else {
        emit(AppDeleteErrorDatabaseState(error: 'Document not found'));
      }
    } catch (e) {
      emit(AppDeleteErrorDatabaseState(error: e.toString()));
    }
  }
  //
  // void deleteData({required String productId}) async {
  //   final docRef = FirebaseFirestore.instance.collection('TodoApp').doc(productId);
  //   await docRef.get().then((value)
  //   {
  //     docRef.delete();
  //     showToast(
  //       state: ToastStates.SUCCESS,
  //       text: 'Delete ToDo List Successfully',
  //     );
  //     emit(AppDeleteDatabaseState());
  //     getData();
  //   }).catchError((e){
  //     showToast(
  //       state: ToastStates.ERROR,
  //       text: 'Error When Delete ToDo List ${e.toString()}',
  //     );
  //     emit(AppErrorDeleteDatabaseState(error: e.toString()));
  //   });
  //
  //
  // }



  //  deleteProduct(String productId) async {
  //   await FirebaseFirestore.instance
  //       .collection('TodoApp')
  //       .doc(productId).delete().then((value)
  //   {
  //     emit(AppDeleteSuccessDatabaseState());
  //     showToast(
  //       state: ToastStates.SUCCESS,
  //       text: 'Delete Product Successfully',
  //     );
  //     getData();
  //   }).catchError((e){
  //     showToast(
  //       state: ToastStates.ERROR,
  //       text: ' Error When Delete Product ${e.toString()}',
  //     );
  //     emit(AppDeleteErrorDatabaseState(error: e.toString()));
  //   });
  // }




  //
  //
  // void deleteData({required String productId}) async {
  //   await FirebaseFirestore.instance
  //       .collection('TodoApp')
  //       .doc(productId)
  //       .delete().then((value)
  //   {
  //     showToast(
  //       state: ToastStates.SUCCESS,
  //       text: 'Delete ToDo List Successfully',
  //     );
  //     emit(AppDeleteDatabaseState());
  //     getData();
  //   }).catchError((e)
  //   {
  //       showToast(
  //         state: ToastStates.ERROR,
  //         text: ' Error When Delete ToDo List ${e.toString()}',
  //       );
  //       emit(AppErrorDeleteDatabaseState(error: e.toString()));
  //   });
  //
  // }



// Get data from Firebase
  Future<void> getData() async {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppGetDatabaseLoadingState());

    await todoCollection.get().then((snapshot) {
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        ToDoModel task = ToDoModel.fromJson(data);
        if (task.status == 'new') {
          newTasks.add(task);
        } else if (task.status == 'done') {
          doneTasks.add(task);
        } else {
          archivedTasks.add(task);
        }
        print(doc.id);
      });

      emit(AppGetSuccessDatabaseState(
          newTasks: newTasks,
          doneTasks: doneTasks,
          archivedTasks: archivedTasks
      ));
    });
  }



}
