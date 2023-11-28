class ApiResponse {
  final bool Status;
  final dynamic data;
  final String? token;
  final String? error;
  final String? msg;

  ApiResponse(
      {required this.Status, this.data, this.token, this.error, this.msg});

  factory ApiResponse.fromJSON(Map<String, dynamic> json) {
    return ApiResponse(
        Status: json['status'],
        data: json['data'],
        token: json['token'],
        error: json['error'],
        msg: json['msg']);
  }
}
