import 'package:flutter/material.dart';
import 'package:random_profile_swipe_card/base/bloc_base.dart';
import 'package:random_profile_swipe_card/networking/app_api_service.dart';
import 'package:random_profile_swipe_card/utils/config_utils.dart';
import 'package:random_profile_swipe_card/utils/extension.dart';
import 'package:random_profile_swipe_card/utils/utils.dart';

abstract class StateBase<T extends StatefulWidget> extends State<T> implements ApiServiceHandler{

  BlocBase getBloc();

  StateBase() {
    printLog("[ScreenBase->${T.toString()}] contructor");
  }

  @override
  void initState() {
    super.initState();
    
    printLog("[ScreenBase->${T.toString()}] initState");
    getBloc()?.appApiService?.handlerEror = this;
  }

  @override
  onError(ErrorData error) {
    switch (error.type) {
      case ErrorType.UNAUTHORIZED:
        showLoginRequired();
        break;
      case ErrorType.HTTP_EXCEPTION:
        if (error.statusCode >= 500 && error.statusCode < 600) {
          showErrorDialog("Oops! There seems to be a technical issue. Please check your connectivity or try again later.");
          break;
        } 
        // else if(error.statusCode == 404){
        //   showErrorDialog("404");
        //   // break;
        // }
        showErrorDialog(error.message);
        break;
      case ErrorType.TIMED_OUT: {
        showErrorDialog("Connection timmed out.");
        break;
      }
      case ErrorType.NO_INTERNET: {
        showNoInternetDialog();
        break;
      }
      case ErrorType.UNKNOWN: {
        showErrorDialog("Unknown error!");
        break;
      }
      case ErrorType.SERVER_Unexpected_character:{
        showErrorDialog("Server maintenance \n Unexpected character");
        break;
      }
      default:
      break;
    }

    return null;
  }

  void showLoading() {
    printLog("[ScreenBase->${T.toString()}][showLoading]");
  }

  void hideLoading() {
    printLog("[ScreenBase->${T.toString()}][hideLoading]");

  }

  void showLoginRequired() {
    printLog("[ScreenBase->${T.toString()}][showLoginRequired] ");
    
    showDialog(context: context, barrierDismissible: false, builder: (context) {
      return errorNotiedErrorPopup(
        width: Dimension.getWidth(0.9),
        height: Dimension.getWidth(0.9),
        content: "Please login to continue!",
        onTap: () {
          Navigator.pop(context);
        }
      );
    });
  }

  void showNoInternetDialog() {
    showDialog(context: context, barrierDismissible: false, builder: (context) {
      return errorInternet(
        width: Dimension.getWidth(0.9),
        height: Dimension.getWidth(0.9),
        onTap: () {
          Navigator.pop(context);
        }
      );
    });
  }

  void showErrorDialog(String message) {
    printLog("[ScreenBase->${T.toString()}][showErrorDialog] $message");
    showDialog(context: context, barrierDismissible: false, builder: (context) {
      return errorNotiedErrorPopup(
        width: Dimension.getWidth(0.9),
        height: Dimension.getWidth(0.9),
        content: message,
        onTap: () {
          Navigator.pop(context);
        }
      );
    });
  }
}