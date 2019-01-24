export PROJECT=dSilent
export MYSQL_VERSION=8.0.14
export MYSQL_PASSWORD=dSilent

make:
	pip install -r requirements.txt

run: mysql
	python manage.py runserver

mysql:
	- docker volume create $(PROJECT)-mysql
	- docker rm -f $(PROJECT)-mysql

	docker run \
		-d \
		--name $(PROJECT)-mysql \
		--rm \
		--volume $(PROJECT)-mysql:/var/lib/mysql \
		--env MYSQL_ROOT_PASSWORD=$(MYSQL_PASSWORD) \
		--publish 3306:3306 \
			mysql:$(MYSQL_VERSION)

clean:
	- docker rm -f $(PROJECT)-mysql
	- docker volume rm -f $(PROJECT)-mysql
