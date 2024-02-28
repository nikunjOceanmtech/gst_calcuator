part of 'tax_slab_cubit.dart';

abstract class TaxSlabState extends Equatable {
  const TaxSlabState();

  @override
  List<Object?> get props => [];
}

class TaxSlabInitialState extends TaxSlabState {}

class TaxSlabLoadingState extends TaxSlabState {}

class TaxSlabLoadedState extends TaxSlabState {
  final List<String> gstPlusSlabList;
  final List<String> gstMinusSlabList;
  final double? random;

  const TaxSlabLoadedState({
    required this.gstPlusSlabList,
    required this.gstMinusSlabList,
    this.random,
  });

  TaxSlabLoadedState copyWith({
    List<String>? gstPlusSlabList,
    List<String>? gstMinusSlabList,
    double? random,
  }) {
    return TaxSlabLoadedState(
      gstPlusSlabList: gstPlusSlabList ?? this.gstPlusSlabList,
      gstMinusSlabList: gstMinusSlabList ?? this.gstMinusSlabList,
      random: random ?? this.random,
    );
  }

  @override
  List<Object?> get props => [gstPlusSlabList, gstMinusSlabList, random];
}

class TaxSlabErrorState extends TaxSlabState {}
