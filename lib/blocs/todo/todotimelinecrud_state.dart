part of 'todotimelinecrud_bloc.dart';

class TodoTimelineCrudState extends Equatable {

	final TodoTimelineCrudModel? record;
	final bool isLoading;
	final bool isLoaded;
	final bool isSaving;
	final bool isSaved;
	final bool hasFailure;
	final ComboJobcatgroupModel? comboJobcatgroup;
	const TodoTimelineCrudState(
		{this.record,
		this.isLoading = false,
		this.isLoaded = false,
		this.isSaving = false,
		this.isSaved = false,
		this.hasFailure = false,
		this.comboJobcatgroup,
});

	TodoTimelineCrudState copyWith({
		TodoTimelineCrudModel? record,
		bool? isLoading,
		bool? isLoaded,
		bool? isSaving,
		bool? isSaved,
		bool? hasFailure,
		ComboJobcatgroupModel? comboJobcatgroup,
	}){
		return TodoTimelineCrudState(
			record: record ?? this.record,
			isLoading: isLoading ?? this.isLoading,
			isLoaded: isLoaded ?? this.isLoaded,
			isSaving: isSaving ?? this.isSaving,
			isSaved: isSaved ?? this.isSaved,
			hasFailure: hasFailure ?? this.hasFailure,
			comboJobcatgroup: comboJobcatgroup?? this.comboJobcatgroup,
		);
	}

	@override
	List<Object> get props => [isLoading, isLoaded, isSaving, isSaved, hasFailure];
}
