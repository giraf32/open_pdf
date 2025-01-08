class BankItem {
  const BankItem({
    required this.bankName,
    required this.logoURL,
    required this.schema,
  });

  final String bankName;
  final String logoURL;
  final String schema;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is BankItem &&
              runtimeType == other.runtimeType &&
              bankName == other.bankName &&
              logoURL == other.logoURL &&
              schema == other.schema;

  @override
  int get hashCode => bankName.hashCode ^ logoURL.hashCode ^ schema.hashCode;
}