

import 'package:flutter/foundation.dart';


/// A global ValueNotifier to hold the auth token
ValueNotifier<String?> globalToken = ValueNotifier<String?>(null);
ValueNotifier<String?> userId = ValueNotifier<String?>(null);