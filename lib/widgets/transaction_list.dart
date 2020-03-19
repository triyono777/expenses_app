import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function deleteTx;

  TransactionList({@required this.transaction, this.deleteTx});

  @override
  Widget build(BuildContext context) {
    print('build() TransaksiList');
    return transaction.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constrains) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Belum ada transaksi'),
                    Container(
                      height: constrains.maxHeight * 0.6,
                      child: Icon(
                        Icons.remove_shopping_cart,
                        size: 200,
                      ),
                    )
                  ],
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: transaction.length,
            itemBuilder: (contxt, index) {
              return Card(
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                          child: Text('\$${transaction[index].amount}')),
                    ),
                  ),
                  title: Text(
                    transaction[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(transaction[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? FlatButton.icon(
                          onPressed: () => deleteTx(transaction[index].id),
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTx(transaction[index].id),
                          color: ThemeData().errorColor,
                        ),
                ),
              );
            },
          );
  }
}
