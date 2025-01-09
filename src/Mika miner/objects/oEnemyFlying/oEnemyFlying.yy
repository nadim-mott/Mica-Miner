{
  "resourceType": "GMObject",
  "resourceVersion": "1.0",
  "name": "oEnemyFlying",
  "eventList": [
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":3,"isDnD":false,},
    {"resourceType":"GMEvent","resourceVersion":"1.0","name":"","collisionObjectId":null,"eventNum":0,"eventType":0,"isDnD":false,},
  ],
  "managed": true,
  "overriddenProperties": [
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"oEnemy","path":"objects/oEnemy/oEnemy.yy",},"propertyId":{"name":"health_point","path":"objects/oEnemy/oEnemy.yy",},"value":"3",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"oEnemy","path":"objects/oEnemy/oEnemy.yy",},"propertyId":{"name":"default_sprite","path":"objects/oEnemy/oEnemy.yy",},"value":"sFlyingEnemy",},
    {"resourceType":"GMOverriddenProperty","resourceVersion":"1.0","name":"","objectId":{"name":"oEnemy","path":"objects/oEnemy/oEnemy.yy",},"propertyId":{"name":"hurt_sprite","path":"objects/oEnemy/oEnemy.yy",},"value":"sFlyingEnemyHurt",},
  ],
  "parent": {
    "name": "Objects",
    "path": "folders/Objects.yy",
  },
  "parentObjectId": {
    "name": "oEnemy",
    "path": "objects/oEnemy/oEnemy.yy",
  },
  "persistent": false,
  "physicsAngularDamping": 0.1,
  "physicsDensity": 0.5,
  "physicsFriction": 0.2,
  "physicsGroup": 1,
  "physicsKinematic": false,
  "physicsLinearDamping": 0.1,
  "physicsObject": false,
  "physicsRestitution": 0.1,
  "physicsSensor": false,
  "physicsShape": 1,
  "physicsShapePoints": [],
  "physicsStartAwake": true,
  "properties": [
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"spd","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"2","varType":0,},
    {"resourceType":"GMObjectProperty","resourceVersion":"1.0","name":"activation_distance","filters":[],"listItems":[],"multiselect":false,"rangeEnabled":false,"rangeMax":10.0,"rangeMin":0.0,"value":"200","varType":0,},
  ],
  "solid": false,
  "spriteId": {
    "name": "sFlyingEnemy",
    "path": "sprites/sFlyingEnemy/sFlyingEnemy.yy",
  },
  "spriteMaskId": null,
  "visible": true,
}