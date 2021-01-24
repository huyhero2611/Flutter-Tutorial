//controller.text  = "" then to submit

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Transaction.dart';
import 'TransactionList.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Transaction _transaction = new Transaction(content: "", amount: 0.0);
  List<Transaction> _transactions = List<Transaction>();

  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  // function will unmount
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }
void _insertTransaction() {
    if (_transaction.content.isEmpty || _transaction.amount == 0 || _transaction.amount.isNaN) {
      return;
    }
    _transactions.add(_transaction);
    _transaction = Transaction(content: "", amount: 0.0);
    _contentController.text = "";
    _amountController.text = "";
}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My App",
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Transaction maneger"
          ),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    this._insertTransaction();
                  });
                }
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: "Add transaction",
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              this._insertTransaction();
            });
          },
        ),
        key: _scaffoldKey,
        body: SafeArea(
            minimum: const EdgeInsets.only(left: 20, right: 20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "Content"),
                    controller: _contentController,
                    onChanged: ((text) {
                      this.setState(() {
                        _transaction.content = text;
                      });
                    }),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Amount"),
                    controller: _amountController,
                    onChanged: ((text) {
                      this.setState(() {
                        _transaction.amount = double.tryParse(text) ?? 0;
                      });
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  ButtonTheme(
                    height: 50,
                    child: FlatButton(
                      child: Text(
                        "Insert Transaction",
                        style: TextStyle(fontSize: 20),
                      ),
                      textColor: Colors.white,
                      color: Colors.pink,
                      onPressed: () {
                        setState(() {
                          this._insertTransaction();
                        });
                        _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                              content: Text(
                                  'Transactions list: ${_transactions.toString()}'),
                              duration: Duration(seconds: 1)),
                        );
                      },
                    ),
                  ),
                  Padding(padding: const EdgeInsets.symmetric(vertical: 10)),
                  TransactionList(
                    transactions: _transactions,
                  )
                ],
              ),
            )
        ),
      ),
    );
  }
}
