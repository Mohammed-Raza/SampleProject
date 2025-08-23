import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sample_project/core/extensions/build_extensions.dart';

class AddQtyTextField extends StatefulWidget {
  final Function() onSubtract, onAdd;
  final Function(dynamic)? onClickOfTextField;
  final TextEditingController? controller;
  const AddQtyTextField(
      {super.key,
      required this.controller,
      required this.onSubtract,
      required this.onAdd,
      required this.onClickOfTextField});

  @override
  State<AddQtyTextField> createState() => _AddQtyTextFieldState();
}

class _AddQtyTextFieldState extends State<AddQtyTextField> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GradientBubbleButton(
              icon: Icons.remove,
              iconColor: const Color.fromRGBO(255, 95, 109, 1),
              onTap: widget.onSubtract),
          Container(
            width: 100,
            height: 32,
            alignment: Alignment.center,
            child: TextField(
                controller: widget.controller,
                keyboardType: TextInputType.number,
                maxLength: 3,
                maxLines: 1,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                enabled: true,
                cursorHeight: 15,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]+'))
                ],
                onChanged: widget.onClickOfTextField,
                focusNode: focusNode,
                decoration: InputDecoration(
                    hintText: '0',
                    hintStyle: const TextStyle(color: Colors.grey),
                    counter: const Offstage(),
                    enabledBorder: _textFieldBorder,
                    border: _textFieldBorder,
                    focusedBorder: _textFieldBorder,
                    errorBorder: _textFieldBorder)),
          ),
          GradientBubbleButton(
              icon: Icons.add,
              iconColor: const Color.fromRGBO(17, 153, 142, 1),
              onTap: widget.onAdd),
        ],
      ),
    );
  }

  OutlineInputBorder get _textFieldBorder => const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent));
}

/// Inner Shadow circle gradient button
class GradientBubbleButton extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Function() onTap;
  const GradientBubbleButton(
      {super.key,
      required this.icon,
      required this.iconColor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      radius: 22,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.fromBorderSide(
                BorderSide(color: context.groceryButtonBorderColor)),
            boxShadow: [
              BoxShadow(
                  color: context.groceryButtonShadowColor,
                  blurRadius: 1,
                  spreadRadius: 0),
              const BoxShadow(
                  color: Colors.white, blurRadius: 4, spreadRadius: -1),
            ]),
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 22.5, color: iconColor),
      ),
    );
  }
}
