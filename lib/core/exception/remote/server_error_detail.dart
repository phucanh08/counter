class ServerErrorDetail {
  final String detail;
  final String path;
  final String serverErrorId;
  final int serverStatusCode;
  final String message;
  final String field;

  const ServerErrorDetail({
    required this.detail,
    required this.path,
    required this.serverErrorId,
    required this.serverStatusCode,
    required this.message,
    required this.field,
  });

  ServerErrorDetail copyWith({
    String? detail,
    String? path,
    String? serverErrorId,
    int? serverStatusCode,
    String? message,
    String? field,
  }) {
    return ServerErrorDetail(
      detail: detail ?? this.detail,
      path: path ?? this.path,
      serverErrorId: serverErrorId ?? this.serverErrorId,
      serverStatusCode: serverStatusCode ?? this.serverStatusCode,
      message: message ?? this.message,
      field: field ?? this.field,
    );
  }

  @override
  String toString() => 'ServerErrorDetail('
      'detail: $detail, '
      'path: $path, '
      'serverErrorId: $serverErrorId, '
      'serverStatusCode: $serverStatusCode, '
      'message: $message, '
      'field: $field, '
      ')';

  @override
  bool operator ==(Object other) =>
      other is ServerErrorDetail &&
      other.runtimeType == runtimeType &&
      other.detail == detail &&
      other.path == path &&
      other.serverErrorId == serverErrorId &&
      other.serverStatusCode == serverStatusCode &&
      other.message == message &&
      other.field == field;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        detail,
        path,
        serverErrorId,
        serverStatusCode,
        message,
        field,
      );
}
