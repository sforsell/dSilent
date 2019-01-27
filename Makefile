export PROJECT=dSilent
export MYSQL_VERSION=5.6
export MYSQL_PASSWORD=dSilent
ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))

make:
	pip install -r requirements.txt

run: mysql
	python manage.py runserver

command:
	@ eval $(ARGS)

mysql:
	- docker volume create $(PROJECT)-mysql
	- docker rm -f $(PROJECT)-mysql

	docker run \
		-d \
		--name $(PROJECT)-mysql \
		--volume $(PROJECT)-mysql:/var/lib/mysql \
		-v `pwd`/fsroot/etc/mysql/mysql.conf.d/bind.cnf:/etc/mysql/mysql.conf.d/bind.cnf:ro \
		--env MYSQL_ROOT_PASSWORD=$(MYSQL_PASSWORD) \
		--publish 3306:3306 \
			mysql:$(MYSQL_VERSION)

clean:
	- docker rm -f $(PROJECT)-mysql
	- docker volume rm -f $(PROJECT)-mysql

%:
	@:
