import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../layout/cubit/cubit.dart';
import '../layout/cubit/states.dart';
import '../shared/component/component.dart';

class NewTask extends StatelessWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit, AppStates>(

      listener: (context, state){},

      builder: (context, state)
      {
        var tasks = AppCubit.get(context).newTasks;

        return tasksBuilder(
            tasks: tasks
        );
      },

    );
  }
}
