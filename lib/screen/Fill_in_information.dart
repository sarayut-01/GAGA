import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ggh/screen/SummarySelectionPage.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  final _formKey = GlobalKey<FormState>();
  String _transactionType = 'income';
  double _amount = 0.0;
  String _note = '';

  Future<void> _saveTransaction() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('transactions')
            .add({
          'type': _transactionType,
          'amount': _amount,
          'note': _note,
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Transaction added successfully!')),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SummarySelectionPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No user is logged in!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         
          Positioned.fill(
            child: Image.asset(
              'assets/image/aom4.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: _transactionType,
                        items: const [
                          DropdownMenuItem(value: 'income', child: Text('Income')),
                          DropdownMenuItem(value: 'expense', child: Text('Expense')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _transactionType = value!;
                          });
                        },
                        decoration: InputDecoration(
                          labelText: 'Transaction Type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.attach_money, color: Colors.green),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _amount = double.tryParse(value!) ?? 0.0;
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Note',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.blue, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.blueAccent, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: const Icon(Icons.note, color: Colors.orange),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a note';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _note = value!;
                        },
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.deepPurple,
                          ),
                          onPressed: _saveTransaction,
                          child: const Text('Save Transaction', style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
           Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context); // Go back action
              },
            ),
          ),
        ],
      ),
    );
  }
}
