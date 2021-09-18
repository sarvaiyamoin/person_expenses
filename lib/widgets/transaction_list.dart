import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:person_expenses/models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transaction;
  final Function _deleteTx;
  TransactionList(this.transaction, this._deleteTx);

  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void initState() {
    print("initState()");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.transaction.isEmpty
        ? Align(
            alignment: Alignment.center,
            child: LayoutBuilder(builder: (ctx, constraint) {
              return Column(
                children: [
                  Text(
                    "Not data added!",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraint.maxHeight * 0.70,
                    child: Image.asset(
                      "assets/images/1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            }),
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                elevation: 6,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            "\$${widget.transaction[index].amount.toStringAsFixed(2)}"),
                      ),
                    ),
                  ),
                  title: Text(
                    widget.transaction[index].title,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMMd().format(widget.transaction[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 420
                      ? TextButton.icon(
                          onPressed: () =>
                              widget._deleteTx(widget.transaction[index].id),
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          label: Text(
                            "Delete",
                            style: TextStyle(color: Colors.red),
                          ),
                        )
                      : IconButton(
                          onPressed: () {
                            widget._deleteTx(widget.transaction[index].id);
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                ),
              );
            },
            itemCount: widget.transaction.length,
          );
  }
}
