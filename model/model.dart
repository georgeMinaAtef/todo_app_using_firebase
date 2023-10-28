
class ToDoModelList {
  List<ToDoModel>? data;

  ToDoModelList(this.data);

  ToDoModelList.fromJson(List<dynamic> json) {
    data = json.map((productJson) => ToDoModel.fromJson(productJson)).toList();
  }
}

class ToDoModel {
  String? id;
  late String titleTask;
  late String descriptionTask;
  late String dateTask;
  late String fromTime;
  late String toTime;
  String? status ;

  ToDoModel(
      {
        this.id,
        required this.titleTask,
        required this.descriptionTask,
        required this.dateTask,
        required this.fromTime,
        required this.toTime,
        required this.status,
        });


  Map<String,dynamic> toMap()
  {
    return <String,dynamic>
    {
      "titleTask":titleTask,
      "descriptionTask":descriptionTask,
      "dateTask":dateTask,
      "fromTime":fromTime,
      "toTime":toTime,
      "status":status,
    };
  }

  ToDoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleTask = json['titleTask'];
    descriptionTask = json['descriptionTask'];
    dateTask = json['dateTask'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['id'] = id;
    data['titleTask'] = titleTask;
    data['descriptionTask'] = descriptionTask;
    data['dateTask'] = dateTask;
    data['toTime'] = toTime;
    data['status'] = status;
    return data;
  }
}



//
//
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class ToDoModel
// {
//   String? docID;
//   final String titleTask;
//   final String descriptionTask;
//   final String dateTask;
//   final String fromTime;
//   final String toTime;
//   String status ;
//
//   ToDoModel(
//       {
//         this.docID,
//         required this.titleTask,
//         required this.descriptionTask,
//         required this.dateTask,
//         required this.fromTime,
//         required this.toTime,
//         required this.status,
//       } );
//
//   Map<String,dynamic> toMap()
//   {
//     return <String,dynamic>
//     {
//       "titleTask":titleTask,
//       "descriptionTask":descriptionTask,
//       "dateTask":dateTask,
//       "fromTime":fromTime,
//       "toTime":toTime,
//       "status":status,
//     };
//   }
//
//   factory ToDoModel.fromMap(Map<String, dynamic> map)
//   {
//     return ToDoModel(
//       docID: map['docID']  ,
//       titleTask: map['titleTask'] ,
//       descriptionTask:  map['descriptionTask'] ,
//       dateTask:  map['dateTask'],
//       fromTime:  map['fromTime'] ,
//       toTime:  map['toTime'] ,
//       status:  map['status'] ,
//     );
//   }
//
//
//   factory ToDoModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> doc)
//   {
//     return ToDoModel(
//       docID: doc.id,
//       titleTask: doc['titleTask'],
//       descriptionTask: doc['descriptionTask'],
//       dateTask: doc['dateTask'],
//       fromTime: doc['fromTime'],
//       toTime: doc['toTime'],
//       status: doc['status'],
//     );
//   }
//
// }