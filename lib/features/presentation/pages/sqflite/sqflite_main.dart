import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/core/mixins/validators_mixin.dart';
import 'package:sample_project/features/presentation/bloc/local_db/local_db_cubit.dart';
import 'package:sample_project/features/presentation/pages/sqflite/create_db.dart';
import 'package:sample_project/features/presentation/pages/sqflite/update_db.dart';
import '../../../../core/database/db_helper.dart';
import '../../../../core/mixins/common_mixin.dart';
import '../../../data/models/category_model.dart';
import '../../widgets/common_widgets.dart';
import '../../widgets/page_error.dart';

class SqfLiteMain extends StatefulWidget {
  const SqfLiteMain({super.key});

  @override
  State<SqfLiteMain> createState() => _SqfLiteMainState();
}

class _SqfLiteMainState extends State<SqfLiteMain> with ValidatorsMixin {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => loadLocalDbData());
    super.initState();
  }

  loadLocalDbData() => context.read<LocalDbCubit>().fetchLocallyStoredDbData();

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LocalDbCubit>();
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.getLocalDbData)),
      floatingActionButton: FloatingActionButton(
          onPressed: _openDialog, child: const Icon(Icons.add)),
      body: BlocBuilder<LocalDbCubit, LocalDbState>(
          bloc: cubit,
          builder: (context, state) {
            switch (state.runtimeType) {
              case const (LocalDataLoading):
                return const CircularIndicator();
              case const (LocalDataSuccess):
                var successState = state as LocalDataSuccess;
                if (successState.itemsMapData == null) {
                  return Center(
                      child: Text(context.l10n.noLocalDataAvailableToShow));
                }
                final categories = successState.itemsMapData!.keys.toList();

                return ListView.builder(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    String categoryName = categories[index];
                    List<CategoryModel> items =
                        successState.itemsMapData![categoryName] ?? [];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Header
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: Text(
                            categoryName.toUpperCase(),
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal),
                          ),
                        ),
                        // List of items in this category
                        ...items.map((item) => GroceryItemCard(item: item))
                      ],
                    );
                  },
                );
              case const (LocalDataError):
                var errorState = state as LocalDataError;
                return PageErrorWidget(
                    errorText: errorState.errorDetails.$1,
                    errorImage: errorState.errorDetails.$2);
              default:
                return Container();
            }
          }),
    );
  }

  void _openDialog() {
    showDialog(
        context: context,
        builder: (context) => Dialog(
              insetPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: Container(
                  width: double.infinity,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(10),
                  child: const CreateDbAndAddData()),
            ));
  }
}

class GroceryItemCard extends StatelessWidget {
  final CategoryModel item;

  const GroceryItemCard({super.key, required this.item});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.only(right: 2.0),
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          title: Row(
            children: [
              Expanded(
                child: Text(item.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit_note_outlined,
                        color: Colors.blue, size: 24),
                    onPressed: () => _showEditDialog(context, item),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: () => _showDeleteDialog(context, item),
                  ),
                ],
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(4),
              Text(
                item.description,
                maxLines: 2, // Show exactly 2 lines
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey[700], fontSize: 13),
              ),
              GestureDetector(
                onTap: () => CommonMixin.showFullDescription(
                    context, item.name, item.description),
                child: Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    context.l10n.readMore,
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, CategoryModel item) {
    showDialog(
      context: context,
      builder: (dialogContext) => UpdateDbData(
          id: item.id ?? 0, name: item.name, description: item.description),
    );
  }

  void _showDeleteDialog(BuildContext context, CategoryModel item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.deleteItemQuestion),
        content: Text(context.l10n.deleteItemConfirmation(item.name)),
        actions: [
          TextButton(
              onPressed: () => context.pop(), child: Text(context.l10n.cancel)),
          TextButton(
              onPressed: () async {
                final dbHelper = DBHelper();
                await dbHelper.deleteGroceryItem(item.id!);
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content:
                        Text(context.l10n.itemDeletedSuccessfully(item.name)),
                    backgroundColor: Colors.red));
                context.read<LocalDbCubit>().fetchLocallyStoredDbData();
                context.pop();
              },
              child: Text(context.l10n.delete,
                  style: const TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}
