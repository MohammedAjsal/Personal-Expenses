// file class for textfield
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;
  NewTransaction(this.addTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  // const NewTransaction({Key key}) : super(key: key);
  final _titleController = TextEditingController();

  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectedDate == null) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 5, color: Colors.purple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  labelText: "Title",
                ),

                controller: _titleController,
                onSubmitted: (_) => submitData(),
                // onChanged: (value) {
                //   amountInput = value;
                // },
              ),
              SizedBox(height: 5),
              TextField(
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 5,
                      color: Colors.purple,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2),
                  ),
                  labelText: "Amount",
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),

                // onChanged: (value) {
                //   titileInput = value;
                // },
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? "No date choosen"
                            : 'Picked Date : ${DateFormat.yMMMEd().format(_selectedDate)}',
                      ),
                    ),
                    TextButton(
                      onPressed: presentDatePicker,
                      child: Text(
                        "Choose date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: TextButton.styleFrom(
                          foregroundColor: Theme.of(context).primaryColor),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  submitData();
                },
                child: Text("Add Transaction"),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
