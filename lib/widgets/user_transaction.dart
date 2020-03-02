import '../models/transaction.dart';
import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';

class UserTranscation extends StatefulWidget {
  @override
  _UserTranscationState createState() => _UserTranscationState();
}

class _UserTranscationState extends State<UserTranscation> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't3',
      title: 'Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Roti',
      amount: 29.99,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(
          addTx: _addNewTransaction,
        ),
        TransactionList(
          transaction: _userTransaction,
        ),
      ],
    );
  }
}
