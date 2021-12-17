part of providers;

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  List<TransactionModel> get getTransaction => _transactions;
  setTransactionList(List<TransactionModel> list) {
    _transactions.addAll(list);
    notifyListeners();
  }

  clear() {
    _transactions.clear();
  }
}
