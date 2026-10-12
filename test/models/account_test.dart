import 'package:anybank/models/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Account account;

  setUp(() {
    account = Account(
      id: 1,
      name: 'João',
      cpf: '123.4566.789-00',
      balance: 100.00,
    );
  });

  group('Transfer', () {
    test('should a transfer success', () {
      account.transfer(50);

      expect(account.balance, 50);
    });

    test('check if transfer amount is number negatives', () {
      expect(() => account.transfer(0), throwsA(isA<InvalidAmountException>()));
      expect(
          () => account.transfer(-100), throwsA(isA<InvalidAmountException>()));
    });

    test('checks if the transfer amount is greater than the account balance',
        () {
      expect(() => account.transfer(150),
          throwsA(isA<InsuficientAmountException>()));
    });

    test('checks if the transfer is null', () {
      expect(() => account.transfer(null), throwsA(isA<NullAmountException>()));
    });
  });

  group('Deposit', () {
    test('should a deposit success', () {
      account.deposit(50);

      expect(account.balance, 150);
    });

    test('checks if the deposit is null', () {
      expect(() => account.deposit(null), throwsA(isA<NullAmountException>()));
    });

    test('checks if the deposit amount is negative numbers', () {
      expect(() => account.deposit(0), throwsA(isA<InvalidAmountException>()));
      expect(
          () => account.deposit(-100), throwsA(isA<InvalidAmountException>()));
    });
  });

  group('Account interest rates', () {
    test(
        'should interest of 1% must be applied when the account type is a checking account',
        () {
      account.applyInterest();

      expect(account.balance, 101);
    });

    test(
        'should interest of 3% must be applied when the account type is a savings account',
        () {
      final Account savingsAccount = Account(
          id: 123,
          name: 'Joao',
          cpf: '123.123.123-00',
          balance: 100.0,
          accountType: AccountTypes.savings);

      savingsAccount.applyInterest();

      expect(savingsAccount.balance, 103);
    });

    test(
        'should interest of 7% must be applied when the account type is a investiment account',
        () {
      final Account investimentAccount = Account(
          id: 123,
          name: 'Joao',
          cpf: '123.123.123-00',
          balance: 100.0,
          accountType: AccountTypes.investiment);

      investimentAccount.applyInterest();

      expect(investimentAccount.balance, 107);
    });
  });
}
