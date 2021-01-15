import 'package:flutter/material.dart';
import 'package:salarytrack/widgets/newTransactions.dart';
import 'package:salarytrack/widgets/transaction_list.dart';

import 'package:salarytrack/models/transaction.dart';
import 'package:salarytrack/widgets/Chart.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.purple,
          fontFamily: 'Langar',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  // ignore: deprecated_member_use
                  title: TextStyle(
                      fontFamily: 'Langar', fontWeight: FontWeight.bold))),
          textTheme: ThemeData.light().textTheme.copyWith(
              // ignore: deprecated_member_use
              title: TextStyle(
                  fontFamily: 'Langar', fontWeight: FontWeight.bold))),
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Transactions> _userTransaction = [
    Transactions(
        id: '1', title: 'New shoes', amount: 34.23, date: DateTime.now()),
    Transactions(id: '2', title: 'Fee', amount: 340.21, date: DateTime.now()),
    Transactions(
        id: '3', title: 'Transport', amount: 10.1, date: DateTime.now())
  ];

  void _addnewTransaction(
      String txtitle, double txmount, DateTime choosenDate) {
    final newTx = Transactions(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txmount,
        date: choosenDate);

    setState(() {
      _userTransaction.add(newTx);
    });
  }

  void _deleteTransactions(String id) {
    _userTransaction.removeWhere((tx) =>  tx.id==id);
  }

  List<Transactions> get _recentTrasactions {
    return _userTransaction.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  //fucntion for showing the mdoal bottom sheet to add new trasaction
  void startTheBottomSheet(BuildContext ctxt) {
    showModalBottomSheet(
        context: ctxt,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransactions(_addnewTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: deprecated_member_use
        title: Text(
          'Salary Tracker',
          style: Theme.of(context).textTheme.title,
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => startTheBottomSheet(context))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Chart(_recentTrasactions),
          TransactionList(_userTransaction, _deleteTransactions)
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () => startTheBottomSheet(context),
          child: Icon(Icons.add)),
    );
  }
}
