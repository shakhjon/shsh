import 'calculator_repository.dart';

class AyrishUsecase {
  final CalculatorRepository repository;

  AyrishUsecase(this.repository);

  double call(double a, double b) {
    return repository.ayrish(a, b); // Repositoryda ayirish amali
  }
}
