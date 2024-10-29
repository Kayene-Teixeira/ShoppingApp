import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop/models/product.dart';

class ProductFormView extends StatefulWidget {
  const ProductFormView({super.key});

  @override
  State<ProductFormView> createState() => _ProductFormViewState();
}

class _ProductFormViewState extends State<ProductFormView> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();
    _imageUrlFocus.dispose();
    _imageUrlFocus.removeListener(updateImage);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  void updateImage() {
    setState(() {});
  }

  // validando url
  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;

    return isValidUrl;

    // validando pra que seja obrigatorio ter estensao
    // bool endsWithFile = url.toLowerCase().endsWith('.png');
  }

  void submitForm() {
    final isValid = _formKey.currentState!.validate() ?? false;

    if (!isValid) {
      return;
    }
    _formKey.currentState!.save();

    final newProduct = Product(
      id: Random().nextDouble().toString(),
      name: _formData['name'] as String,
      description: _formData['description'] as String,
      price: _formData['price'] as double,
      imageUrl: _formData['imageUrl'] as String,
    );

    print(newProduct.id);
    print(newProduct.name);
    print(newProduct.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Formulário de Produtos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: submitForm,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocus);
                }, // mostra texto para ir para o próximo elemento
                onSaved: (name) => _formData['name'] = name ?? '',
                validator: (_name) {
                  //sempre que retornar algo diferente de null, ele mostra mensagem de erro
                  final name = _name ?? '';
                  if (name.trim().isEmpty) {
                    return 'O nome é obrigatório!';
                  }
                  if (name.length < 3) {
                    return 'O nome precisa ter pelo menos 3 letras!';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Preço'),
                textInputAction: TextInputAction
                    .next, // mostra texto para ir para o próximo elemento
                focusNode: _priceFocus,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_descriptionFocus);
                },
                onSaved: (price) =>
                    _formData['price'] = double.parse(price ?? '0'),
                validator: (_price) {
                  final priceString = _price ?? '';
                  final price = double.tryParse(priceString) ?? -1;

                  if (price <= 0) {
                    return 'Informe um preço válido!';
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descrição'),
                focusNode: _descriptionFocus,
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                onSaved: (description) =>
                    _formData['description'] = description ?? '',
                validator: (_description) {
                  final description = _description ?? '';
                  if (description.trim().isEmpty) {
                    return 'A descrição é obrigatória!';
                  }
                  if (description.length < 10) {
                    return 'A descrição precisa ter pelo menos 10 letras!';
                  }
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Url da Imagem'),
                      focusNode: _imageUrlFocus,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageUrlController,
                      onFieldSubmitted: (_) => submitForm(),
                      onSaved: (imageUrl) =>
                          _formData['imageUrl'] = imageUrl ?? '',
                      validator: (_imageUrl) {
                        final imageUrl = _imageUrl ?? '';
                        if (!isValidImageUrl(imageUrl)) {
                          return 'Informe uma url válida!';
                        }
                      },
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 10, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: _imageUrlController.text.isEmpty
                        ? const Text("Informe a Url")
                        : FittedBox(
                            fit: BoxFit.cover,
                            child: Image.network(
                              _imageUrlController.text,
                              width: 100,
                              height: 100,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
