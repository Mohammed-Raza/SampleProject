import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/mixins/validators_mixin.dart';
import 'package:sample_project/features/data/models/category_model.dart';
import 'package:sample_project/core/database/db_helper.dart';
import 'package:sample_project/features/presentation/bloc/drop_downs/drop_down_cubit.dart';
import 'package:sample_project/features/presentation/widgets/common_widgets.dart';
import '../../components/drop_downs.dart';

class CreateDbAndAddData extends StatefulWidget {
  const CreateDbAndAddData({super.key});

  @override
  State<CreateDbAndAddData> createState() => _CreateDbAndAddDataState();
}

class _CreateDbAndAddDataState extends State<CreateDbAndAddData>
    with ValidatorsMixin {
  final _formKey = GlobalKey<FormState>();

  bool autoValidate = false, loaderEnable = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future<void> _saveToDatabase() async {
    try {
      if (!_formKey.currentState!.validate()) {
        autoValidate = true;
        setState(() {});
        return;
      }
      autoValidate = false;

      var dropdownCubit = context.read<DropDownCubit>();

      if (dropdownCubit.selectedCategoryId != null) {
        loaderEnable = true;
        setState(() {});
        final dbHelper = DBHelper();

        int categoryId = dropdownCubit.categories
            .where((e) => e.key == dropdownCubit.selectedCategoryId)
            .first
            .id;

        await dbHelper.insertGrocery(CategoryModel(
            categoryId: categoryId,
            name: _nameController.text.trim(),
            categoryType: dropdownCubit.selectedCategoryId!,
            description: _descController.text.trim()));

        loaderEnable = false;
        setState(() {});

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.grocerySavedLocally)),
          );
          // Clear fields
          _nameController.clear();
          _descController.clear();
        }
      } else if (dropdownCubit.selectedCategoryId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.pleaseSelectCategoryType)),
        );
      }
    } catch (e) {
      loaderEnable = false;
      setState(() {});
      ExceptionHandler().handleExceptionWithToastNotifier(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(context.l10n.addGroceryData, style: context.titleLarge),
                IconButton(
                    onPressed: () => context.pop(),
                    icon: const Icon(Icons.close_rounded))
              ],
            ),
            const Gap(20),
            const Divider(thickness: 0.8),
            const Gap(20),
            const GroceryCategoryDropdown(),
            const SizedBox(height: 20),
            TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: context.l10n.groceryName,
                  prefixIcon: const Icon(Icons.shopping_basket_outlined),
                ),
                validator: (val) => valueEmptyValidator(
                    val!, context, context.l10n.groceryName)),
            const SizedBox(height: 20),
            TextFormField(
                controller: _descController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: context.l10n.description,
                  prefixIcon: const Icon(Icons.notes_rounded),
                ),
                validator: (val) => valueEmptyValidator(
                    val!, context, context.l10n.description)),
            const SizedBox(height: 30),
            FilledButton.icon(
              onPressed: _saveToDatabase,
              style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              icon: loaderEnable
                  ? const CircularIndicator()
                  : const Icon(Icons.save_outlined),
              label: Text(context.l10n.submit),
            ),
          ],
        ),
      ),
    );
  }
}
