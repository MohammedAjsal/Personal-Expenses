import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:first_app/model/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTransaction;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.yellow,
      Colors.blue,
      Colors.green
    ];
    _bgColor = availableColors[Random().nextInt(4)];

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FittedBox(
              child: Text(
                '\$${widget.transaction.amount}',
                style: TextStyle(),
              ),
            ),
          ),
        ),
        title: Text(
          widget.transaction.title,
          style: TextStyle(
              // color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
                icon: Icon(
                  Icons.delete,
                ),
                style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).errorColor),
                label: Text("Delete"),
              )
            : IconButton(
                onPressed: () {
                  widget.deleteTransaction(widget.transaction.id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                ),
              ),
      ),
    );
  }
}
