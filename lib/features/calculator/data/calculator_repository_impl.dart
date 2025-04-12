
import 'package:shsh/features/calculator/domain/calculator_repository.dart';

class CalculatorRepositoryImpl implements CalculatorRepository {
  @override
  double add(double a, double b) {
    return a + b; // Qo'shish
  }

  @override
  double ayrish(double a, double b) {
    return a - b; // Ayirish
  }

  @override
  double kopaytirish(double a, double b) {
    return a * b; // Ko'paytirish
  }

  @override
  double boluv(double a, double b) {
    return a / b; // Bo'lish
  }
}
