import 'package:flutter/material.dart';
import 'package:todo_list_provider/app/core/notifier/default_change_notifer.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:todo_list_provider/app/core/ui/message.dart';

class DefaultListenerNotifier {
  final DefaultChangeNotifer changeNotifer;

  DefaultListenerNotifier({
    required this.changeNotifer,
  });

  void listener({
    required BuildContext context,
    required SuccessVoidCallBack successVoidCallBack,
    ErrorVoidCallBack? errorVoidCallBack,
    AlwaysVoidCallBack? alwaysVoidCallBack,
  }) {
    changeNotifer.addListener(() {
      if (alwaysVoidCallBack != null) {
        alwaysVoidCallBack(changeNotifer, this);
      }
      if (changeNotifer.loading) {
        Loader.show(context);
      } else {
        Loader.hide();
      }
      if (changeNotifer.hasError) {
        if (errorVoidCallBack != null) {
          errorVoidCallBack(changeNotifer, this);
        }
        Messages.of(context).showError(changeNotifer.error ?? 'Erro intenro');
      } else if (changeNotifer.isSuccess) {
        successVoidCallBack(changeNotifer, this);
      }
    });
  }

  void dispose() {
    changeNotifer.removeListener(() {});
  }
}

typedef SuccessVoidCallBack = void Function(
  DefaultChangeNotifer notifer,
  DefaultListenerNotifier listenerInstance,
);
typedef ErrorVoidCallBack = void Function(
  DefaultChangeNotifer notifer,
  DefaultListenerNotifier listenerInstance,
);
typedef AlwaysVoidCallBack = void Function(
  DefaultChangeNotifer notifer,
  DefaultListenerNotifier listenerInstance,
);
