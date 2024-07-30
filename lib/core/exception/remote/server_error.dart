import 'server_error_detail.dart';

class ServerError {
  final int? generalServerStatusCode;
  final String? generalServerErrorId;
  final String? generalMessage;
  final List<ServerErrorDetail> errors;

  const ServerError({
    this.generalServerStatusCode,
    this.generalServerErrorId,
    this.generalMessage,
    this.errors = const <ServerErrorDetail>[],
  });

  ServerError copyWith({
    int? generalServerStatusCode,
    String? generalServerErrorId,
    String? generalMessage,
    List<ServerErrorDetail>? errors,
  }) {
    return ServerError(
      generalServerStatusCode:
          generalServerStatusCode ?? this.generalServerStatusCode,
      generalServerErrorId: generalServerErrorId ?? this.generalServerErrorId,
      generalMessage: generalMessage ?? this.generalMessage,
      errors: errors ?? this.errors,
    );
  }

  @override
  String toString() => 'ServerError('
      'generalServerStatusCode: $generalServerStatusCode, '
      'generalServerErrorId: $generalServerErrorId, '
      'generalMessage: $generalMessage, '
      'errors: ${errors.toString()}, '
      ')';

  @override
  bool operator ==(Object other) =>
      other is ServerError &&
      other.runtimeType == runtimeType &&
      other.generalServerStatusCode == generalServerStatusCode &&
      other.generalServerErrorId == generalServerErrorId &&
      other.generalServerErrorId == generalServerErrorId &&
      other.errors == errors;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        generalServerStatusCode,
        generalServerErrorId,
        generalMessage,
        errors,
      );
}
