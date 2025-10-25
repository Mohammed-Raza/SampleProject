import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_project/core/extensions/context_extension.dart';
import 'package:sample_project/features/presentation/bloc/dynamic_pdf/share_pdf_cubit.dart';

class CreateTableDialog extends StatefulWidget {
  const CreateTableDialog({super.key});

  @override
  State<CreateTableDialog> createState() => _CreateTableDialogState();
}

class _CreateTableDialogState extends State<CreateTableDialog> {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<SharePdfCubit>();
    return BlocBuilder<SharePdfCubit, SharePdfState>(
      builder: (context, state) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                const HeaderText(text: 'Columns'),
                GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  shrinkWrap: true,
                  controller: ScrollController(keepScrollOffset: false),
                  childAspectRatio: 4.0,
                  crossAxisSpacing: 5,
                  children: bloc.tableColumns
                      .map((e) => TableColumCellData(cellData: e))
                      .toList(),
                ),
                const HeaderText(text: 'Rows Count'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 37,
                        width: 37,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: InkResponse(
                          onTap: bloc.subtractRow,
                          child: const Icon(Icons.remove, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          '${bloc.rowsCount}',
                          textAlign: TextAlign.center,
                          style: context.headlineMedium,
                        ),
                      ),
                      Container(
                        height: 37,
                        width: 37,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: InkResponse(
                          onTap: bloc.addRow,
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  spacing: 20,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                          onPressed: context.pop,
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(context.width, 44),
                              backgroundColor: Colors.blueGrey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text('Back',
                              style: TextStyle(color: Colors.white))),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            context.pop();
                            bloc.setTable();
                          },
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(context.width, 44),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          child: const Text('Update',
                              style: TextStyle(color: Colors.white))),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class TableColumCellData extends StatefulWidget {
  final TableColumData cellData;
  const TableColumCellData({super.key, required this.cellData});

  @override
  State<TableColumCellData> createState() => _TableColumCellDataState();
}

class _TableColumCellDataState extends State<TableColumCellData> {
  @override
  Widget build(BuildContext context) {
    var bloc = context.read<SharePdfCubit>();
    return Row(
      spacing: 10,
      children: [
        Checkbox(
            value: widget.cellData.status,
            onChanged: (_) => bloc.onChangeOfCheckBox(widget.cellData)),
        Text(widget.cellData.name, style: context.bodyMedium),
      ],
    );
  }
}

class HeaderText extends StatelessWidget {
  final String text;
  const HeaderText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text('$text : ', style: context.titleLarge);
  }
}
