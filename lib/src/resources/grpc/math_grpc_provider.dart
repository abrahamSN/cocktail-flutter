import '../../services/math_service.dart';

class MathGrpcProvider {
  Future add(int i) async {
    final res = await MathService.add(i, 3);
    return res;
  }
}
