// https://adventofcode.com/2023/day/2

import 'dart:io';

const maxRed = 12;
const maxGreen = 13;
const maxBlue = 14;

enum Cube {
  red,
  green,
  blue,
}

class Game {
  int id;
  List<Map<Cube, int>> sets;

  Game({required this.id, required this.sets});

  static Game parseString(String input) {
    late int id;
    List<Map<Cube, int>> sets = [];

    int i = 4;

    if (input.substring(0, 5) != 'Game ') throw "Unreachable";

    while (input[i] != ':') i++;
    id = int.parse(input.substring(5, i));

    String tempNumber = '';
    String tempLetter = '';
    Map<Cube, int> tempSet = {};

    for (int j = i + 1; j < input.length; j++) {
      if (input[j] == ' ') continue;

      if (input[j] == ',' || input[j] == ';') {
        switch (tempLetter) {
          case "red":
            tempSet.update(Cube.red, (value) => value + int.parse(tempNumber),
                ifAbsent: () => int.parse(tempNumber));
          case "green":
            tempSet.update(Cube.green, (value) => value + int.parse(tempNumber),
                ifAbsent: () => int.parse(tempNumber));
          case "blue":
            tempSet.update(Cube.blue, (value) => value + int.parse(tempNumber),
                ifAbsent: () => int.parse(tempNumber));
          default:
            throw "Unreachable";
        }

        if (input[j] == ';') {
          sets.add(tempSet);
          tempSet = {};
        }

        tempLetter = '';
        tempNumber = '';
        continue;
      }

      if ("1234567890".contains(input[j])) {
        tempNumber = "$tempNumber${input[j]}";
        continue;
      }

      tempLetter = "$tempLetter${input[j]}";
    }

    switch (tempLetter) {
      case "red":
        tempSet.update(Cube.red, (value) => value + int.parse(tempNumber),
            ifAbsent: () => int.parse(tempNumber));
      case "green":
        tempSet.update(Cube.green, (value) => value + int.parse(tempNumber),
            ifAbsent: () => int.parse(tempNumber));
      case "blue":
        tempSet.update(Cube.blue, (value) => value + int.parse(tempNumber),
            ifAbsent: () => int.parse(tempNumber));
      default:
        throw "Unreachable";
    }
    sets.add(tempSet);

    return Game(id: id, sets: sets);
  }
}

void main() {
  final input = File("./day_02.input.txt").readAsLinesSync();

  {
    final answer = input
        .map((e) => Game.parseString(e))
        .where(
          (e) => e.sets.every(
            (e) => e.entries.every(
              (e) => switch (e.key) {
                Cube.red => e.value <= maxRed,
                Cube.blue => e.value <= maxBlue,
                Cube.green => e.value <= maxGreen,
              },
            ),
          ),
        )
        .map((e) => e.id)
        .reduce((v, e) => v += e);

    print("Part one answer: $answer");
  }

  {
    // final input = [
    // 'Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green',
    // 'Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue',
    // 'Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red',
    // 'Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red',
    // 'Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green'
    // ];

    final answer = input
        .map((e) => Game.parseString(e))
        .map((e) {
          Map<Cube, int> minimalSet = {};

          for (final sets in e.sets) {
            for (final gameSet in sets.entries) {
              minimalSet.update(
                gameSet.key,
                (value) => gameSet.value > value ? gameSet.value : value,
                ifAbsent: () => gameSet.value,
              );
            }
          }

          return minimalSet;
        })
        .map((e) => e.values.reduce((v, e) => v *= e))
        .reduce((v, e) => v += e);

    print("Part two answer: $answer");
  }
}
