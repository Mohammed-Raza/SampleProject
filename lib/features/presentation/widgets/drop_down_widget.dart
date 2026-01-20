import 'package:flutter/material.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/domain/entities/drop_down_entity.dart';

import '../../../core/utils/enums.dart';

class CustomizedDropDown extends StatelessWidget {
  final dynamic id;
  final List<DropDownEntity> items;
  final ValueChanged<dynamic>? callback;
  final String label, selectLabel;
  final double? width;
  final StateType type;
  final String? errorText;
  final Function()? onTapOfRetry;
  final String? Function(dynamic)? validator;
  const CustomizedDropDown(
      {super.key,
      this.id,
      this.items = const [],
      this.callback,
      this.label = '',
      this.width,
      this.type = StateType.success,
      this.onTapOfRetry,
      this.errorText,
      this.validator,
      this.selectLabel = 'Select items'});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? context.width,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButtonFormField(
            initialValue: id == null
                ? null
                : (items.any((element) => element.key == id) ? id : null),
            isExpanded: true,
            isDense: true,
            validator: validator,
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
                label: Text(label)),
            icon: getIcon,
            iconDisabledColor: Colors.grey,
            disabledHint: hintText(),
            hint: hintText(color: Colors.teal),
            items: items.map((e) => dropDownMenuItems(e.key, e.name)).toList(),
            onChanged: callback),
      ),
    );
  }

  Text hintText({Color color = Colors.grey}) =>
      Text(getHintText, style: TextStyle(fontSize: 12, color: color));

  DropdownMenuItem dropDownMenuItems(String? id, String? value,
      {bool isSelected = false}) {
    return DropdownMenuItem(
      value: id,
      child: Text('$value',
          textAlign: TextAlign.center,
          style: TextStyle(color: isSelected ? Colors.indigo : null)),
    );
  }

  Widget? get getIcon {
    switch (type) {
      case StateType.loading:
        return null;
      case StateType.success:
        return const Icon(Icons.arrow_drop_down, size: 20);
      case StateType.error:
        return IconButton(
            onPressed: onTapOfRetry,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.refresh, color: Colors.teal, size: 20));
    }
  }

  String get getHintText {
    switch (type) {
      case StateType.loading:
        return 'Loading...';
      case StateType.success:
        return errorText ??
            (isDataEmpty ? 'No data is available' : selectLabel);
      case StateType.error:
        return errorText ?? 'Something went wrong !!';
    }
  }

  bool get isDataEmpty => items.isEmpty;
}
