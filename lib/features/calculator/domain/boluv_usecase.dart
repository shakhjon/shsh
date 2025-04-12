import 'calculator_repository.dart';

class BoluvUseCase {
  final CalculatorRepository repository;

  BoluvUseCase(this.repository);

  double call(double a, double b) {
    if (b == 0) {
      throw ArgumentError('Nolinchi son bilan bo‘lish mumkin emas!'); // Xato holat: bo'lish uchun 0 kiritilsa
    }
    return repository.boluv(a, b); // Repositoryda bo‘lish amali
  }
}
