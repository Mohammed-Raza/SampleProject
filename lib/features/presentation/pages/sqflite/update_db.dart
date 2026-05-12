import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/mixins/validators_mixin.dart';
import 'package:sample_project/features/presentation/bloc/local_db/local_db_cubit.dart';
import '../../../../core/database/db_helper.dart';
import '../../../../core/error/exception_handler.dart';
import '../../widgets/common_widgets.dart';

class UpdateDbData extends StatefulWidget {
  final int id;
  final String name, description;
  const UpdateDbData(
      {super.key,
      required this.id,
      required this.name,
      required this.description});

  @override
  State<UpdateDbData> createState() => _UpdateDbDataState();
}

class _UpdateDbDataState extends State<UpdateDbData> with ValidatorsMixin {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool autoValidate = false, loaderEnable = false;

  @override
  void initState() {
    _nameController.text = widget.name;
    _descController.text = widget.description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(context.l10n.editGroceryItem),
      insetPadding: const EdgeInsets.all(10),
      content: SizedBox(
        width: context.width,
        child: Form(
          key: _formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: context.l10n.groceryName,
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) => valueEmptyValidator(
                      val!, context, context.l10n.groceryName)),
              const SizedBox(height: 30),
              TextFormField(
                  controller: _descController,
                  maxLines: 3,
                  decoration:
                      InputDecoration(labelText: context.l10n.description),
                  validator: (val) => valueEmptyValidator(
                      val!, context, context.l10n.description)),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: Text(context.l10n.cancel),
        ),
        ElevatedButton(
          onPressed: _onClickOfUpdate,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
          child: loaderEnable
              ? const CircularIndicator()
              : Text(context.l10n.update,
                  style: const TextStyle(color: Colors.white)),
        )
      ],
    );
  }

  void _onClickOfUpdate() async {
    try {
      if (!_formKey.currentState!.validate()) {
        autoValidate = true;
        setState(() {});
        return;
      }
      autoValidate = false;

      final dbHelper = DBHelper();

      loaderEnable = true;
      setState(() {});

      await Future.delayed(const Duration(seconds: 1));

      await dbHelper.updateGroceryItem(
          widget.id, _nameController.text.trim(), _descController.text.trim());

      loaderEnable = false;
      setState(() {});

      afterUpdate();
    } catch (e) {
      loaderEnable = false;
      setState(() {});
      ExceptionHandler().handleExceptionWithToastNotifier(e);
    }
  }

  void afterUpdate() {
    context.read<LocalDbCubit>().fetchLocallyStoredDbData();
    context.pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.itemUpdatedSuccessfully)),
    );
  }
}
