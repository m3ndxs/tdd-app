class NullAmountException implements Exception {
  @override
  String toString() => 'O valor não pode ser nulo';
}

class InsuficientAmountException implements Exception {
  @override
  String toString() => 'Saldo insuficiente para a transfêrencia';
}

class InvalidAmountException implements Exception {
  @override
  String toString() => 'Valor da transfêrencia deve ser maior que 0';
}

class Account {
  final int id;
  final String name;
  final String cpf;
  double balance;

  Account({
    required this.id,
    required this.name,
    required this.cpf,
    required this.balance,
  });

  void transfer(double? amount) {
    if (amount == null) {
      throw NullAmountException();
    }

    if (amount > balance) {
      throw InsuficientAmountException();
    }

    if (amount <= 0) {
      throw InvalidAmountException();
    }

    balance -= amount;
  }

  void deposit(double? amount) {
    if (amount == null) {
      throw NullAmountException();
    }

    if (amount <= 0) {
      throw InvalidAmountException();
    }

    balance += amount;
  }
}
