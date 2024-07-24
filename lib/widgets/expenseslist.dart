import 'package:expense/models/expense.dart';
import 'package:expense/widgets/expenseitem.dart';
import 'package:flutter/material.dart';

class Expenseslist extends StatelessWidget {
  const Expenseslist(
      {super.key, required this.expenses, required this.onremoveexpense});
  final List<Expense> expenses;
  final void Function(Expense expense) onremoveexpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
            key: ValueKey(expenses[index]),
            background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(.75),
                margin: EdgeInsets.symmetric(
                    horizontal:
                        Theme.of(context).cardTheme.margin!.horizontal)),
            onDismissed: (direction) {
              onremoveexpense(expenses[index]);
            },
            child: Expenseitem(expenses[index])
            )
            );
  }
}
