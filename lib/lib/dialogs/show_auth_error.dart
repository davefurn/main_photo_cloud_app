import 'package:flutter/material.dart' show BuildContext;
import 'package:main_photo_cloud_app/lib/dialogs/generic_dialog.dart';

import '../../auth/auth_error.dart';

Future<void> showAuthError({
  required AuthError authError,
  required BuildContext context,
}) {
  return showGenericDialog<void>(
    context: context,
    title: authError.dialogTitle,
    content: authError.dialogText,
    optionsBuilder: () => {
      'OK': true,
    },
  );
}
