// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'minesweeper_game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$MinesweeperGameStateTearOff {
  const _$MinesweeperGameStateTearOff();

  _MinesweeperGameState call({required MinesweeperGameId? id}) {
    return _MinesweeperGameState(
      id: id,
    );
  }
}

/// @nodoc
const $MinesweeperGameState = _$MinesweeperGameStateTearOff();

/// @nodoc
mixin _$MinesweeperGameState {
  MinesweeperGameId? get id => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MinesweeperGameStateCopyWith<MinesweeperGameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MinesweeperGameStateCopyWith<$Res> {
  factory $MinesweeperGameStateCopyWith(MinesweeperGameState value,
          $Res Function(MinesweeperGameState) then) =
      _$MinesweeperGameStateCopyWithImpl<$Res>;
  $Res call({MinesweeperGameId? id});
}

/// @nodoc
class _$MinesweeperGameStateCopyWithImpl<$Res>
    implements $MinesweeperGameStateCopyWith<$Res> {
  _$MinesweeperGameStateCopyWithImpl(this._value, this._then);

  final MinesweeperGameState _value;
  // ignore: unused_field
  final $Res Function(MinesweeperGameState) _then;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as MinesweeperGameId?,
    ));
  }
}

/// @nodoc
abstract class _$MinesweeperGameStateCopyWith<$Res>
    implements $MinesweeperGameStateCopyWith<$Res> {
  factory _$MinesweeperGameStateCopyWith(_MinesweeperGameState value,
          $Res Function(_MinesweeperGameState) then) =
      __$MinesweeperGameStateCopyWithImpl<$Res>;
  @override
  $Res call({MinesweeperGameId? id});
}

/// @nodoc
class __$MinesweeperGameStateCopyWithImpl<$Res>
    extends _$MinesweeperGameStateCopyWithImpl<$Res>
    implements _$MinesweeperGameStateCopyWith<$Res> {
  __$MinesweeperGameStateCopyWithImpl(
      _MinesweeperGameState _value, $Res Function(_MinesweeperGameState) _then)
      : super(_value, (v) => _then(v as _MinesweeperGameState));

  @override
  _MinesweeperGameState get _value => super._value as _MinesweeperGameState;

  @override
  $Res call({
    Object? id = freezed,
  }) {
    return _then(_MinesweeperGameState(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as MinesweeperGameId?,
    ));
  }
}

/// @nodoc

class _$_MinesweeperGameState extends _MinesweeperGameState {
  _$_MinesweeperGameState({required this.id}) : super._();

  @override
  final MinesweeperGameId? id;

  @override
  String toString() {
    return 'MinesweeperGameState(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MinesweeperGameState &&
            const DeepCollectionEquality().equals(other.id, id));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(id));

  @JsonKey(ignore: true)
  @override
  _$MinesweeperGameStateCopyWith<_MinesweeperGameState> get copyWith =>
      __$MinesweeperGameStateCopyWithImpl<_MinesweeperGameState>(
          this, _$identity);
}

abstract class _MinesweeperGameState extends MinesweeperGameState {
  factory _MinesweeperGameState({required MinesweeperGameId? id}) =
      _$_MinesweeperGameState;
  _MinesweeperGameState._() : super._();

  @override
  MinesweeperGameId? get id;
  @override
  @JsonKey(ignore: true)
  _$MinesweeperGameStateCopyWith<_MinesweeperGameState> get copyWith =>
      throw _privateConstructorUsedError;
}
