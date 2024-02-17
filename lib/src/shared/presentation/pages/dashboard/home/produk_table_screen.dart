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
  String uuid = const Uuid().v4();

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
    _nameProduct.clear();
    _priceProduct.clear();
    _quantityProduct.clear();
    _descriptionProduct.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white24,
        shadowColor: Colors.black,
        title: Text("Table Produk Akur", style: BlackText),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: StreamBuilder<ProductState>(
          stream: BlocProvider.of<ProductBloc>(context).stream,
          builder: (context, snapshot) {
            final state = snapshot.data;

            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProductsLoaded) {
              if (state.products.isEmpty) {
                return Center(child: Text("No Found Data Please Ad"));
              }
              return _buildDataTable(state.products, state);
            } else {
              return const Center(
                child: Text("Not Found"),
              );
            }
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'add_data',
            backgroundColor: redColor,
            onPressed: () async {
              await showDialog<void>(
                context: context,
                builder: (context) => AddDialog(
                  isUpdate: false,
                  uuid: uuid,
                  onAddProduct: (rowProduk, description) {
                    productBloc.add(AddProduct(
                        rowProduk: rowProduk, description: description));
                  },
                ),
              );
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
            heroTag: 'add_data_image',
            backgroundColor: redColor,
            onPressed: () async {
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
                final enhancedImage = await enhanceImage(image);

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
        if (state is ProductLoading)
          Center(
            child: CircularProgressIndicator(),
          )
        else if (state is ProductsLoaded)
          PaginatedDataTable(
            rowsPerPage: 6,
            columns: const [
              DataColumn(label: Text('Nama Produk')),
              DataColumn(label: Text('Harga')),
              DataColumn(label: Text('Total Produk')),
              DataColumn(label: Text('Deskripsi')),
              DataColumn(label: Text('Action')),
            ],
            source: DataSource(products, context, () {
              setState(() {
                _refresh();
              });
            }),
          )
        else
          const Center(
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
    return image;
  }
}
