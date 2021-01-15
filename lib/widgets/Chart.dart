import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salarytrack/models/transaction.dart';
import 'package:salarytrack/widgets/chartbar.dart';

class Chart extends StatelessWidget {
  //const Chart({Key key}) : super(key: key);

  final List<Transactions> transactions;
  Chart(this.transactions);

  List<Map<String, Object>> get groupedChartTransactions {
    return List.generate(7, (index) {
      final weekday = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekday.day &&
            transactions[i].date.month == weekday.month &&
            transactions[i].date.year == weekday.year) {
          totalsum += transactions[i].amount;
        }
      }
      print(DateFormat.E().format(weekday));
      return {'day': DateFormat.E(weekday), 'amount': totalsum};
    }).reversed.toList();
  }

  double get zeeSpendings {
    return groupedChartTransactions.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedChartTransactions.map((data) {
          return Flexible(
          fit: FlexFit.tight,
          child: Chartbar(data['day'], data['amount'],
            zeeSpendings==0.0?0.0:(data['amount'] as double) /zeeSpendings),
          );
        }).toList()),
      ),
    );
  }
}
