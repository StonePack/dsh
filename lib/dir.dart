import 'dart:io';

import 'package:dsh/app.dart';

class SysDir {
  SysDir._private();
  static final SysDir instance = SysDir._private();

  final List<String> _active = <String>['Users', 'stone'];

  Future<String> change({required String path}) async {
    List<String> dirs = path.split('/');

    if (path[0] == '/') {
      _active.clear();
    }

    for (var d in dirs) {
      if (d == '..') {
        _active.removeLast();
      } else if (await Directory('${getActive()}/$d').exists()) {
        _active.add(d);
      } else {
        return '${getActive()}/$d is not a valid directory';
      }
    }

    return '';
  }

  ProcessResult list(String? path) {
    return Apps.runSync(args: ['ls', path ?? getActive()]);
  }

  String getActive() {
    return '/${_active.join('/')}';
  }
}
