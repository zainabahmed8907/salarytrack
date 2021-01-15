import 'package:flutter/material.dart';
import 'package:salarytrack/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transactions> transactions;
  final Function deleteTransactions;
  TransactionList(this.transactions,this.deleteTransactions);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 300,
          child: transactions.isEmpty
              ? Column(
                  children: <Widget>[
                    Text("No transaction added yet :)"),
                    SizedBox(
                      height: 20.0,
                    ),
                    Image.asset('../../assets/images/wait.gif',
                        fit: BoxFit.cover)
                  ],
                )
              : ListView.builder(
                  itemBuilder: (ctx, index) {
                    return Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text('\$${transactions[index].amount}')),
                        ),
                        title: Text(transactions[index].title),
                        subtitle: Text(DateFormat.yMMMd()
                            .format(transactions[index].date)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red[900],
                          onPressed:()=>deleteTransactions(transactions[index].id),
                        ),
                      ),
                    );
                  },
                  itemCount: transactions.length,
                )),
    );
  }
}
