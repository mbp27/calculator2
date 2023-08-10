import 'dart:convert';

class Calculation {
  final String question;
  final num? answer;

  Calculation({
    required this.question,
    this.answer,
  });

  Calculation copyWith({
    String? question,
    num? answer,
  }) {
    return Calculation(
      question: question ?? this.question,
      answer: answer ?? this.answer,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }

  factory Calculation.fromMap(Map<String, dynamic> map) {
    return Calculation(
      question: map['question'] ?? '',
      answer: map['answer'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Calculation.fromJson(String source) =>
      Calculation.fromMap(json.decode(source));

  @override
  String toString() => 'Calculation(question: $question, answer: $answer)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Calculation &&
        other.question == question &&
        other.answer == answer;
  }

  @override
  int get hashCode => question.hashCode ^ answer.hashCode;
}
