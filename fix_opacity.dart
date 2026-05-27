import 'dart:io';

void main() {
  final libDir = Directory('lib');
  final files = libDir.listSync(recursive: true).whereType<File>().where((f) => f.path.endsWith('.dart'));
  
  int count = 0;
  for (final file in files) {
    String content = file.readAsStringSync();
    if (content.contains('.withOpacity(')) {
      content = content.replaceAllMapped(
        RegExp(r'\.withOpacity\((.*?)\)'),
        (match) => '.withValues(alpha: ${match.group(1)})',
      );
      file.writeAsStringSync(content);
      print('Fixed ${file.path}');
      count++;
    }
  }
  print('Fixed $count files.');
}
