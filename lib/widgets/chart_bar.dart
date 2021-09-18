import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String lable;
  final double spendingAmount;
  final double spendingPctAmunt;

  const ChartBar({this.lable, this.spendingAmount, this.spendingPctAmunt});
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
              height: constraints.maxHeight * 0.15,
              child: FittedBox(
                  child: Text("\$${spendingAmount.toStringAsFixed(0)}"))),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.60,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPctAmunt,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(lable),
            ),
          ),
        ],
      );
    });
  }
}
