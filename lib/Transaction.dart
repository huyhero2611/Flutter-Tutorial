class Transaction {
  String content;
  double amount;
  DateTime createdDate;
  Transaction({this.content, this.amount, this.createdDate});
  @override
  String toString() {
    // TODO: implement toString
    return 'content: $content, amount: $amount';
  }
}
