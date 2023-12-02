// https://adventofcode.com/2023/day/1/answer

import 'dart:io';

void main() {
  final input = File("./day_01.input.txt").readAsLinesSync();

  {
    final answer = input.fold(
        0,
        (value, element) =>
            value +
            element.runes.fold(0, (value, element) {
              return (element >= 49 && element <= 57)
                  ? value == 0
                      ? ((element - 48) * 10) + (element - 48)
                      : (value ~/ 10 * 10) + (element - 48)
                  : value;
            }));

    print("Part one answer: $answer");
  }

  {
    // final input = [
    // "two1nine",
    // "eightwothree",
    // "abcone2threexyz",
    // "xtwone3four",
    // "4nineeightseven2",
    // "zoneight234",
    // "7pqrstsixteen",
    // ];

    const numberTable = [
      ("1", 1), ("2", 2), ("3", 3), //
      ("4", 4), ("5", 5), ("6", 6), //
      ("7", 7), ("8", 8), ("9", 9), //
      ("one", 1), ("two", 2), ("three", 3), //
      ("four", 4), ("five", 5), ("six", 6), //
      ("seven", 7), ("eight", 8), ("nine", 9), //
    ];
    const numberTableReversed = [
      ("1", 1), ("2", 2), ("3", 3), //
      ("4", 4), ("5", 5), ("6", 6), //
      ("7", 7), ("8", 8), ("9", 9), //
      ("eno", 1), ("owt", 2), ("eerht", 3), //
      ("ruof", 4), ("evif", 5), ("xis", 6), //
      ("neves", 7), ("thgie", 8), ("enin", 9), //
    ];

    var answer = 0;

    for (final line in input) {
      late final int firstNumber;
      {
        List<(String, List<(String, int)>)> lookup = [];
        outer:
        for (int i = 0; i < line.length; i++) {
          lookup = lookup.map((e) => ("${e.$1}${line[i]}", e.$2)).toList();
          lookup.add((line[i], List.of(numberTable)));
          for (int j = 0; j < lookup.length; j++) {
            final (token, table) = lookup[j];
            final newTable =
                table.where((e) => e.$1.startsWith(token)).toList();

            lookup[j] = (
              token,
              newTable,
            );

            if (newTable.isNotEmpty) {
              if (token == newTable.first.$1) {
                firstNumber = newTable.first.$2;
                break outer;
              }
            }
          }
          print(lookup);
          lookup = lookup.where((e) => e.$2.isNotEmpty).toList();
        }
      }

      late final int secondNumber;
      final lineReversed = String.fromCharCodes(line.runes.toList().reversed);
      {
        List<(String, List<(String, int)>)> lookup = [];
        outer:
        for (int i = 0; i < lineReversed.length; i++) {
          lookup =
              lookup.map((e) => ("${e.$1}${lineReversed[i]}", e.$2)).toList();
          lookup.add((lineReversed[i], List.of(numberTableReversed)));
          for (int j = 0; j < lookup.length; j++) {
            final (token, table) = lookup[j];
            final newTable =
                table.where((e) => e.$1.startsWith(token)).toList();

            lookup[j] = (
              token,
              newTable,
            );

            if (newTable.isNotEmpty) {
              if (token == newTable.first.$1) {
                secondNumber = newTable.first.$2;
                break outer;
              }
            }
          }
          print(lookup);
          lookup = lookup.where((e) => e.$2.isNotEmpty).toList();
        }
      }

      answer += firstNumber * 10 + secondNumber;
    }

    print("Part two answer: $answer");
  }
}
