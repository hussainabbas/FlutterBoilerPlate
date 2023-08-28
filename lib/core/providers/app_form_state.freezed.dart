// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppFormState<T> {
  T get form => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppFormStateCopyWith<T, AppFormState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppFormStateCopyWith<T, $Res> {
  factory $AppFormStateCopyWith(
          AppFormState<T> value, $Res Function(AppFormState<T>) then) =
      _$AppFormStateCopyWithImpl<T, $Res, AppFormState<T>>;
  @useResult
  $Res call({T form});
}

/// @nodoc
class _$AppFormStateCopyWithImpl<T, $Res, $Val extends AppFormState<T>>
    implements $AppFormStateCopyWith<T, $Res> {
  _$AppFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = freezed,
  }) {
    return _then(_value.copyWith(
      form: freezed == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AppFormStateCopyWith<T, $Res>
    implements $AppFormStateCopyWith<T, $Res> {
  factory _$$_AppFormStateCopyWith(
          _$_AppFormState<T> value, $Res Function(_$_AppFormState<T>) then) =
      __$$_AppFormStateCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T form});
}

/// @nodoc
class __$$_AppFormStateCopyWithImpl<T, $Res>
    extends _$AppFormStateCopyWithImpl<T, $Res, _$_AppFormState<T>>
    implements _$$_AppFormStateCopyWith<T, $Res> {
  __$$_AppFormStateCopyWithImpl(
      _$_AppFormState<T> _value, $Res Function(_$_AppFormState<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? form = freezed,
  }) {
    return _then(_$_AppFormState<T>(
      freezed == form
          ? _value.form
          : form // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_AppFormState<T> implements _AppFormState<T> {
  const _$_AppFormState(this.form);

  @override
  final T form;

  @override
  String toString() {
    return 'AppFormState<$T>(form: $form)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppFormState<T> &&
            const DeepCollectionEquality().equals(other.form, form));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(form));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AppFormStateCopyWith<T, _$_AppFormState<T>> get copyWith =>
      __$$_AppFormStateCopyWithImpl<T, _$_AppFormState<T>>(this, _$identity);
}

abstract class _AppFormState<T> implements AppFormState<T> {
  const factory _AppFormState(final T form) = _$_AppFormState<T>;

  @override
  T get form;
  @override
  @JsonKey(ignore: true)
  _$$_AppFormStateCopyWith<T, _$_AppFormState<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
