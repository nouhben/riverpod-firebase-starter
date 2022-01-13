import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Job extends Equatable {
  const Job({required this.id, required this.name, required this.ratePerHour});
  final String id;
  final String name;
  final int ratePerHour;

  factory Job.fromMap(Map<String, dynamic>? data, String documentId) {
    if (data == null) {
      throw StateError('missing data for jobId: $documentId');
    }
    final name = data['name'] as String?;
    if (name == null) {
      throw StateError('missing name for jobId: $documentId');
    }
    final ratePerHour = data['ratePerHour'] as int;
    return Job(id: documentId, name: name, ratePerHour: ratePerHour);
  }

  Map<String, dynamic> toMap() => {'name': name, 'ratePerHour': ratePerHour};

  @override
  List<Object> get props => [id, name, ratePerHour];

  @override
  bool get stringify => true;
}

@immutable
class Entry extends Equatable {
  const Entry({
    required this.id,
    required this.jobId,
    required this.start,
    required this.end,
    required this.comment,
  });

  final String id;
  final String jobId;
  final DateTime start;
  final DateTime end;
  final String comment;
  double get durationInHours =>
      end.difference(start).inMinutes.toDouble() / 60.0;

  factory Entry.fromMap(Map<dynamic, dynamic>? value, String id) {
    if (value == null) {
      throw StateError('missing data for entryId: $id');
    }
    final startMilliseconds = value['start'] as int;
    final endMilliseconds = value['end'] as int;
    return Entry(
      id: id,
      jobId: value['jobId'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      comment: value['comment'] as String? ?? '',
    );
  }

  Map<String, dynamic> toMap() => {
        'jobId': jobId,
        'start': start.millisecondsSinceEpoch,
        'end': end.millisecondsSinceEpoch,
        'comment': comment
      };

  @override
  List<Object> get props => [id, jobId, start, end, comment];

  @override
  bool get stringify => true;
}
