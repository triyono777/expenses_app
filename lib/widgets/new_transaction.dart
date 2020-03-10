import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction({this.addTx});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

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
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount '),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Row(
              children: <Widget>[
                Text('No Date Choosen'),
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(
                    'Choose Date',
                  ),
                  onPressed: () {},
                )
              ],
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              child: Text(
                'add Transaction',
              ),
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
