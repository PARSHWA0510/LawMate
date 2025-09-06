// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:lawmate_mobile/core/constants/app_strings.dart';
import 'package:lawmate_mobile/features/auth/bloc/auth_bloc.dart';
import 'package:lawmate_mobile/features/auth/domain/entities/user_entity.dart';
import 'package:lawmate_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:lawmate_mobile/features/auth/domain/usecases/login_usecase.dart';
import 'package:lawmate_mobile/features/auth/domain/usecases/signup_usecase.dart';
import 'package:lawmate_mobile/features/auth/domain/usecases/logout_usecase.dart';
import 'package:lawmate_mobile/core/error/failures.dart';

void main() {
  testWidgets('LawMate app smoke test', (WidgetTester tester) async {
    // Create a mock auth bloc for testing
    final mockAuthBloc = MockAuthBloc();

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<AuthBloc>(
          create: (context) => mockAuthBloc,
          child: const TestHomePage(),
        ),
      ),
    );

    // Verify that our app title is displayed.
    expect(find.text(AppStrings.appTitle), findsOneWidget);
    expect(find.text(AppStrings.appSubtitle), findsOneWidget);
  });
}

class MockAuthBloc extends AuthBloc {
  MockAuthBloc()
      : super(
          loginUseCase: MockLoginUseCase(),
          signupUseCase: MockSignupUseCase(),
          logoutUseCase: MockLogoutUseCase(),
        );
}

class MockLoginUseCase extends LoginUseCase {
  MockLoginUseCase() : super(MockAuthRepository());
}

class MockSignupUseCase extends SignupUseCase {
  MockSignupUseCase() : super(MockAuthRepository());
}

class MockLogoutUseCase extends LogoutUseCase {
  MockLogoutUseCase() : super(MockAuthRepository());
}

class MockAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, UserEntity>> login(
      String email, String password) async {
    return Right(UserEntity(
      id: '1',
      email: 'test@example.com',
      name: 'Test User',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));
  }

  @override
  Future<Either<Failure, UserEntity>> signup(
      String email, String password, String name) async {
    return Right(UserEntity(
      id: '1',
      email: 'test@example.com',
      name: 'Test User',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));
  }

  @override
  Future<Either<Failure, void>> logout() async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, UserEntity?>> getCurrentUser() async {
    return Right(UserEntity(
      id: '1',
      email: 'test@example.com',
      name: 'Test User',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    ));
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    return const Right(true);
  }

  @override
  Future<Either<Failure, String?>> getToken() async {
    return const Right('mock_token');
  }

  @override
  Future<Either<Failure, void>> saveToken(String token) async {
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> clearToken() async {
    return const Right(null);
  }
}

class TestHomePage extends StatelessWidget {
  const TestHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.gavel,
              size: 80,
              color: Color(0xFF2E7D32),
            ),
            SizedBox(height: 24),
            Text(
              AppStrings.appTitle,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2E7D32),
              ),
            ),
            SizedBox(height: 8),
            Text(
              AppStrings.appSubtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
