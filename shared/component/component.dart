
// ....................... default Text Form Filed .............................

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_and_flutter_app/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../mode_cubit/cubit.dart';


Widget defaultTextFormField({
  FocusNode? focusNode,
  required TextEditingController controller,
  required TextInputType type,
  required String? Function(String?) validator,
  required String label,
  String? hint,
  onTap,
  onChanged,
  Function(String)? onFieldSubmitted,
  bool isPassword = false,
  bool isClickable = true,
  InputDecoration? decoration,
  IconData? suffix,
  IconData? prefix,
  Function? suffixPressed,
}) =>
    TextFormField(
      focusNode: FocusNode(),
      style: const TextStyle(),
      maxLines: 1,
      minLines: 1,
      controller: controller,
      validator: validator,
      enabled: isClickable,
      onTap: onTap,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      obscureText: isPassword,
      keyboardType: type,
      autofocus: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          prefix,
          color: Colors.grey,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          onPressed: () {
            suffixPressed!();
          },
          icon: Icon(
            suffix,
            color: Colors.grey,
          ),
        )
            : null,
        filled: true,
        isCollapsed: false,
        fillColor: Colors.deepOrange.withOpacity(0.2),
        hoverColor: Colors.red.withOpacity(0.2),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontStyle: FontStyle.italic,
          color: Colors.deepOrangeAccent,
        ),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white),
        focusColor: Colors.white,
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.green,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );


// ............................  Widget build Task Item .......................
Widget buildTaskItem
    (ToDoModel model, context)
=>   Dismissible(

  key: Key(model.id.toString()),

  child:   Padding(



    padding: const EdgeInsets.all(10),



    child: Card(

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        mainAxisSize: MainAxisSize.min,

        children:  [



          Row(children: [



            const Icon(Icons.home),



            Padding(

              padding: const EdgeInsets.only(left: 20),

              child: Text(

                model.titleTask,

              ),

            ),



            const Spacer(),

            IconButton(
                onPressed: ()
                {
                  // context.read<AppCubit>().updateStatus(model:model , status: 'done');
                  AppCubit.get(context).updateStatus(
                    model: model,
                    status: 'done',
                  );

                },

                icon: const Icon(Icons.check_box_outlined,)

            ),



            IconButton(

                onPressed: ()

                {
                  // context.read<AppCubit>().updateStatus(model:model , status: 'archived');
                  AppCubit.get(context).updateStatus(
                    model: model,
                    status: 'archived',
                  );

                },

                icon: const Icon(Icons.archive,)

            ),

          ],),



          Padding(

            padding: const EdgeInsets.only(left: 10,bottom: 5),

            child: Text(

              model.descriptionTask,

              maxLines: 2,

              overflow: TextOverflow.ellipsis,

            ),

          ),



          Padding(

            padding: const EdgeInsets.only(left: 10, bottom: 5),

            child: Text(

              model.dateTask,

            ),

          ),



          Padding(

            padding: const EdgeInsets.only(left: 10,bottom: 10,right: 20),

            child: Row(

              children: [

                Text(

                  'Time:   From ${model.fromTime}',

                ),
                const Spacer(),
                Text(
                  'To  ${model.toTime}',
                ),
              ],
            ),
          ),
        ],

      ),

    ),
  ),

  onDismissed: (direction)
  {
    // context.read<AppCubit>().deleteModel(model:model );
    AppCubit.get(context).deleteModel(
      model: model,
    );
  },

);


// ............................... tasks Builder ...................................

Widget tasksBuilder
    ({required List<ToDoModel> tasks})
=>     ConditionalBuilder(
  builder:(context) => ListView.separated(
      itemBuilder: (context , index) {
       return  buildTaskItem(tasks[index], context);
      },
      separatorBuilder: (context , index) => Padding(
        padding: const EdgeInsetsDirectional.only(start: 20),
        child: Container(
          width: double.infinity,
          height: 2,
          color: ModeCubit.get(context).backgroundColor,
        ),
      ),
      itemCount: tasks.length
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const Icon(
          Icons.menu,
          size: 100,
        ),
        const SizedBox(height: 10,),
        Text(
          'No Data Yet , Please Add Some Data?',
          style:  Theme.of(context).textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  ),
  condition: tasks.isNotEmpty ,

);




/*
  return Dismissible(
          key: Key(tasks[index].id.toString()),
          child:   Padding(

            padding: const EdgeInsets.all(10),

            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children:  [

                  Row(children: [

                    const Icon(Icons.home),

                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        tasks[index].titleTask,
                      ),
                    ),

                    const Spacer(),

                    IconButton(
                        onPressed: ()
                        {
                          // CrsP0ZEuMsuSaaWkLBSL
                          AppCubit.get(context).updateData(
                            id:  '${tasks[index].id}',
                            status: 'done',
                          );

                        },
                        icon: const Icon(Icons.check_box_outlined,)
                    ),

                    IconButton(
                        onPressed: ()
                        {
                          AppCubit.get(context).updateData(
                              status: 'archived',
                              id:  '${tasks[index].id}'
                          );
                        },
                        icon: const Icon(Icons.archive,)
                    ),
                  ],),

                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 5),
                    child: Text(
                      tasks[index].descriptionTask,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10, bottom: 5),
                    child: Text(
                      tasks[index].dateTask,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 10,bottom: 10,right: 20),
                    child: Row(
                      children: [
                        Text(
                          'Time:   From ${tasks[index].fromTime}',
                        ),
                        const Spacer(),

                        Text(
                          'To  ${tasks[index].toTime}',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ),

          ),
          onDismissed: (direction)
          {
            print(tasks[index].id) ;
            AppCubit.get(context).deleteProduct(tasks[index].id.toString());
          },
        );
 */



// ------------------------------ show toast -----------------------------------
void showToast({
  String? text,
  required ToastStates state,
}) =>
    Fluttertoast.showToast(
      msg: text!,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0,
    );

enum ToastStates { ERROR, SUCCESS, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}