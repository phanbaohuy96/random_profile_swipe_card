import 'package:dio/dio.dart';
import 'package:random_profile_swipe_card/utils/utils.dart';

class AppApiService {
  final dio = Dio();
  ApiServiceHandler handlerEror;

  void create() {
    
    dio.options.headers["X-Client-Id"] = "7E65424BD1DFF4CE17B77D74E4B96EB87137F6E1"; // config your dio headers globally
    dio.options.headers["Content-Type"] = "application/json";

    dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
      printLog("[AppApiService][${DateTime.now().toString().split(' ').last}]-> DioSTART\tonRequest \t${options.method} [${options.path}] ${options.contentType}");
      return options; //continue
    }, onResponse: (Response response) {
      printLog("[AppApiService][${DateTime.now().toString().split(' ').last}]-> DioEND\tonResponse \t${response.statusCode} [${response.request.path}] ${response.request.method}  ${response.request.responseType}");
      return response; // continue
    }, onError: (DioError error) async {
      printLog("[AppApiService][${DateTime.now().toString().split(' ').last}]-> DioEND\tonError \turl:[${error.request.baseUrl}] type:${error.type} message: ${error.message}");
      handlError(error);
    }));
  }

  dynamic handlError(DioError error) {
    if(handlerEror == null) {
      return null;
    }

    var result = ErrorData(
      type: ErrorType.UNKNOWN, 
      message: error.message
    );
    
    switch (error.type) {
      case DioErrorType.RECEIVE_TIMEOUT:
      case DioErrorType.SEND_TIMEOUT:
      case DioErrorType.CONNECT_TIMEOUT:
      result.type = ErrorType.TIMED_OUT;
        break;
      case DioErrorType.RESPONSE: {
        printLog("[AppApiService] _handleError DioErrorType.RESPONSE status code: ${error.response.statusCode}");
        result.statusCode = error.response.statusCode;
        
        if (result.statusCode == 401) {
          result.type = ErrorType.UNAUTHORIZED;
        } if (result.statusCode == 403) {
          //TODO: refresh token
        } else if (result.statusCode >= 500 && result.statusCode < 600) {
          result.type = ErrorType.HTTP_EXCEPTION;
        }
        else {
          result.type = ErrorType.HTTP_EXCEPTION;
          // result.message = getErrorMessage(error.response.data);
        }
        break;
      }
      case DioErrorType.CANCEL:
        break;
      case DioErrorType.DEFAULT:
        // TODO: Url not Server die or No Internet connection
        printLog("[AppApiService] _handleError DioErrorType.DEFAULT status code: error.response is null -> Server die or No Internet connection");
        result.type = ErrorType.NO_INTERNET;  
        
        if(error.message.contains('Unexpected character')) {
          result.type = ErrorType.SERVER_Unexpected_character;  
        }
        break;
    }

    return handlerEror.onError(result); //continue
  }

  String getErrorMessage(Map<String, dynamic> dataRes) {
    if (dataRes.containsKey("message") && dataRes["message"] != null) {
      return dataRes["message"]?.toString();
    }
    if (dataRes.containsKey("error") && dataRes["error"] != null) {
      return dataRes["error"]?.toString();
    }
    return dataRes.toString();
  }
}

enum ErrorType{
  NO_INTERNET,
  HTTP_EXCEPTION,
  TIMED_OUT,
  UNAUTHORIZED,
  UNKNOWN,
  SERVER_Unexpected_character
}

class ErrorData{ 
  ErrorType type;
  String message;
  int statusCode;

  ErrorData({this.type, this.statusCode, this.message});
}

abstract class ApiServiceHandler {
  onError(ErrorData onError);
}