import 'package:meta/meta.dart';
part of 'note_cubit.dart';

@immutable
sealed class NoteState {}

final class NoteInitial extends NoteState {}

final class NoteLoadingState extends NoteState {}

class NoteSuccessState extends NoteState {}

final class NoteEmptyState extends NoteState {}

final class NoteAddedState extends NoteState {}

final class NoteClearAllState extends NoteState {}

final class NoteDeleteNoteState extends NoteState {}