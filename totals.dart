
import 'dart:io';

void main(List<String> arguments) {

  if (arguments.isEmpty) {
    print('Usage: dart totals.dart <inputFile.csv>');
    exit(1);
  }

  final inputFile = arguments.first;
  final lines = File(inputFile).readAsLinesSync();
  final totalDurationByTag = <String, double>{};
  var totalDuration = 0.0;
  lines.removeAt(0);

  for (var line in lines) {
    final values = line.split(',');
    final tag = values[5].replaceAll('"', '');
    final durationStr =  values[3].replaceAll('"', '');
    final duration = double.parse(durationStr);
    final previousTotal = totalDurationByTag[tag];

    if(previousTotal==null) {
      totalDurationByTag[tag] = duration;
    } else {
      totalDurationByTag[tag] = previousTotal + duration;
    }
    totalDuration += duration;
  }

  for(var entry in totalDurationByTag.entries) {
      final durationFormated = entry.value.toStringAsFixed(1);
      final tag = entry.key == '' ? 'Unallocated' : entry.key;
      print('$tag: ${durationFormated}h');
    }
     print('Total time: ${totalDuration.toStringAsFixed(1)}h');
}