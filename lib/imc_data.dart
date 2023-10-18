// No arquivo imc_data.dart
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class IMCData {
  @HiveField(0)
  double peso;

  @HiveField(1)
  double altura;

  @HiveField(2)
  double imc;

  IMCData(this.peso, this.altura, this.imc);
}

