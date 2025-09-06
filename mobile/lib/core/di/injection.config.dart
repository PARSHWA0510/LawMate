// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:lawmate_mobile/core/di/external_module.dart' as _i603;
import 'package:lawmate_mobile/core/network/api_client.dart' as _i873;
import 'package:lawmate_mobile/features/auth/bloc/auth_bloc.dart' as _i1015;
import 'package:lawmate_mobile/features/auth/data/datasources/auth_local_datasource.dart'
    as _i760;
import 'package:lawmate_mobile/features/auth/data/datasources/auth_remote_datasource.dart'
    as _i353;
import 'package:lawmate_mobile/features/auth/data/repositories/auth_repository_impl.dart'
    as _i614;
import 'package:lawmate_mobile/features/auth/domain/repositories/auth_repository.dart'
    as _i427;
import 'package:lawmate_mobile/features/auth/domain/usecases/login_usecase.dart'
    as _i382;
import 'package:lawmate_mobile/features/auth/domain/usecases/logout_usecase.dart'
    as _i707;
import 'package:lawmate_mobile/features/auth/domain/usecases/signup_usecase.dart'
    as _i1052;
import 'package:lawmate_mobile/features/bookmarks/bloc/bookmark_bloc.dart'
    as _i964;
import 'package:lawmate_mobile/features/bookmarks/domain/repositories/bookmark_repository.dart'
    as _i13;
import 'package:lawmate_mobile/features/chatbot/bloc/chatbot_bloc.dart'
    as _i355;
import 'package:lawmate_mobile/features/chatbot/domain/repositories/chatbot_repository.dart'
    as _i783;
import 'package:lawmate_mobile/features/chatbot/domain/usecases/send_message_usecase.dart'
    as _i847;
import 'package:lawmate_mobile/features/compare/bloc/compare_bloc.dart'
    as _i932;
import 'package:lawmate_mobile/features/compare/domain/repositories/comparison_repository.dart'
    as _i250;
import 'package:lawmate_mobile/features/documents/bloc/document_bloc.dart'
    as _i871;
import 'package:lawmate_mobile/features/documents/domain/repositories/document_repository.dart'
    as _i572;
import 'package:lawmate_mobile/features/documents/domain/usecases/get_document_usecase.dart'
    as _i458;
import 'package:lawmate_mobile/features/profile/bloc/profile_bloc.dart'
    as _i196;
import 'package:lawmate_mobile/features/profile/domain/repositories/profile_repository.dart'
    as _i484;
import 'package:lawmate_mobile/features/search/bloc/search_bloc.dart' as _i41;
import 'package:lawmate_mobile/features/search/domain/repositories/search_repository.dart'
    as _i890;
import 'package:lawmate_mobile/features/search/domain/usecases/search_documents_usecase.dart'
    as _i234;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final externalModule = _$ExternalModule();
    gh.factory<_i873.ApiClient>(() => _i873.ApiClient());
    await gh.singletonAsync<_i460.SharedPreferences>(
      () => externalModule.prefs,
      preResolve: true,
    );
    gh.factory<_i458.GetDocumentUseCase>(
        () => _i458.GetDocumentUseCase(gh<_i572.DocumentRepository>()));
    gh.factory<_i760.AuthLocalDataSource>(
        () => _i760.AuthLocalDataSourceImpl(gh<_i460.SharedPreferences>()));
    gh.factory<_i196.ProfileBloc>(() =>
        _i196.ProfileBloc(profileRepository: gh<_i484.ProfileRepository>()));
    gh.factory<_i353.AuthRemoteDataSource>(
        () => _i353.AuthRemoteDataSourceImpl());
    gh.factory<_i932.CompareBloc>(() => _i932.CompareBloc(
        comparisonRepository: gh<_i250.ComparisonRepository>()));
    gh.factory<_i964.BookmarkBloc>(() =>
        _i964.BookmarkBloc(bookmarkRepository: gh<_i13.BookmarkRepository>()));
    gh.factory<_i871.DocumentBloc>(() => _i871.DocumentBloc(
          getDocumentUseCase: gh<_i458.GetDocumentUseCase>(),
          documentRepository: gh<_i572.DocumentRepository>(),
        ));
    gh.factory<_i847.SendMessageUseCase>(
        () => _i847.SendMessageUseCase(gh<_i783.ChatbotRepository>()));
    gh.factory<_i427.AuthRepository>(() => _i614.AuthRepositoryImpl(
          remoteDataSource: gh<_i353.AuthRemoteDataSource>(),
          localDataSource: gh<_i760.AuthLocalDataSource>(),
        ));
    gh.factory<_i234.SearchDocumentsUseCase>(
        () => _i234.SearchDocumentsUseCase(gh<_i890.SearchRepository>()));
    gh.factory<_i1052.SignupUseCase>(
        () => _i1052.SignupUseCase(gh<_i427.AuthRepository>()));
    gh.factory<_i382.LoginUseCase>(
        () => _i382.LoginUseCase(gh<_i427.AuthRepository>()));
    gh.factory<_i707.LogoutUseCase>(
        () => _i707.LogoutUseCase(gh<_i427.AuthRepository>()));
    gh.factory<_i1015.AuthBloc>(() => _i1015.AuthBloc(
          loginUseCase: gh<_i382.LoginUseCase>(),
          signupUseCase: gh<_i1052.SignupUseCase>(),
          logoutUseCase: gh<_i707.LogoutUseCase>(),
        ));
    gh.factory<_i355.ChatbotBloc>(() => _i355.ChatbotBloc(
          sendMessageUseCase: gh<_i847.SendMessageUseCase>(),
          chatbotRepository: gh<_i783.ChatbotRepository>(),
        ));
    gh.factory<_i41.SearchBloc>(() => _i41.SearchBloc(
        searchDocumentsUseCase: gh<_i234.SearchDocumentsUseCase>()));
    return this;
  }
}

class _$ExternalModule extends _i603.ExternalModule {}
