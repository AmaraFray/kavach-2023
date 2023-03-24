from flask import Flask #==
from flask_cors import CORS #==
import webscraping as ws

def main():
  ws.scrape
  

app = Flask(__name__) #==
CORS(app) #==

@app.route("/") #==
def forbidden(): #==
  return "Server is online" #==


if __name__ == "__main__": #== 
  app.run(host='0.0.0.0', port=81) #==
  main()
