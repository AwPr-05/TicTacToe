import 'dart:io';

import 'package:dart_console/dart_console.dart';

List<List<dynamic>> matriz = [
  [1, 2, 3],
  [4, 5, 6],
  [7, 8, 9]
];
String caracter1 = "";
String caracter2 = "";
String nome1 = "";
String nome2 = "";
int pontuacaoJogador1 = 0;
int pontuacaoJogador2 = 0;

String tabuleiro = '''
+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
|-=--=-=Bem vindo ao Jogo da Velha!!-=--=-|
+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
|      ---------|---------|---------      |
|               |         |               |
|          1    |    2    |    3          |
|               |         |               |
|      ---------|---------|---------      |
|               |         |               |
|          4    |    5    |    6          |
|               |         |               |
|      ---------|---------|---------      |
|               |         |               |
|          7    |    8    |    9          |
|               |         |               |
|      ---------|---------|---------      |
+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
''';
String rodape = '''
|(0) $nome1:$caracter1                               
|(0) $nome2:$caracter2                              
+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
''';
String tabuleiroRefresh = '''
+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
|-=--=-=Bem vindo ao Jogo da Velha!!-=--=-|
+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
|      ---------|---------|---------      |
|               |         |               |
|          1    |    2    |    3          |
|               |         |               |
|      ---------|---------|---------      |
|               |         |               |
|          4    |    5    |    6          |
|               |         |               |
|      ---------|---------|---------      |
|               |         |               |
|          7    |    8    |    9          |
|               |         |               |
|      ---------|---------|---------      |
+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
''';
String rodapeRefresh = '''
+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
|(pt1) $nome1:$caracter1                               
|(pt2) $nome2:$caracter2                              
+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
''';
// String tabuleiro = '''
// +-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
// |-=--=-=Bem vindo ao Jogo da Velha!!-=--=-|
// +-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
// |       +-------+-------+-------+         |
// |       |       |       |       |         |
// |       |   1   |   2   |   3   |         |
// |       |       |       |       |         |
// |       |-------|-------|-------|         |
// |       |       |       |       |         |
// |       |   4   |   5   |   6   |         |
// |       |       |       |       |         |
// |       |-------|-------|-------|         |
// |       |       |       |       |         |
// |       |   7   |   8   |   9   |         |
// |       |       |       |       |         |
// |       +-------+-------+-------+         |
// +-=--=--=--=--=--=--=--=--=--=--=--=--=--=+
// ''';

bool temosVencedor = false;
bool temosVelha = false;
bool alternarJogada = false;
bool alternarJogador = false;
var console = Console();

void main() {
  print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
  print("Jogador 1, Coloque seu nome:         ");
  nome1 = stdin.readLineSync();
  print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");

// fazer a pergunta, mudar pra maiuscula a letra escolhida
  print("$nome1, Escolha o seu caracter:         ");
  caracter1 = stdin.readLineSync().toUpperCase();
  print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
  // print("\n");
  console.clearScreen();

  print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
  print("Jogador 2, Coloque seu nome:         ");
  nome2 = stdin.readLineSync();
  print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");

  print("$nome2 , Escolha o seu caracter:         ");
  print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
  caracter2 = stdin.readLineSync().toUpperCase();
  print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
  // print("\n\n");
  console.clearScreen();

  while (!temosVencedor && !temosVelha) {
    // APRESENTAR TABULEIRO

    printarTabuleiro();

    String caracterAtual = alternarJogada ? caracter2 : caracter1;
    String jogador = alternarJogador ? nome2 : nome1;

    print("$jogador, escolha sua posicao na tabela");
    String escolha = stdin.readLineSync();
    int escolhaConvertida = int.tryParse(escolha);

    print("O valor escolhido foi: $escolha");

    console.clearScreen();

    if (escolhaConvertida != null &&
        (escolhaConvertida < 10 && escolhaConvertida > 0)) {
      bool valido =
          jogada(caracterJogando: caracterAtual, numero: escolhaConvertida);
      if (valido == true) {
        verificaGanhador(jogadorAgr: jogador);

        if (temosVencedor == false) {
          verificaVelha();
          alternarJogada = !alternarJogada;
          alternarJogador = !alternarJogador;
        }
      }
    } else {
      print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
      print("SEU ANIMAL COLOCA A POHA DO BGLHO CERTO!!!!");
      print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
    }
  }
}

