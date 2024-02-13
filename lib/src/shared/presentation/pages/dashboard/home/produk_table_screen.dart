part of '../../../pages.dart';

class ProdukDataTableScreen extends StatefulWidget {
  const ProdukDataTableScreen({super.key});

  @override
  State<ProdukDataTableScreen> createState() => _ProdukDataTableScreenState();
}

class _ProdukDataTableScreenState extends State<ProdukDataTableScreen> {
  final ImagePicker picker = ImagePicker();
  late String s = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        shadowColor: Colors.black,
        title: Text("Hasil Profit", style: BlackText),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          PaginatedDataTable(
            rowsPerPage: 8,
            columns: const [
              DataColumn(label: Text('Header A')),
              DataColumn(label: Text('Header B')),
              DataColumn(label: Text('Header C')),
              DataColumn(label: Text('Header D')),
            ],
            source: _DataSource(context),
          ),
          Text(
            s,
            style: TextStyle(color: Colors.black, fontSize: 20),
          )
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: redColor,
            onPressed: () {},
            child: const Icon(
              Icons.add,
              color: whiteColor,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
              backgroundColor: redColor,
              onPressed: () async {
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);
                String a = await getImageTotext(image!.path);
                setState(() {
                  s = a;
                });
              },
              child: const Icon(
                Icons.camera_enhance,
                color: whiteColor,
              ))
        ],
      ),
    );
  }

  Future getImageTotext(final imagePath) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(InputImage.fromFilePath(imagePath));
    String text = recognizedText.text.toString();
    return text;
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this.context)
      : _rows = <RowProduk>[
          RowProduk('Cell A1', 'CellB1', 'CellC1', 1),
          RowProduk('Cell A2', 'CellB2', 'CellC2', 2),
          RowProduk('Cell A3', 'CellB3', 'CellC3', 3),
          RowProduk('Cell A4', 'CellB4', 'CellC4', 4),
          RowProduk('Cell A4', 'CellB4', 'CellC4', 4),
          RowProduk('Cell A4', 'CellB4', 'CellC4', 4),
          RowProduk('Cell A5', 'CellB4', 'CellC4', 4),
          RowProduk('Cell A6', 'CellB4', 'CellC4', 4),
          RowProduk('Cell A7', 'CellB4', 'CellC4', 4),
          RowProduk('Cell A8', 'CellB4', 'CellC4', 4),
        ];

  final BuildContext context;
  final List<RowProduk> _rows;

  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _rows.length) return null;
    final row = _rows[index];
    return DataRow.byIndex(
      index: index,
      selected: row.selected,
      onSelectChanged: (value) {
        if (row.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          row.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(row.valueA)),
        DataCell(Text(row.valueB)),
        DataCell(Text(row.valueC)),
        DataCell(Text(row.valueD.toString())),
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
