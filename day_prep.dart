// https://adventofcode.com/2015/day/1

import 'dart:io';

void main() {
  final input = File("./day_prep.input.txt").readAsStringSync();

  {
    final answer = input.runes.fold(
        0,
        (value, element) =>
            value +
            switch (element) {
              40 => 1, // (
              41 => -1, // )
              _ => 0,
            });

    print("Part one answer: $answer");
  }

  {
    late final answer;
    {
      var currentFloor = 0;
      for (int i = 0; i < input.length; i++) {
        if (currentFloor < 0) {
          answer = i;
          break;
        }

        switch (input[i]) {
          case "(":
            currentFloor += 1;
          case ")":
            currentFloor -= 1;
        }
      }
    }

    print("Part two answer: $answer");
  }
}
