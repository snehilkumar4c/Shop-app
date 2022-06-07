import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-products';
  // const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageurlcontroller = TextEditingController();
  final _imageurlfocusnode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    _imageurlfocusnode.addListener(_updateimageurl);
    super.initState();
  }

  void _updateimageurl() {
    if (!_imageurlfocusnode.hasFocus) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageurlfocusnode.removeListener(_updateimageurl);
    _imageurlcontroller.dispose();
    _imageurlfocusnode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Products'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                // textInputAction: TextInputAction.next,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 8,
                      right: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageurlcontroller.text.isEmpty
                        ? Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(
                              _imageurlcontroller.text,
                            ),
                            fit: BoxFit.fill,
                            // to fit ib the box
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      // the image should be in JPG format
                      decoration: InputDecoration(labelText: 'Image URL'),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.done,
                      controller: _imageurlcontroller,
                      focusNode: _imageurlfocusnode,
                      onEditingComplete: () {
                        setState(() {});
                      },
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
// we can use FOCUS to basically move from one Input Field to another next Input 
// we can write:
// final _pricefocusnode = FocusNode(); above the build()
// then in each TextFormField we can pass that.
// under the pricing form field:
// focusNode: _pricefocusnode;
// and under the title form field: 
// onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_pricefocusnode);
// here we are not using this as this version supports the automatic
// movement of cursor or to be specific focus to different fiels.