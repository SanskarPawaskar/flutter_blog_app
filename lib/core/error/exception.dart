import 'dart:convert';

class ServerExceptoion implements Exception {
  final String excetionMessage;
  ServerExceptoion(this.excetionMessage);
  ServerExceptoion copyWith({
    String? excetionMessage,
  }) {
    return ServerExceptoion(
      excetionMessage ?? this.excetionMessage,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'excetionMessage': excetionMessage,
    };
  }
  factory ServerExceptoion.fromMap(Map<String, dynamic> map) {
    return ServerExceptoion(
      map['excetionMessage'],
    );
  }
  String toJson() => json.encode(toMap());
  factory ServerExceptoion.fromJson(String source) => ServerExceptoion.fromMap(json.decode(source));
  @override
  String toString() => 'ServerExceptoion(excetionMessage: $excetionMessage)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ServerExceptoion &&
      other.excetionMessage == excetionMessage;
  }
  @override
  int get hashCode => excetionMessage.hashCode;
}
