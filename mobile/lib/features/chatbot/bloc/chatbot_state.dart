import 'package:equatable/equatable.dart';
import '../domain/entities/chat_message_entity.dart';

abstract class ChatbotState extends Equatable {
  const ChatbotState();

  @override
  List<Object?> get props => [];
}

class ChatbotInitial extends ChatbotState {
  const ChatbotInitial();
}

class ChatbotLoading extends ChatbotState {
  const ChatbotLoading();
}

class ChatbotLoaded extends ChatbotState {
  final List<ChatMessageEntity> messages;
  final bool isTyping;
  final List<String>? suggestions;

  const ChatbotLoaded({
    required this.messages,
    this.isTyping = false,
    this.suggestions,
  });

  @override
  List<Object?> get props => [messages, isTyping, suggestions];
}

class ChatbotError extends ChatbotState {
  final String message;

  const ChatbotError({required this.message});

  @override
  List<Object> get props => [message];
}
