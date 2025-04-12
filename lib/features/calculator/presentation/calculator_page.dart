import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart'; // expressions kutubxonasini qo'shish

class CalculatorPage extends StatefulWidget {
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String input = ''; // Kirilgan ifoda
  String result = ''; // Natija
  String errorMessage = ''; // Xatolik xabari

  void _addToInput(String value) {
    setState(() {
      input += value; // Inputga qo‘shish
    });
  }

  // O‘chirish tugmasi: oxirgi belgini olib tashlash
  void _deleteLastInput() {
    setState(() {
      input = input.isNotEmpty ? input.substring(0, input.length - 1) : ''; // Kirilgan so‘nggi belgini o‘chirish
    });
  }

  // Natijani hisoblash
  void _evaluateExpression() {
    try {
      // Hisoblash uchun xatoliklarni tuzatish
      final exp = input.replaceAll('×', '*').replaceAll('÷', '/'); // '×' ni '*' va '÷' ni '/' ga almashtirish

      // expressions kutubxonasidan foydalanib, ifodani hisoblash
      final expression = Expression.parse(exp);
      final evaluator = ExpressionEvaluator();
      final resultValue = evaluator.eval(expression, {});


      // Natijani chiqarish
      setState(() {
        result = ' ${resultValue.toString()}';
        errorMessage = ''; // Xatolikni tozalash
      });
    } catch (e) {
      setState(() {
        result = '';
        errorMessage = 'Xatolik! Iltimos, ifodani tekshirib ko‘ring.'; // Xatolik xabari
      });
    }
  }

  // Tugmalarni yaratish
  Widget _buildCalcButton(String label) {
    return InkWell(
      onTap: () {
        activate();
        _addToInput(label); // Tugma bosilganda inputga qo‘shish
      },
      borderRadius: BorderRadius.circular(70),
      child: Container(
        width: 70,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(color: Colors.white24),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 55),
          ),
        ),
      ),
    );
  }

  // = (teng) tugmasini yaratish
  Widget _buildEqualButton() {
    return InkWell(
      onTap: _evaluateExpression,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text(
            '=',
            style: TextStyle(color: Colors.white, fontSize: 30),
          ),
        ),
      ),
    );
  }

  // Delete (o‘chirish) tugmasini yaratish
  Widget _buildDeleteButton() {
    return InkWell(
      onTap: _deleteLastInput, // O‘chirish tugmasi
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white10,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.backspace,
            color: Colors.green,
            size: 30,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              TextField(
                controller: TextEditingController(text: input),
                decoration: InputDecoration(
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 55),
                readOnly: true,
              ),
              SizedBox(height: 10),
              if (errorMessage.isNotEmpty)
                Text(
                  errorMessage,
                  style: TextStyle(color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              SizedBox(height: 10),
              if (result.isNotEmpty)
                Text(
                  result,
                  style: TextStyle(fontSize: 35,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
                ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalcButton('1'),
                  _buildCalcButton('2'),
                  _buildCalcButton('3'),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalcButton('4'),
                  _buildCalcButton('5'),
                  _buildCalcButton('6'),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalcButton('7'),
                  _buildCalcButton('8'),
                  _buildCalcButton('9'),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalcButton('0'),
                  _buildCalcButton('+'),
                  _buildCalcButton('-'),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCalcButton('×'), // Ko'paytirish
                  _buildCalcButton('÷'), // Bo'lish
                  _buildEqualButton(),
                ],
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildDeleteButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
