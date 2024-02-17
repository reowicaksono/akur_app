part of '../pages.dart';

class DataSource extends DataTableSource {
  final ProductBloc productBloc = ProductBloc();
  DataSource(this._rows, this.context, this.onRefresh, {Key? key});
  final BuildContext context;
  final List<RowProduk> _rows;
  final Function() onRefresh;

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {},
      cells: [
        DataCell(Text(row.name)),
        DataCell(Text(row.price.toString())),
        DataCell(Text(row.quantity.toString())),
        DataCell(Text(row.description)),
        DataCell(
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  await showDialog<void>(
                    context: context,
                    builder: (context) => AddDialog(
                      isUpdate: true,
                      uuid: 'uuid',
                      initialProduct: row,
                      onAddProduct: (rowProduk, description) {
                        productBloc.add(UpdateProduct(
                            rowProduk: rowProduk, description: description));
                      },
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(
                            "Apakah anda yakin ingin menghapus nya?"),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigation.navigateBack();
                              },
                              child: Text("Batal"),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              onPressed: () {
                                productBloc.add(DeleteProduct(uuid: row.id));
                                onRefresh();
                              },
                              child: Text("Oke"),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  int get rowCount => _rows.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
