import 'package:equatable/equatable.dart';

enum MessageType { user, assistant, system }

class ChatMessageEntity extends Equatable {
  final String id;
  final String content;
  final MessageType type;
  final DateTime timestamp;
  final bool isTyping;
  final String? errorMessage;
  final List<String>? suggestions;

  const ChatMessageEntity({
    required this.id,
    required this.content,
    required this.type,
    required this.timestamp,
    this.isTyping = false,
    this.errorMessage,
    this.suggestions,
  });

  @override
  List<Object?> get props => [
        id,
        content,
        type,
        timestamp,
        isTyping,
        errorMessage,
        suggestions,
      ];
}
