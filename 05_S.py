

dummy = {
    "xx":[(12.4,24.435)], 
    "xy":[(52.4,24.935)],
    "yy":[(53.4,24.935),(23.4567,34.46)]
}
def dangerscore(i,j, user_geohash):
    if user_geohash not in dummy:
        return 0 
    pts = dummy[user_geohash]
    acc = 0
    for lat, lon in pts:
        acc+= ((lat-i)**2+(lon-j)**2)**(1/2)
    return acc/len(pts) 
print(dangerscore(23.34434,89.857858, "xy"))
