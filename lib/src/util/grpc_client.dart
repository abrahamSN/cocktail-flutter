import 'package:grpc/grpc.dart';

class GrpcClient {
  static ClientChannel client;

  static ClientChannel getClient() {
    if (client == null) {
      // make connection into grpc server
      client = ClientChannel(
        '192.168.100.11', // change into grpc server
        port: 4040,
        options: ChannelOptions(
          credentials: ChannelCredentials.insecure(),
          idleTimeout: Duration(minutes: 1),
        ),
      );
    }

    return client;
  }
}
