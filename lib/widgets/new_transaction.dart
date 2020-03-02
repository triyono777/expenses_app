import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  NewTransaction({this.addTx});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title '),
              controller: titleController,
//                    onChanged: (nilai) {
//                      titleInput = nilai;
//                    },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount '),
              controller: amountController,
//                    onChanged: (nilai) => amountInput = nilai,
            ),
            FlatButton(
              textColor: Colors.purple,
              child: Text(
                'add Transaktion',
              ),
              onPressed: () {
                addTx(
                    titleController.text, double.parse(amountController.text));
//                print(titleController.text);
//                print(amountController.text);
//                      print(titleInput);
//                      print(amountInput);
              },
            )
          ],
        ),
      ),
    );
  }
}
