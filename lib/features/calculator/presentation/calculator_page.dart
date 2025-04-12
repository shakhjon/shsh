import 'package:flutter/material.dart';
import 'package:shsh/features/calculator/data/calculator_repository_impl.dart';
import 'package:shsh/features/calculator/domain/add_usecase.dart';
import 'package:shsh/features/calculator/domain/ayrish_usecase.dart';
import 'package:shsh/features/calculator/domain/boluv_usecase.dart';
import 'package:shsh/features/calculator/domain/kopaytirish_usecase.dart';

class CalculatorPage extends StatefulWidget {
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController aController = TextEditingController();
  final TextEditingController bController = TextEditingController();
  String result = '';
  String errorMessage = ''; // Error xabari

  late final AddUseCase addUseCase;
  late final AyrishUsecase ayrishUseCase;
  late final KopaytirishUseCase kopaytirishUseCase;
  late final BoluvUseCase boluvUseCase;

  @override
  void initState() {
    super.initState();
    final repo = CalculatorRepositoryImpl();
    addUseCase = AddUseCase(repo);
    ayrishUseCase = AyrishUsecase(repo);
    kopaytirishUseCase = KopaytirishUseCase(repo);
    boluvUseCase = BoluvUseCase(repo);
  }

  void _calculate(String operation) {
    final a = double.tryParse(aController.text);
    final b = double.tryParse(bController.text);

    // Agar birinchi son kiritilmasa
    if (a == null) {
      setState(() {
        errorMessage = 'Iltimos, birinchi sonni kiriting!';
        result = '';
      });
      return;
    }

    // Agar ikkinchi son kiritilmasa
    if (b == null) {
      setState(() {
        errorMessage = 'Iltimos, ikkinchi sonni kiriting!';
        result = '';
      });
      return;
    }

    double res = 0;
    try {
      if (operation == 'add') {
        res = addUseCase(a, b); // Qo‘shish
      } else if (operation == 'ayrish') {
        res = ayrishUseCase(a, b); // Ayirish
      } else if (operation == 'kopaytirish') {
        res = kopaytirishUseCase(a, b); // Ko‘paytirish
      } else if (operation == 'boluv') {
        if (b == 0) {
          setState(() {
            errorMessage = 'Nolinchi son bilan bo‘lish mumkin emas!';
            result = '';
          });
          return;
        }
        res = boluvUseCase(a, b); // Bo‘lish
      }

      setState(() {
        result = 'Natija: ${res.toStringAsFixed(0)}'; // Natijani butun son sifatida ko‘rsatish
        errorMessage = ''; // Xatolikni tozalash
      });
    } catch (e) {
      setState(() {
        result = '';
        errorMessage = e.toString(); // Xatolikni chiqarish
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            TextField(
              controller: aController,
              decoration: InputDecoration(
                labelText: "Birinchi sonni kiriting",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            TextField(
              controller: bController,
              decoration: InputDecoration(
                labelText: "Ikkinchi sonni kiriting",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _calculate('add'),
                  child: Text("Qo‘shish"),
                ),
                ElevatedButton(
                  onPressed: () => _calculate('ayrish'),
                  child: Text("Ayirish"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _calculate('kopaytirish'),
                  child: Text("Ko‘paytirish"),
                ),
                ElevatedButton(
                  onPressed: () => _calculate('boluv'),
                  child: Text("Bo‘lish"),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Xatolik xabarini ko'rsatish
            if (errorMessage.isNotEmpty)
              Text(
                errorMessage,
                style: TextStyle(color: Colors.red, fontSize: 18),
              ),
            SizedBox(height: 20),
            // Natijani ko'rsatish
            if (result.isNotEmpty)
              Text(
                result,
                style: TextStyle(fontSize: 24),
              ),
          ],
        ),
      ),
    );
  }
}
