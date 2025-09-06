import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../entities/chat_message_entity.dart';
import '../repositories/chatbot_repository.dart';

@injectable
class SendMessageUseCase {
  final ChatbotRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failure, ChatMessageEntity>> call(String message) async {
    return await repository.sendMessage(message);
  }
}
