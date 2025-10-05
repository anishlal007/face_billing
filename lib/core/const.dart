

import 'package:flutter/foundation.dart';

class loadData{
  static const dynamic userCode="1001";
}

/// A global ValueNotifier to hold the auth token
ValueNotifier<String?> globalToken = ValueNotifier<String?>(null);