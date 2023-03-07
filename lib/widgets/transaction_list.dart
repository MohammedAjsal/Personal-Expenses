import 'package:first_app/model/transaction.dart';
import 'package:first_app/widgets/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  // const TransactionList({Key key}) : super(key: key);

  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    "No transaction added yet",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView(
            children: transactions
                .map(
                  (tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      transaction: tx,
                      deleteTransaction: deleteTransaction),
                )
                .toList(),
          );
  }
}


















 // return Card(
                //   child: Row(
                //     children: [
                //       Container(
                //         margin:
                //             EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                //         decoration: BoxDecoration(
                //           border: Border.all(
                //               width: 5,
                //               color: Theme.of(context).primaryColor,
                //               style: BorderStyle.solid),
                //         ),
                //         padding: EdgeInsets.all(10),
                //         child: Text(
                //           "\$${transactions[index].amount.toStringAsFixed(2)}",
                //           style: TextStyle(
                //               color: Theme.of(context).primaryColor,
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transactions[index].title,
                //             style: TextStyle(
                //                 fontSize: 16, fontWeight: FontWeight.bold),
                //           ),
                //           Text(
                //             DateFormat.yMd()
                //                 .add_jm()
                //                 .format(transactions[index].date),
                //             // tx.date.toString(),
                //             style: TextStyle(color: Colors.grey),
                //           ),
                //         ],
                //       )
                //     ],
                //   ),
                // );