start-casdoor:
	cd ./hack/casdoor && docker-compose up -d

down-casdoor:
	cd ./hack/casdoor && docker-compose down

mycli:
	mycli mysql://root:""JKGgWFf9XTW+FRhamg+T2Xht8e9S12MK""@localhost:3306/casdoor

dumpsql:
	@docker exec casdoor-mysql-1 sh -c 'exec mysqldump -uroot -p"JKGgWFf9XTW+FRhamg+T2Xht8e9S12MK" casdoor > /docker-entrypoint-initdb.d/casdoor.sql'

casdoor_isup:
	@sh ./hack/casdoor/isup.sh

ut: casdoor_isup
	@docker exec -it casdoor-flutter-1 bash -c 'flutter pub get && flutter test --dart-define=CAS_SERVER=http://casdoor:8000'
