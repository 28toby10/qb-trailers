# Working trailers for QBCore
Only the `boattrailer` can be used to tow a boat

## Dependencies:
* qb-core

## Commands:
/attach - To attach a vehicle to the trailer </br>
/detach - To detach a vehicle from the trailer

/opentrunk - For opening the trunk of trailer `tr2` </br>
/closetrunk - For closing the runk of trailer `tr2` </br>
/openramp - To lower the ramp of trailer `tr2` </br>
/closeramp - To raise the ramp of trailer `tr2`

## Config.VehicleCanTrail
```
Config.VehicleCanTrail = {
    {name = 'TRAILER', class = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 22}},
    {name = 'BOBCATXL', class = {8, 13}},     
}
```

## Config.BoatCanTrail
```
Config.BoatCanTrail = {
    {boat = 'DINGHY', position = vector3(0.0, -1.0, 0.35)},
    {boat = 'DINGHY2', position = vector3(0.0, -1.0, 0.35)},
    {boat = 'DINGHY3', position = vector3(0.0, -1.0, 0.35)},
    {boat = 'DINGHY4', position = vector3(0.0, -1.0, 0.35)},
    {boat = 'SEASHARK', position = vector3(0.0, -1.75, 0.05)},
    {boat = 'SEASHARK2', position = vector3(0.0, -1.75, 0.05)},
    {boat = 'SEASHARK3', position = vector3(0.0, -1.75, 0.05)},
    {boat = 'PolitieBoot', position = vector3(0.0, -1.0, 0.5)}
}
```

## Vehicle Classes
```
0: Compacts  
1: Sedans  
2: SUVs  
3: Coupes  
4: Muscle  
5: Sports Classics  
6: Sports  
7: Super  
8: Motorcycles  
9: Off-road  
10: Industrial  
11: Utility  
12: Vans  
13: Cycles  
14: Boats  
15: Helicopters  
16: Planes  
17: Service  
18: Emergency  
19: Military  
20: Commercial  
21: Trains  
22: Open Wheel
```
