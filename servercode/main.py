from flask import Flask #==
from flask_cors import CORS #==
import webscraping as ws

def main():
  ws.scrape

app = Flask(__name__) #==
CORS(app) #==

@app.route("/") #==
def forbidden(): #==
  return ""

stations = {
  "Thalambur Police Station": (12.846799230605754, 80.22692695845923),
  "Police Out Post-J12 Kanathur Police Station": (12.851893256971142, 80.24215067669039),
  "Gandhinagar Annex-2 Police Station": (12.857810244135718, 80.2136473862531),
  "J-12 Kaanathur, Police Station": (12.825285998634296, 80.24068207888656),
  "semmancheri police station": (12.875843199947656, 80.21380548387084)
}

@app.route("/<long>/<lat>")
def closest_station(long, lat):
  x, y = float(long), float(lat)

  closest = sorted(list(stations.items()), key=lambda s: (s[1][0] - x) ** 2 + (s[1][1] - y) ** 2)
  return {"d": closest}


if __name__ == "__main__": #==
  app.run(host='0.0.0.0', port=81) #==
  main()
