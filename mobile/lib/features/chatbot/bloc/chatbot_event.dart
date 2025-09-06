import 'package:equatable/equatable.dart';

abstract class ChatbotEvent extends Equatable {
  const ChatbotEvent();

  @override
  List<Object> get props => [];
}

class ChatbotMessageSent extends ChatbotEvent {
  final String message;

  const ChatbotMessageSent(this.message);

  @override
  List<Object> get props => [message];
}

class ChatbotHistoryRequested extends ChatbotEvent {
  const ChatbotHistoryRequested();
}

class ChatbotHistoryCleared extends ChatbotEvent {
  const ChatbotHistoryCleared();
}

class ChatbotSuggestionsRequested extends ChatbotEvent {
  const ChatbotSuggestionsRequested();
}

class ChatbotTypingStarted extends ChatbotEvent {
  const ChatbotTypingStarted();
}

class ChatbotTypingStopped extends ChatbotEvent {
  const ChatbotTypingStopped();
}
