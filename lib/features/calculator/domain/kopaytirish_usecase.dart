import 'package:shsh/features/calculator/domain/calculator_repository.dart';

class KopaytirishUseCase {
  final CalculatorRepository repository;

  KopaytirishUseCase(this.repository);

  double call(double a, double b) {
    return repository.kopaytirish(a, b); // Repositoryda ko'paytirish amali
  }
}
