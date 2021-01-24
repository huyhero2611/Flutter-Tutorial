import 'package:flutter/material.dart';
import 'package:flutter_app/Transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({this.transactions});

  ListView _buildListView() {
    return ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Card(
            color: (index + 1) % 2 == 0
                ? Colors.greenAccent
                : Colors.lightGreenAccent,
            elevation: 10, // hiệu ứng đổ bóng 10px
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
                leading: const Icon(Icons.access_alarm),
                title: Text(
                  transactions[index].content,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Price: ${transactions[index].amount}',
                  style: TextStyle(fontSize: 16),
                ),
                onTap: () {
                  print("You clicked: ${transactions[index].content}");
                } // leading: const icon(Icon.access_alarm),
                ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 400,
      child: _buildListView(),
    );
  }
}
