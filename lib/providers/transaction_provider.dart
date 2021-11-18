import 'package:coffee_shop/models/transaction.dart';
import 'package:flutter/cupertino.dart';

class TransactionProvider with ChangeNotifier {
  List<TransactionModel> _transactions = [];
  List<TransactionModel> get getTransaction => _transactions;
  setTransactionList(List<TransactionModel> list) {
    _transactions.addAll(list);
    notifyListeners();
  }

  clear() {
    _transactions.clear();
    // notifyListeners();
  }
}
