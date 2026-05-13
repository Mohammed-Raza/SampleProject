import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/presentation/bloc/drop_downs/drop_down_cubit.dart';
import 'package:sample_project/features/presentation/bloc/notifications/push_notifications_bloc.dart';

import '../../components/drop_downs.dart';
import '../../widgets/responsive_page.dart';

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
    return ResponsivePage(
      title: context.l10n.pushNotifications,
      maxWidth: 760,
      child: BlocBuilder<PushNotificationsBloc, PushNotificationsState>(
          builder: (context, state) {
        return Form(
          key: bloc.formKey,
          autovalidateMode: bloc.autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            spacing: 18,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ResponsiveHeroPanel(
                icon: Icons.notifications_active_outlined,
                title: context.l10n.pushNotifications,
                description: context.l10n.pushNotificationsDescription,
              ),
              ResponsivePanel(
                child: Column(
                  spacing: 18,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: bloc.tokenCtrl,
                      maxLines: 5,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: context.l10n.getAccessToken,
                        prefixIcon: const Icon(Icons.key_rounded),
                      ),
                    ),
                    FilledButton.icon(
                      onPressed: () => bloc.add(GetAccessTokenEvent()),
                      icon: const Icon(Icons.vpn_key_outlined),
                      label: Text(context.l10n.getAccessToken),
                    ),
                    GroceryCategoryDropdown(
                        onChange: context.read<DropDownCubit>().loadGroceries),
                    FilledButton.icon(
                      onPressed: () =>
                          bloc.add(RequestNotificationEvent(context)),
                      icon: const Icon(Icons.send_rounded),
                      label: Text(context.l10n.pushNotifications),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
