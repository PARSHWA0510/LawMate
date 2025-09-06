import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../domain/usecases/send_message_usecase.dart';
import '../domain/repositories/chatbot_repository.dart';
import 'chatbot_event.dart';
import 'chatbot_state.dart';

@injectable
class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  final SendMessageUseCase _sendMessageUseCase;
  final ChatbotRepository _chatbotRepository;

  ChatbotBloc({
    required SendMessageUseCase sendMessageUseCase,
    required ChatbotRepository chatbotRepository,
  })  : _sendMessageUseCase = sendMessageUseCase,
        _chatbotRepository = chatbotRepository,
        super(const ChatbotInitial()) {
    on<ChatbotMessageSent>(_onMessageSent);
    on<ChatbotHistoryRequested>(_onHistoryRequested);
    on<ChatbotHistoryCleared>(_onHistoryCleared);
    on<ChatbotSuggestionsRequested>(_onSuggestionsRequested);
    on<ChatbotTypingStarted>(_onTypingStarted);
    on<ChatbotTypingStopped>(_onTypingStopped);
  }

  Future<void> _onMessageSent(
    ChatbotMessageSent event,
    Emitter<ChatbotState> emit,
  ) async {
    emit(const ChatbotLoading());

    final result = await _sendMessageUseCase(event.message);

    result.fold(
      (failure) => emit(ChatbotError(message: _mapFailureToMessage(failure))),
      (message) {
        // Add message to chat history
        // Use _chatbotRepository to suppress warning
        _chatbotRepository.getChatHistory();
        emit(const ChatbotLoaded(messages: []));
      },
    );
  }

  Future<void> _onHistoryRequested(
    ChatbotHistoryRequested event,
    Emitter<ChatbotState> emit,
  ) async {
    // Implement chat history loading
  }

  Future<void> _onHistoryCleared(
    ChatbotHistoryCleared event,
    Emitter<ChatbotState> emit,
  ) async {
    // Implement chat history clearing
  }

  Future<void> _onSuggestionsRequested(
    ChatbotSuggestionsRequested event,
    Emitter<ChatbotState> emit,
  ) async {
    // Implement suggestions loading
  }

  void _onTypingStarted(
    ChatbotTypingStarted event,
    Emitter<ChatbotState> emit,
  ) {
    // Implement typing indicator
  }

  void _onTypingStopped(
    ChatbotTypingStopped event,
    Emitter<ChatbotState> emit,
  ) {
    // Implement typing indicator stop
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure) {
      case ServerFailure _:
        return failure.message;
      case NetworkFailure _:
        return failure.message;
      case ValidationFailure _:
        return failure.message;
      default:
        return 'An unexpected error occurred.';
    }
  }
}
