import 'dart:convert';
import 'dart:io';

class Apps {
  static Future<String> find({required String app}) async {
    ProcessResult _appPath = await Process.run(
      '/usr/bin/which',
      [app],
    );

    return _appPath.stdout.toString();
  }

  static Future<Stream> run({required List<String> args}) async {
    Process _cmd = await Process.start(
      args[0],
      args.sublist(1),
    );

    return _cmd.stdout.transform(utf8.decoder);
  }

  static ProcessResult runSync({required List<String> args}) {
    return Process.runSync(
      args[0],
      args.sublist(1),
    );
  }
}
