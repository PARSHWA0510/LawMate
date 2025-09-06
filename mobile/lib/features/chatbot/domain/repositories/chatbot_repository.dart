import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';

abstract class ChatbotRepository {
  Future<Either<Failure, ChatMessageEntity>> sendMessage(String message);
  Future<Either<Failure, List<ChatMessageEntity>>> getChatHistory();
  Future<Either<Failure, void>> clearChatHistory();
  Future<Either<Failure, List<String>>> getSuggestedQuestions();
  Future<Either<Failure, String>> getLegalAdvice(String query);
}
