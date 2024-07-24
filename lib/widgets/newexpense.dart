import 'dart:io';

import 'package:expense/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();

class Newexpense extends StatefulWidget {
  const Newexpense({super.key, required this.onAddexpense});

  final void Function(Expense expense) onAddexpense;

  @override
  State<Newexpense> createState() => _NewexpenseState();
}

class _NewexpenseState extends State<Newexpense> {
  final _titalcontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedcategory = Category.leisure;

  void _presentdatepicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExensedata() {
    final eneteredamount = double.tryParse(_amountcontroller.text);
    final amountisinvalid = eneteredamount == null || eneteredamount <= 0;
    if (_titalcontroller.text.trim().isEmpty ||
        amountisinvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Invalid input'),
                content: Text('Please make sure a valid title,mount,date'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: Text('Okay'))
                ],
              ));
      return;
    }
    widget.onAddexpense(Expense(
        title: _titalcontroller.text,
        amount: eneteredamount,
        date: _selectedDate!,
        category: _selectedcategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titalcontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardspace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctc, Constraints) {
      final width = Constraints.maxWidth;
      // print(Constraints.maxWidth);
      // print(Constraints.minHeight);
      // print(Constraints.maxHeight);

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardspace + 16),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titalcontroller,
                          maxLength: 50,
                          decoration: InputDecoration(label: Text('Title')),
                        ),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountcontroller,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              prefixText: '\$ ', label: Text('Amount')),
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titalcontroller,
                    maxLength: 50,
                    decoration: InputDecoration(label: Text('Title')),
                  ),
                if(width>=600)
                  Row(children: [
                    DropdownButton(
                        value: _selectedcategory,
                        items: Category.values
                            .map((Category) => DropdownMenuItem(
                                value: Category,
                                child: Text(Category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedcategory = value;
                          });
                        }),
                        SizedBox(width: 24,),
                        Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? 'No date Selected'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                            onPressed: _presentdatepicker,
                            icon: Icon(Icons.calendar_month))
                      ],
                    ))

                  ],)
                  else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _amountcontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            prefixText: '\$ ', label: Text('Amount')),
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(_selectedDate == null
                            ? 'No date Selected'
                            : formatter.format(_selectedDate!)),
                        IconButton(
                            onPressed: _presentdatepicker,
                            icon: Icon(Icons.calendar_month))
                      ],
                    ))
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                if(width>=600)
                Row(children: [
                  Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel')),
                    ElevatedButton(
                        onPressed: _submitExensedata,
                        child: Text('save expense'))
                ],)

                else
                Row(
                  children: [
                    DropdownButton(
                        value: _selectedcategory,
                        items: Category.values
                            .map((Category) => DropdownMenuItem(
                                value: Category,
                                child: Text(Category.name.toUpperCase())))
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedcategory = value;
                          });
                        }),
                    Spacer(),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('cancel')),
                    ElevatedButton(
                        onPressed: _submitExensedata,
                        child: Text('save expense'))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