///DEFINE O VALOR DA JOGADA EM NOSSA MATRIZ E NA TABELA DE APRESENTACAO
bool jogada({int numero, String caracterJogando}) {
  switch (numero) {
    case 1:
      if (matriz[0][0] != caracter1 && matriz[0][0] != caracter2) {
        matriz[0][0] = caracterJogando;
        tabuleiro = tabuleiro.replaceAll("1", caracterJogando);
        return true;
      } else {
        return false;
      }
      break;

    case 2:
      if (matriz[0][1] != caracter1 && matriz[0][1] != caracter2) {
        matriz[0][1] = caracterJogando;
        tabuleiro = tabuleiro.replaceAll("2", caracterJogando);
        return true;
      } else {
        return false;
      }
      break;

    case 3:
      if (matriz[0][2] != caracter1 && matriz[0][2] != caracter2) {
        matriz[0][2] = caracterJogando;
        tabuleiro = tabuleiro.replaceAll("3", caracterJogando);
        return true;
      } else {
        return false;
      }
      break;

    case 4:
      if (matriz[1][0] != caracter1 && matriz[1][0] != caracter2) {
        matriz[1][0] = caracterJogando;
        tabuleiro = tabuleiro.replaceAll("4", caracterJogando);
        return true;
      } else {
        return false;
      }
      break;

    case 5:
      if (matriz[1][1] != caracter1 && matriz[1][1] != caracter2) {
        matriz[1][1] = caracterJogando;
        tabuleiro = tabuleiro.replaceAll("5", caracterJogando);
        return true;
      } else {
        return false;
      }
      break;

    case 6:
      if (matriz[1][2] != caracter1 && matriz[1][2] != caracter2) {
        matriz[1][2] = caracterJogando;
        tabuleiro = tabuleiro.replaceAll("6", caracterJogando);
        return true;
      } else {
        return false;
      }
      break;

    case 7:
      if (matriz[2][0] != caracter1 && matriz[2][0] != caracter2) {
        matriz[2][0] = caracterJogando;
        tabuleiro = tabuleiro.replaceAll("7", caracterJogando);
        return true;
      } else {
        return false;
      }
      break;

    case 8:
      if (matriz[2][1] != caracter1 && matriz[2][1] != caracter2) {
        matriz[2][1] = caracterJogando;
        tabuleiro = tabuleiro.replaceAll("8", caracterJogando);
        return true;
      } else {
        return false;
      }
      break;

    case 9:
      if (matriz[2][2] != caracter1 && matriz[2][2] != caracter2) {
        matriz[2][2] = caracterJogando;
        tabuleiro = tabuleiro.replaceAll("9", caracterJogando);
        return true;
      } else {
        return false;
      }
      break;

    default:
      return false;
      break;
  }
}

/// VERIFICA SE OUVE GANHARDOR, SE POSITIVO PRINTA O GANHADOR MAS SE NEGATIVO NAO PRINTA NADA
void verificaGanhador({String jogadorAgr}) {
// linha horizontal
  if (matriz[0][0] == matriz[0][1] && matriz[0][1] == matriz[0][2]) {
    temosVencedor = true;
  } else if (matriz[1][0] == matriz[1][1] && matriz[1][1] == matriz[1][2]) {
    temosVencedor = true;
  } else if (matriz[2][0] == matriz[2][1] && matriz[2][1] == matriz[2][2]) {
    temosVencedor = true;
  }
  // linha vertical
  else if (matriz[0][0] == matriz[1][0] && matriz[1][0] == matriz[2][0]) {
    temosVencedor = true;
  } else if (matriz[0][1] == matriz[1][1] && matriz[1][1] == matriz[2][1]) {
    temosVencedor = true;
  } else if (matriz[0][2] == matriz[1][2] && matriz[1][2] == matriz[2][2]) {
    temosVencedor = true;
  }
  // diagonais
  else if (matriz[0][0] == matriz[1][1] && matriz[1][1] == matriz[2][2]) {
    temosVencedor = true;
  } else if (matriz[0][2] == matriz[1][1] && matriz[1][1] == matriz[2][0]) {
    temosVencedor = true;
  }

  if (temosVencedor == true) {
    printarTabuleiro();
    print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
    print("Parabens $jogadorAgr voce ganhou!!!");
    print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
    if (jogadorAgr == nome1) {
      pontuacaoJogador1 += 1;
    } else {
      pontuacaoJogador2 += 1;
    }
    jogarDenovo();
  }
}

// se todas as posicoes foram modificadas e nao tivemos ganhador, temos uma VELHA
/// VERIFICA SE TODAS POSICOES FORAM MODIFICADAS E NAO TIVERAM GANHADOR SE POSITIVO TEMOS VELHA
void verificaVelha() {
  for (int i = 0; i < matriz.length; i++) {
    for (int j = 0; j < matriz[i].length; j++) {
      var res = int.tryParse(matriz[i][j].toString());
      if (res != null) {
        // Não deu velha
        return;
      }
    }
  }
// VERSÃO
  print(tabuleiro);
  // TODO melhorar mensagem de deu velha
  print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
  print(
      "DEU VELHA:\nDILMA:\nNAO ACHO QUE QUEM GANHAR OU QUEM PERDER,\nNEM QUEM GANHAR NEM PERDER,\nVAI GANHAR OU PERDER.\nVAI TODO MUNDO PERDER!!!");
  print("+-=--=--=--=--=--=--=--=--=--=--=--=--=--=+");
  temosVelha = true;

  jogarDenovo();
}

void jogarDenovo() {
  print("Voces gostariam de jogar denovo? (S/N)");
  String jogarDenovo = stdin.readLineSync().toUpperCase();
  if (jogarDenovo == "S") {
    temosVencedor = false;
    temosVelha = false;
    tabuleiro = tabuleiroRefresh;
    matriz = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9]
    ];
  }
  console.clearScreen();
}

void printarTabuleiro() {
  print(tabuleiro);
  rodape = rodapeRefresh;
  rodape = rodape.replaceAll("pt1", pontuacaoJogador1.toString());
  rodape = rodape.replaceAll("pt2", pontuacaoJogador2.toString());
  print(rodape);
}
