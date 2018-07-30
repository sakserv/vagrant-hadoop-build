## Starting and Stopping Apps

Create app:
```
curl -H "Content-Type: application/json" -X POST http://y7001.yns.example.com:9191/ws/v1/services -d @/vagrant/apps/ready1.json
```
OR
```
yarn service create --file /vagrant/apps/ready1.json
```

Delete app:
```
curl -X DELETE http://y7001.yns.example.com:9191/ws/v1/services/ready-app-1
```
OR
```
yarn service stop ready-app-1
yarn service destroy ready-app-1
```
