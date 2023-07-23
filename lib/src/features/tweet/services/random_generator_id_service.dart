import 'package:uuid/uuid.dart';

class RandomGeneratorIdService {
  final Uuid generator;
  RandomGeneratorIdService({required this.generator});

  String idGeneration() {
    return generator.v4();
  }
}
