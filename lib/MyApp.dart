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
    if (_transaction.content.isEmpty ||
        _transaction.amount == 0 ||
        _transaction.amount.isNaN) {
      return;
    }
    _transaction.createdDate = DateTime.now();
    _transactions.add(_transaction);
    _transaction = Transaction(content: "", amount: 0.0);
    _contentController.text = "";
    _amountController.text = "";
  }

  void _buttonShowModalSheet() {
    showModalBottomSheet(
        context: this.context,
        builder: (context) {
          return Container(
            // height: 250,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                            child: Text(
                              "Save",
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              print("press save");
                            },
                            color: Colors.green,
                          )),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      Expanded(
                          child: RaisedButton(
                            child: Text("Cancel",
                                style: TextStyle(color: Colors.white, fontSize: 18)),
                            onPressed: () {
                              print("Press cancel");
                            },
                            color: Colors.red,
                          ))
                    ],
                  ),
                  padding: EdgeInsets.all(20),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction maneger"),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  this._insertTransaction();
                });
              })
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
                      this._buttonShowModalSheet();
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
          )),
    );
  }
}
