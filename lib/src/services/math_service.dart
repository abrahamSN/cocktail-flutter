import 'package:fixnum/fixnum.dart';

import './server.pbgrpc.dart';

import '../util/grpc_client.dart';

class MathService {
  static Future<Response> add(int a, int b) async {
    var client = AddServiceClient(
      GrpcClient.getClient(),
    ); // asking a connection to server

    Request req = Request.create();

    req.a = Int64(a); // convert int into the exact type data
    req.b = Int64(b);

    return await client.add(req);
  }
}
