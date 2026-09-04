import '../../domain/entities/faq_category.dart';
import '../../domain/entities/faq_entity.dart';

class FaqModel extends FaqEntity {
  const FaqModel({
    required super.id,
    required super.question,
    required super.answer,
    required super.category,
  });

  /// Decodes backend JSON data safely with string fallback guards
  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
      id: json['id']?.toString() ?? '',
      question: json['question'] ?? '',
      answer: json['answer'] ?? '',
      category: FaqCategory.fromString(json['category'] ?? 'general'),
    );
  }

  /// Encodes model state back to JSON formatting
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'category': category.name,
    };
  }
}
