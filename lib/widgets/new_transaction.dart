import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function newTx;

  NewTransaction(this.newTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.newTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Color(0xFF737373),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40))),
              padding: EdgeInsets.only(
                top: 10,
                right: 10,
                left: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    autofocus: true,
                    //For iOS
                    // keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(labelText: 'Title'),
                    // onChanged: (val) => titleInput = val,
                    onSubmitted: (_) => _submitData(),
                    controller: _titleController,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => _submitData(),
                    // onChanged: (val) => amountInput = val,
                  ),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(_selectedDate == null
                            ? "No date Choosen!"
                            : "Picked date : ${DateFormat.yMd().format(_selectedDate)}"),
                      ),
                      // _selectedDate == null
                      //     ? Text("No date Choosen!")
                      //     : Text(
                      //         "Picked date : ${DateFormat.yMd().format(_selectedDate)}"),
                      TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          "Choose Date",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _submitData,
                    child: Text(
                      "Add Transaction",
                      style: TextStyle(
                        color: Colors.white,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
