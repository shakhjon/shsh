
import 'calculator_repository.dart';

class AddUseCase {
  final CalculatorRepository repository;

  AddUseCase(this.repository);

  double call(double a, double b) {
    return repository.add(a, b); // Repositoryda qo'shish amali
  }
}
