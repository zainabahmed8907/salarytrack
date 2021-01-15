import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  // const newTransactions({Key key}) : super(key: key);
  final Function addNewtransaction;
  NewTransactions(this.addNewtransaction);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleEditingController = TextEditingController();

  final amountEditingController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if(amountEditingController.text.isEmpty)
    {
      return;
    }
    final title = titleEditingController.text;
    final amount = double.parse(amountEditingController.text);
    if (title.isEmpty || amount <= 0||_selectedDate==null) {
      return;
    }

    widget.addNewtransaction(title, amount);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return null;
      }
      _selectedDate=pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: "Title"),
                controller: titleEditingController,
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "Amount"),
                controller: amountEditingController,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 5,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text(_selectedDate==null?'no date chhosen':'Picked Date:${DateFormat.yMd().format(_selectedDate)}')),
                    FlatButton(
                      textColor: Colors.purple,
                      child: Text(
                        'Choose a date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _showDatePicker,
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                child: Text('Add Transaction'),
                textColor: Colors.purple,
              )
            ])));
  }
}
