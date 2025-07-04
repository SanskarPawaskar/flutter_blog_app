part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String failure;

  BlogFailure(this.failure);

}

final class BlogSuccess extends BlogState {}
