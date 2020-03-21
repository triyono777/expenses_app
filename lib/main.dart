import 'dart:io';

import 'package:expenses_app/widgets/charts.dart';
import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';

import './widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'models/transaction.dart';

void main() {
//  SystemChrome.setPreferredOrientations([
//    DeviceOrientation.portraitUp,
//    DeviceOrientation.portraitDown,
//  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
          fontFamily: 'Quicksand',
//          errorColor: Colors.blue,
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    title: TextStyle(
                        fontFamily: 'OpenSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
//  String titleInput;
//  String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [];

  bool _showChart = false;
  List<Transaction> get _recentTransaction {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void startAddnewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: NewTransaction(
              addTx: _addNewTransaction,
            ),
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    print('build() MyHomePagestate');
    final mediaquery = MediaQuery.of(context);
    final isLandskape = mediaquery.orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => startAddnewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Expenses App',
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => startAddnewTransaction(context),
              ),
            ],
          );

    final txListWidget = Container(
      height: (mediaquery.size.height -
              appBar.preferredSize.height -
              mediaquery.padding.top) *
          0.7,
      child: TransactionList(
        transaction: _userTransaction,
        deleteTx: _deleteTransaction,
      ),
    );
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (isLandskape) ...buildLandscap(mediaquery, appBar, txListWidget),
            if (!isLandskape) ...buildPotrait(mediaquery, appBar, txListWidget),
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? buildCupertinoPageScaffold(pageBody, appBar)
        : buildScaffold(context, appBar, pageBody);
  }

  Scaffold buildScaffold(
      BuildContext context, PreferredSizeWidget appBar, SafeArea pageBody) {
    print('Build scaffold');
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              onPressed: () => startAddnewTransaction(context),
              child: Icon(Icons.add),
            ),
      appBar: appBar,
      body: pageBody,
    );
  }

  CupertinoPageScaffold buildCupertinoPageScaffold(
      SafeArea pageBody, PreferredSizeWidget appBar) {
    return CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appBar,
    );
  }

  List<Widget> buildPotrait(MediaQueryData mediaquery,
      PreferredSizeWidget appBar, Widget txListWidget) {
    return [
      Container(
          height: (mediaquery.size.height -
                  appBar.preferredSize.height -
                  mediaquery.padding.top) *
              0.3,
          child: Chart(_recentTransaction)),
      txListWidget
    ];
  }

  List<Widget> buildLandscap(MediaQueryData mediaquery,
      PreferredSizeWidget appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.title,
          ),
          Switch.adaptive(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              height: (mediaquery.size.height -
                      appBar.preferredSize.height -
                      mediaquery.padding.top) *
                  0.7,
              child: Chart(_recentTransaction))
          : txListWidget
    ];
  }
}
