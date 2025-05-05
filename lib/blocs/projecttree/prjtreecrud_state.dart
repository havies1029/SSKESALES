part of 'prjtreecrud_bloc.dart';

class PrjtreeCrudState extends Equatable {

	final PrjtreeCrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	final ComboCustomerModel? comboCustomer;
	final ComboMMstJobcatModel? comboMMstJobcat;
	const PrjtreeCrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.comboCustomer,
		this.comboMMstJobcat,
});

	PrjtreeCrudState copyWith({
		PrjtreeCrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		ComboCustomerModel? comboCustomer,
		ComboMMstJobcatModel? comboMMstJobcat,
	}){
		return PrjtreeCrudState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
			comboCustomer: comboCustomer?? this.comboCustomer,
			comboMMstJobcat: comboMMstJobcat?? this.comboMMstJobcat,
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
