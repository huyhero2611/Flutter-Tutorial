class Transaction {
  String content;
  double amount;
  Transaction({this.content, this.amount});
  @override
  String toString() {
    // TODO: implement toString
    return 'content: $content, amount: $amount';
  }
}
