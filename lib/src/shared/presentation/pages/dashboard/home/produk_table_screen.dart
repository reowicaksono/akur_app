part of '../../../pages.dart';

class ProdukDataTableScreen extends StatefulWidget {
  const ProdukDataTableScreen({super.key});

  @override
  State<ProdukDataTableScreen> createState() => _ProdukDataTableScreenState();
}

class _ProdukDataTableScreenState extends State<ProdukDataTableScreen> {
  final ImagePicker picker = ImagePicker();
  late String s = "";
  final _formKey = GlobalKey<FormState>();
  late ProductBloc productBloc = ProductBloc();

  final TextEditingController _nameProduct = TextEditingController();
  final TextEditingController _priceProduct = TextEditingController();
  final TextEditingController _quantityProduct = TextEditingController();
  final TextEditingController _descriptionProduct = TextEditingController();

  @override
  void initState() {
    super.initState();
    productBloc = BlocProvider.of<ProductBloc>(context);
    productBloc.add(GetAllProducts());
  }

  Future<void> _refresh() async {
    productBloc.add(GetAllProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        shadowColor: Colors.black,
        title: Text("Table Produk Akur", style: BlackText),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          print("object : $state");
          if (state is ProductLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ProductsLoaded) {
            return _buildDataTable(state.products, state);
          } else {
            return Center(
              child: Text("Not Found"),
            );
          }
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: redColor,
            onPressed: () async {
              await showDialog<void>(
                  context: context,
                  builder: (context) => AlertDialog(
                        content: Stack(
                          clipBehavior: Clip.none,
                          children: <Widget>[
                            Positioned(
                              right: -40,
                              top: -40,
                              child: InkResponse(
                                onTap: () {
                                  Navigator.of(context).pop();
                                },
                                child: const CircleAvatar(
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                            SingleChildScrollView(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: "Nama Produk",
                                              hintStyle: GreyText.copyWith(
                                                  fontWeight: FontWeight.w200)),
                                          controller: _nameProduct,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: "Rp.",
                                              hintStyle: GreyText.copyWith(
                                                  fontWeight: FontWeight.w200)),
                                          controller: _priceProduct,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some price';
                                            }
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: "Total Produk",
                                              hintStyle: GreyText.copyWith(
                                                  fontWeight: FontWeight.w200)),
                                          controller: _quantityProduct,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some qty';
                                            }
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextFormField(
                                          decoration: InputDecoration(
                                              hintText: "Deskripsi",
                                              hintStyle: GreyText.copyWith(
                                                  fontWeight: FontWeight.w200)),
                                          controller: _descriptionProduct,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Please enter some description';
                                            }
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: ElevatedButton(
                                        child: const Text('Submit'),
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            productBloc.add(AddProduct(
                                              rowProduk: RowProduk(
                                                _nameProduct.value.text,
                                                double.parse(
                                                    _priceProduct.value.text),
                                                int.parse(_quantityProduct
                                                    .value.text),
                                                _descriptionProduct.value.text,
                                              ),
                                              description: '',
                                            ));

                                            _nameProduct.clear();
                                            _priceProduct.clear();
                                            _quantityProduct.clear();
                                            _descriptionProduct.clear();

                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Product added successfully!'),
                                              ),
                                            );
                                            FocusScope.of(context).unfocus();
                                            Timer(Duration(seconds: 5), () {
                                              Navigation.navigateBack();
                                            });
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
            },
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
              // User chooses between gallery and camera
              final XFile? image = await showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Text("Select Image Source"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(
                              context,
                              await picker.pickImage(
                                  source: ImageSource.gallery));
                        },
                        child: Text("Pick from Gallery"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.pop(
                              context,
                              await picker.pickImage(
                                  source: ImageSource.camera));
                        },
                        child: Text("Use Camera"),
                      ),
                    ],
                  ),
                ),
              );

              if (image != null) {
                // Apply image enhancement/scanning (you may replace this with your image processing logic)
                final enhancedImage = await enhanceImage(image);

                // Process the enhanced image to text
                String result = await getImageTotext(enhancedImage!.path);

                setState(() {
                  s = result;
                });
              }
            },
            child: const Icon(
              Icons.camera_enhance,
              color: whiteColor,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildDataTable(List<RowProduk> products, ProductState state) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (state is ProductLoading) // Show loading indicator
          Center(
            child: CircularProgressIndicator(),
          )
        else if (state
            is ProductsLoaded) // Show data table when products are loaded
          PaginatedDataTable(
            rowsPerPage: 8,
            columns: const [
              DataColumn(label: Text('Header A')),
              DataColumn(label: Text('Header B')),
              DataColumn(label: Text('Header C')),
              DataColumn(label: Text('Header D')),
            ],
            source: _DataSource(products),
          )
        else // Show an error message if something went wrong
          Center(
            child: Text("Not Found"),
          ),
        Text(
          s,
          style: const TextStyle(color: Colors.black, fontSize: 20),
        ),
      ],
    );
  }

  Future getImageTotext(final imagePath) async {
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(InputImage.fromFilePath(imagePath));
    String text = recognizedText.text.toString();
    return text;
  }

  Future<XFile?> enhanceImage(XFile image) async {
    // Implement image enhancement logic here
    // You may use image processing libraries or apply your custom logic
    // For simplicity, return the original image for now
    return image;
  }
}

class _DataSource extends DataTableSource {
  _DataSource(this._rows);

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
        DataCell(Text(row.name)),
        DataCell(Text(row.price.toString())),
        DataCell(Text(row.quantity.toString())),
        DataCell(Text(row.description)),
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
