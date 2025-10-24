import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/presentation/bloc/drop_downs/drop_down_cubit.dart';
import 'package:sample_project/features/presentation/bloc/notifications/push_notifications_bloc.dart';

import '../../components/drop_downs.dart';

class PushNotificationsScreen extends StatefulWidget {
  const PushNotificationsScreen({super.key});

  @override
  State<PushNotificationsScreen> createState() =>
      _PushNotificationsScreenState();
}

class _PushNotificationsScreenState extends State<PushNotificationsScreen> {
  @override
  void initState() {
    context.read<DropDownCubit>()
      ..selectedCategoryId = null
      ..selectedGroceryId = null
      ..categories.clear()
      ..groceries.clear();
    context.read<PushNotificationsBloc>().autoValidate = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<PushNotificationsBloc>();
    return Scaffold(
      appBar: AppBar(title: const Text('Push Notifications')),
      body: BlocBuilder<PushNotificationsBloc, PushNotificationsState>(
          builder: (context, state) {
        return Form(
          key: bloc.formKey,
          autovalidateMode: bloc.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              spacing: 20,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                    controller: bloc.tokenCtrl, maxLines: 5, readOnly: true),
                ElevatedButton(
                    onPressed: () => bloc.add(GetAccessTokenEvent()),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(context.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.cyan),
                    child: const Text('Get Access Token',
                        style: TextStyle(color: Colors.white))),
                const SizedBox(height: 1),
                GroceryCategoryDropdown(
                    onChange: context.read<DropDownCubit>().loadGroceries),
                const SizedBox(height: 1),
                // const GroceriesDropdown(),
                // const SizedBox(height: 1),
                ElevatedButton(
                    onPressed: () =>
                        bloc.add(RequestNotificationEvent(context)),
                    style: ElevatedButton.styleFrom(
                        fixedSize: Size(context.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8))),
                    child: const Text('Push Notification',
                        style: TextStyle(color: Colors.white))),
              ],
            ),
          ),
        );
      }),
    );
  }
}
