import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import '../../../core/mixins/validators_mixin.dart';
import '../../../core/utils/enums.dart';
import '../bloc/drop_downs/drop_down_cubit.dart';
import '../widgets/drop_down_widget.dart';

class GroceryCategoryDropdown extends StatefulWidget {
  final void Function()? onChange;
  const GroceryCategoryDropdown({super.key, this.onChange});

  @override
  State<GroceryCategoryDropdown> createState() =>
      _GroceryCategoryDropdownState();
}

class _GroceryCategoryDropdownState extends State<GroceryCategoryDropdown>
    with ValidatorsMixin {
  @override
  void initState() {
    context.read<DropDownCubit>()
      ..selectedCategoryId = null
      ..categories.clear()
      ..loadCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DropDownCubit>();
    return BlocBuilder<DropDownCubit, DropDownState>(
        buildWhen: (previous, current) => current is GroceryCategoryState,
        builder: (context, state) {
          return CustomizedDropDown(
              id: bloc.selectedCategoryId,
              items: bloc.categories,
              callback: (id) {
                bloc.onChangeOfCategory(id);
                if (widget.onChange != null) {
                  widget.onChange!();
                }
              },
              type: _getStateType(state),
              label: context.l10n.category,
              validator: (id) =>
                  dropdownEmptyValidator(context, id, context.l10n.category),
              errorText: state.runtimeType is CategoryError
                  ? (state as CategoryError).errorText
                  : null,
              onTapOfRetry: state.runtimeType is CategoryError
                  ? bloc.loadCategories
                  : null);
        });
  }

  StateType _getStateType(DropDownState state) {
    switch (state.runtimeType) {
      case const (CategoryLoading):
        return StateType.loading;
      case const (CategorySuccess):
        return StateType.success;
      case const (CategoryError):
        return StateType.error;
      default:
        return StateType.success;
    }
  }
}

class GroceriesDropdown extends StatefulWidget {
  const GroceriesDropdown({super.key});

  @override
  State<GroceriesDropdown> createState() => _GroceriesDropdownState();
}

class _GroceriesDropdownState extends State<GroceriesDropdown>
    with ValidatorsMixin {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<DropDownCubit>();
    return BlocBuilder<DropDownCubit, DropDownState>(
        buildWhen: (previous, current) => current is GroceriesState,
        builder: (context, state) {
          return CustomizedDropDown(
              id: bloc.selectedGroceryId,
              items: bloc.groceries,
              callback: bloc.onChangeOfGrocery,
              type: _getStateType(state),
              label: context.l10n.grocery,
              validator: (id) =>
                  dropdownEmptyValidator(context, id, context.l10n.grocery),
              errorText: state.runtimeType is GroceriesError
                  ? (state as GroceriesError).errorText
                  : null,
              onTapOfRetry: state.runtimeType is GroceriesError
                  ? bloc.loadGroceries
                  : null);
        });
  }

  StateType _getStateType(DropDownState state) {
    switch (state.runtimeType) {
      case const (GroceriesLoading):
        return StateType.loading;
      case const (GroceriesSuccess):
        return StateType.success;
      case const (GroceriesError):
        return StateType.error;
      default:
        return StateType.success;
    }
  }
}
