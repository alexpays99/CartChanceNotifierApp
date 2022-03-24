import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_app/models/card_model.dart';
import 'package:flutter_change_notifier_app/models/item_model.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart' as pw;
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<CardModel>(context);
    var textTheme = Theme.of(context).textTheme.headline6;

    Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
      final path = (await getExternalStorageDirectory())!.path;
      final file = File('$path/$fileName');
      await file.writeAsBytes(bytes, flush: true);
      OpenFile.open('$path/$fileName');
    }

    Future<void> createPDF(List<Item> items) async {
      pw.PdfDocument document = pw.PdfDocument();

      pw.PdfGrid grid = pw.PdfGrid();
      grid.style = pw.PdfGridStyle(
          font: pw.PdfStandardFont(pw.PdfFontFamily.helvetica, 30),
          cellPadding: pw.PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

      grid.columns.add(count: 3);
      grid.headers.add(1);

      pw.PdfGridRow header = grid.headers[0];

      pw.PdfGridRow headersRow = grid.headers.add(1)[0];
      header.cells[0].value = 'Name';
      header.cells[1].value = 'Amount';
      header.cells[2].value = 'Price';

      items.where((item) => items.isNotEmpty).forEach((element) {
        final row = grid.rows.add();
        row.cells[0].value = element.title.toString();
        //row.cells[1].value = element.price.toString();
        row.cells[2].value = element.price.toString();

        for (int i = 0; i < headersRow.cells.count; i++) {
          headersRow.cells[i].style.cellPadding =
              pw.PdfPaddings(bottom: 5, left: 5, right: 5, top: 5);
        }
      });

      grid.draw(
          page: document.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

      pw.PdfPage page = document.pages[0];

      final totalPrice =
          Provider.of<CardModel>(context, listen: false).totalPrice;

      page.graphics.drawString(
        'Total price: \$${totalPrice.toString()}',
        pw.PdfStandardFont(pw.PdfFontFamily.helvetica, 30),
        bounds: const Rect.fromLTWH(10, 300, 500, 40),
      );

      List<int> bytes = document.save();
      document.dispose();

      saveAndLaunchFile(bytes, 'Receipt.pdf');
    }

    return Center(
      child: Column(
        children: [
          Container(
            color: Colors.yellow,
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: cartItem.cardItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 8.0),
                    child: Row(
                      children: [
                        Text(cartItem.cardItems[index].title, style: textTheme),
                        Expanded(child: Container()),
                        Text('\$${cartItem.cardItems[index].price}',
                            style: textTheme),
                        Expanded(child: Container()),
                        IconButton(
                            onPressed: () {
                              Provider.of<CardModel>(context, listen: false)
                                  .removeItem(cartItem.cardItems[index]);
                                  
                              Provider.of<CardModel>(context, listen: false)
                                  .counter--;
                            },
                            icon: const Icon(Icons.remove)),
                      ],
                    ),
                  );
                }),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                //color: Colors.yellow,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Total price: \$${cartItem.totalPrice}",
                    style: textTheme,
                  ),
                ),
              )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text('Buy'),
                    onPressed: () {},
                  )),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                //color: Colors.yellow,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Receipt: ",
                    style: textTheme,
                  ),
                ),
              )),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Icon(Icons.receipt),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: () async {
                      createPDF(cartItem.cardItems);
                    },
                  )),
            ],
          )
        ],
      ),
    );
  }
}
