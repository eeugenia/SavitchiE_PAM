import 'package:flutter/material.dart';
import 'dart:math';
void main() => runApp(LoanCalculatorApp());
class LoanCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loan Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoanCalculatorPage(),
    );
  }
}
class LoanCalculatorPage extends StatefulWidget {
  @override
  _LoanCalculatorPageState createState() => _LoanCalculatorPageState();
}
class _LoanCalculatorPageState extends State<LoanCalculatorPage> {
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController interestRateController = TextEditingController();
  final TextEditingController termController = TextEditingController();
  String selectedTermUnit = 'Years'; // Default value for term unit
  String monthlyPayment = '';
  void calculateLoanPayment() {
    double loanAmount = double.parse(loanAmountController.text);
    double interestRate = double.parse(interestRateController.text) / 100 / 12;
    int loanTerm = int.parse(termController.text);
// Convert the term to months if the selected term unit is in years
    if (selectedTermUnit == 'Years') {
      loanTerm *= 12; // Convert years to months
    }
// Formula to calculate monthly loan payment
    double payment = (loanAmount * interestRate * pow(1 + interestRate, loanTerm)) /
        (pow(1 + interestRate, loanTerm) - 1);
    setState(() {
      monthlyPayment = payment.toStringAsFixed(2);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade600],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Loan Calculator',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              buildInputField(
                controller: loanAmountController,
                label: 'Loan Amount',
                icon: Icons.attach_money,
              ),
              SizedBox(height: 15),
              buildInputField(
                controller: interestRateController,
                label: 'Interest Rate (%)',
                icon: Icons.percent,
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: buildInputField(
                      controller: termController,
                      label: 'Loan Term',
                      icon: Icons.calendar_today,
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedTermUnit,
                    items: <String>['Years', 'Months'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(color: Colors.white)),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedTermUnit = newValue!;
                      });
                    },
                    dropdownColor: Colors.teal,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: calculateLoanPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal.shade800,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Calculate',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              buildResultBox(),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        prefixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      style: TextStyle(color: Colors.white),
      keyboardType: TextInputType.number,
    );
  }
  Widget buildResultBox() {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Monthly Payment',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            '\$$monthlyPayment',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
