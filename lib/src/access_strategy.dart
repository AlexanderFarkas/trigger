enum AccessStrategy {
  /// Event can always be [consume]d with initially assigned key
  reproduce,

  /// Event is sealed for every owner,
  /// if any owner tried to consume it with not-initially registerd key
  sealOnFailure,

  /// Owner is considered expelled, if they tried to consume event with not-initially registerd key
  /// Other owners could still consume event.
  expelOnFailure,
}