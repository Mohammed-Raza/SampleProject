import 'package:flutter/material.dart';
import 'package:sample_project/core/mixins/validators_mixin.dart';
import 'package:sample_project/features/data/models/category_model.dart';
import 'package:sample_project/core/database/db_helper.dart';
import 'package:sample_project/features/domain/entities/drop_down_entity.dart';
import '../../widgets/drop_down_widget.dart'; // Adjust path

class SqfLiteMain extends StatefulWidget {
  const SqfLiteMain({super.key});

  @override
  State<SqfLiteMain> createState() => _SqfLiteMainState();
}

class _SqfLiteMainState extends State<SqfLiteMain> with ValidatorsMixin {
  final _formKey = GlobalKey<FormState>();

  String? _selectedType;

  bool autoValidate = false;

  List<DropDownEntity> categories = [
    DropDownEntity("11", "Vegetables"),
    DropDownEntity("22", "Fruits"),
    DropDownEntity("33", "Milk Products"),
    DropDownEntity("44", "Cookies")
  ];

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  Future<void> _saveToDatabase() async {
    if (!_formKey.currentState!.validate()) {
      autoValidate = true;
      setState(() {});
      return;
    }
    autoValidate = false;

    if (_selectedType != null) {
      final dbHelper = DBHelper();

      await dbHelper.insertCategory(CategoryModel(
          id: int.parse(_selectedType!),
          name: _nameController.text.trim(),
          description: _descController.text.trim()));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Category Saved Locally!')),
        );
        // Clear fields
        _nameController.clear();
        _descController.clear();
      }
    } else if (_selectedType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a category type')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Category")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          autovalidateMode: autoValidate
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          child: ListView(
            children: [
              // Your custom widget from drop_down_widget.dart
              CustomizedDropDown(
                  id: _selectedType,
                  items: categories,
                  callback: (id) {
                    _selectedType = id;
                    setState(() {});
                  },
                  label: 'Category',
                  validator: (id) => dropdownEmptyValidator(id, 'category')),
              const SizedBox(height: 20),

              TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Grocery Name",
                    border: OutlineInputBorder(),
                  ),
                  validator: (val) =>
                      valueEmptyValidator(val!, context, 'grocery name')),
              const SizedBox(height: 20),

              TextFormField(
                  controller: _descController,
                  maxLines: 3,
                  decoration: const InputDecoration(labelText: "Description"),
                  validator: (val) =>
                      valueEmptyValidator(val!, context, 'description')),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _saveToDatabase,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.teal,
                ),
                child:
                    const Text("SUBMIT", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
