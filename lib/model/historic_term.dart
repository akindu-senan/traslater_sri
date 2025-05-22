// lib/models/historic_term.dart
class HistoricTerm {
  final String term;
  final String era;
  final String meaning;

  HistoricTerm({
    required this.term,
    required this.era,
    required this.meaning,
  });

  factory HistoricTerm.fromJson(Map<String, dynamic> json) {
    return HistoricTerm(
      term: json['term'],
      era: json['era'],
      meaning: json['meaning'],
    );
  }
}
