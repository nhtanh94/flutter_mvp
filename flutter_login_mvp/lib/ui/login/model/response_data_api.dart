class ApiResponseData {
  int errorCode;
  String message;
  Map<String, dynamic> data;
  ApiResponseData({this.errorCode,this.message,this.data});
  factory ApiResponseData.fromJson(Map<String, dynamic> json) {
    return ApiResponseData(
        errorCode: json['errorCode'],
        message: json['message'],
        data:json['data']
    );
  }
}