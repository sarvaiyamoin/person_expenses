import 'dart:ui';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:person_expenses/widgets/chart.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './models/transaction.dart';

void main() {
  // WidgetsFlutterBinding().ensureFrameCallbacksRegistered();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MaterialApp(
    title: "Person Expenses",
    theme: ThemeData(
      primarySwatch: Colors.green,
      accentColor: Colors.amber,
      fontFamily: 'NotoSansJP',
      textTheme: ThemeData.light().textTheme.copyWith(
          headline1: TextStyle(
              fontFamily: 'Quicksand',
              fontSize: 18,
              fontWeight: FontWeight.bold)),
    ),
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showChart = false;
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: '101',
    //   title: 'New Shoes',
    //   amount: 70.67,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '102',
    //   title: 'Weekly Groceries',
    //   amount: 34.47,
    //   date: DateTime.now(),
    // ),
  ];
  List<Transaction> get _recentTransaction {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime selectedDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: selectedDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.retainWhere((element) => element.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandScap = mediaQuery.orientation == Orientation.landscape;
    print(mediaQuery.size.height.toStringAsFixed(2));
    print(mediaQuery.size.width.toStringAsFixed(2));
    final appBar = AppBar(
      title: Text("Person Expenses"),
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );
    final allList = Container(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.70,
        child: TransactionList(_userTransactions, _deleteTransaction));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_isLandScap)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch.adaptive(
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (_isLandScap)
              _showChart
                  ? Container(
                      height: (mediaQuery.size.height -
                              appBar.preferredSize.height -
                              mediaQuery.padding.top) *
                          0.65,
                      child: Chart(_recentTransaction))
                  : allList,
            if (!_isLandScap)
              Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.30,
                  child: Chart(_recentTransaction)),
            if (!_isLandScap) allList,
          ],
        ),
      ),
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
