import 'package:equatable/equatable.dart';

class ComparisonEntity extends Equatable {
  final String id;
  final String title;
  final List<String> documentIds;
  final List<ComparisonItemEntity> items;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const ComparisonEntity({
    required this.id,
    required this.title,
    required this.documentIds,
    required this.items,
    required this.createdAt,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        documentIds,
        items,
        createdAt,
        updatedAt,
      ];
}

class ComparisonItemEntity extends Equatable {
  final String documentId;
  final String title;
  final String content;
  final String type;
  final String category;
  final Map<String, dynamic> comparisonData;

  const ComparisonItemEntity({
    required this.documentId,
    required this.title,
    required this.content,
    required this.type,
    required this.category,
    required this.comparisonData,
  });

  @override
  List<Object> get props => [
        documentId,
        title,
        content,
        type,
        category,
        comparisonData,
      ];
}
