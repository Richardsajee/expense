import 'package:expense/widgets/chart/chart.dart';
import 'package:expense/widgets/expenseslist.dart';
import 'package:expense/models/expense.dart';
import 'package:expense/widgets/newexpense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredexpenses = [
    Expense(
        title: 'flutter course',
        amount: 75,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'cinema',
        amount: 15,
        date: DateTime.now(),
        category: Category.leisure)
  ];

  void _openaddExpenseoverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Newexpense(onAddexpense: _addexpense));
  }

  void _addexpense(Expense expense) {
    setState(() {
      _registeredexpenses.add(expense);
    });
  }

  void _removeexpense(Expense expense) {
    final expenseindex = _registeredexpenses.indexOf(expense);
    setState(() {
      _registeredexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(seconds: 3),
      content: Text('expense deleted'),
      action: SnackBarAction(
          label: 'undo',
          onPressed: () {
            setState(() {
              _registeredexpenses.insert(expenseindex, expense);
            });
          }),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget maincontent = Center(
      child: Text('no expense found.start adding some'),
    );
    if (_registeredexpenses.isNotEmpty) {
      maincontent = Expenseslist(
        expenses: _registeredexpenses,
        onremoveexpense: _removeexpense,
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(onPressed: _openaddExpenseoverlay, icon: Icon(Icons.add))
        ],
      ),
      body: width < 600
          ? Column(
              children: [
                Chart(expenses: _registeredexpenses),
                Expanded(child: maincontent)
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredexpenses),) ,
                Expanded(child: maincontent)
              ],
            ),
    );
  }
}
