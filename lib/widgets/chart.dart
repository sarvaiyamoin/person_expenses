import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:person_expenses/widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recenetTransactions;
  Chart(this.recenetTransactions);

  List<Map<String, Object>> get grupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;
      for (var i = 0; i < recenetTransactions.length; i++) {
        if (recenetTransactions[i].date.day == weekDay.day &&
            recenetTransactions[i].date.month == weekDay.month &&
            recenetTransactions[i].date.year == weekDay.year) {
          totalSum += recenetTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    }).reversed.toList();
  }

  double get totalSpending {
    return grupedTransactionValues.fold(
        0.0, (sum, item) => sum + item['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          // children:
          children: grupedTransactionValues.map((data) {
            return Expanded(
              child: ChartBar(
                lable: data['day'],
                spendingAmount: data['amount'],
                spendingPctAmunt: totalSpending == 0.0
                    ? 0.0
                    : (data['amount'] as double) / totalSpending,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
