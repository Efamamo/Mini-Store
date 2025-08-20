import 'package:bot_toast/bot_toast.dart';

mixin LoadingDialog {
  void showLoading() {
    BotToast.showLoading(backButtonBehavior: BackButtonBehavior.ignore);
  }

  void closeLoading() {
    BotToast.closeAllLoading();
  }
}
