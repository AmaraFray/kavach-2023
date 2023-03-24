from flask import Flask #==
from flask_cors import CORS #==
import random
import math

app = Flask(__name__) #==
CORS(app) #==


def winConditions(board):
  winState = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8],
              [0, 4, 8], [2, 4, 6]]
  for winPosition in winState:
    if board[winPosition[0]] == board[winPosition[1]] == board[
        winPosition[2]] and board[winPosition[0]] != '':
      return board[winPosition[0]] + ' wins!!'
  for position in board:
    if position == '':
      return False
  return 'Tie!'


possibleMoves = lambda board: [i for i in range(len(board)) if board[i]=='']

def gameOverState(board,prioritySign):
    winState = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]
    for winPosition in winState:
        if board[winPosition[0]] == board[winPosition[1]] == board[winPosition[2]] and board[winPosition[0]] != '':
            if board[winPosition[0]] == prioritySign[0]:
                return 1
            else:
                return -1
    for position in board:
        if position == '':
            return None
    return 0



def miniMax(board, maxMove,returnMove=False,prioritySign=['O','X']):
    if gameOverState(board,prioritySign) != None:
        return gameOverState(board,prioritySign)
    if maxMove:
        bestScore = -math.inf
        bestMove = None
        for move in possibleMoves(board):
            board[move] = prioritySign[0]
            score = miniMax(board, False,prioritySign=prioritySign)
            board[move] = ''
            if score > bestScore:
                bestScore = score
                bestMove = move
            if score == 1:
                break
        if returnMove:
            return bestMove
        return bestScore
    else:
        bestScore = math.inf
        bestMove = None
        for move in possibleMoves(board):
            board[move] = prioritySign[1]
            score = miniMax(board, True,prioritySign=prioritySign)
            board[move] = ''
            if score < bestScore:
                bestScore = score
                bestMove = move
            if score == -1:
                break
        return bestScore


@app.route("/") #==
def forbidden(): #==
  return "Server is online" #==


@app.route("/<num>")
def dumbBot(num):
  botMove = 'O'
  dictTransfer = {'0': '', '1': 'X', '2': 'O'}
  board = [dictTransfer[i] for i in str(num)]
  possibleMoves = [i for i in range(len(board)) if board[i] == '']

  winVerified = winConditions(board)
  if winVerified == False:
    answer = random.choice(possibleMoves)
    board[answer] = botMove
    value = [answer // 3, answer % 3]
    if winConditions(board) != False:
      return str(value[0]) + str(value[1]) + winConditions(board)

    return str(value[0]) + str(value[1])
  return winVerified

# app.route()
@app.route("/ai/<num>")
def smartBot(num):
  return "Hello"

@app.route("/accelerometer/<value>")
def reference(value):
  return value*4

if __name__ == "__main__": #== 
  app.run(host='0.0.0.0', port=81) #==
