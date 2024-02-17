part of '../pages.dart';

class AddDialog extends StatefulWidget {
  String uuid;
  final Function(RowProduk, String) onAddProduct;
  final bool isUpdate;
  RowProduk? initialProduct;

  AddDialog(
      {required this.uuid,
      required this.onAddProduct,
      required this.isUpdate,
      this.initialProduct});

  @override
  State<AddDialog> createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  final TextEditingController _nameProduct = TextEditingController();

  final TextEditingController _priceProduct = TextEditingController();

  final TextEditingController _quantityProduct = TextEditingController();

  final TextEditingController _descriptionProduct = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      // // Set initial values if it's an update
      // _nameProduct.text = initialProduct.
      // _priceProduct.text = initialProduct!.price.toString();
      // _quantityProduct.text = initialProduct!.quantity.toString();
      // _descriptionProduct.text = initialProduct!.description;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
                        hintStyle:
                            GreyText.copyWith(fontWeight: FontWeight.w200),
                      ),
                      controller: _nameProduct,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Rp.",
                        hintStyle:
                            GreyText.copyWith(fontWeight: FontWeight.w200),
                      ),
                      controller: _priceProduct,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some price';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: "Total Produk",
                        hintStyle:
                            GreyText.copyWith(fontWeight: FontWeight.w200),
                      ),
                      controller: _quantityProduct,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some qty';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Deskripsi",
                        hintStyle:
                            GreyText.copyWith(fontWeight: FontWeight.w200),
                      ),
                      controller: _descriptionProduct,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some description';
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: const Text('Submit'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onAddProduct(
                            RowProduk(
                              widget.uuid,
                              _nameProduct.value.text,
                              double.parse(_priceProduct.value.text),
                              int.parse(_quantityProduct.value.text),
                              _descriptionProduct.value.text,
                            ),
                            '',
                          );

                          _nameProduct.clear();
                          _priceProduct.clear();
                          _quantityProduct.clear();
                          _descriptionProduct.clear();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Product added successfully!'),
                            ),
                          );
                          FocusScope.of(context).unfocus();
                          Timer(Duration(seconds: 5), () {
                            Navigator.of(context).pop(); // Close the dialog
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
    );
  }
}
