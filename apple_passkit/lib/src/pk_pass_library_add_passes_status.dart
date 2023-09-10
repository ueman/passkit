enum PKPassLibraryAddPassesStatus {
  /// A status that occurs when the user successfully adds one or more passes.
  didAddPasses('didAddPasses'),

  /// A status that occurs when the app prompts the user to review the passes.
  shouldReviewPasses('shouldReviewPasses'),

  /// A status that occurs when the user cancels the addition of passes.
  didCancelAddPasses('didCancelAddPasses'),

  /// Unkown error
  unknown('unknown');

  const PKPassLibraryAddPassesStatus(this.name);

  /// Name of the error
  final String name;
}
