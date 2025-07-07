import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionCheckker {
  Future<bool> isConnected();
}

class ConnectionCheckkerImpl implements ConnectionCheckker{
  final InternetConnection internetConnection;

  ConnectionCheckkerImpl({required this.internetConnection});
  @override
  Future<bool> isConnected() async{
    return await internetConnection.hasInternetAccess;
  
  }
  
}