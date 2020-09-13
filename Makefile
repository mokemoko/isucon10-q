all: rotate restart
	sudo tail -f /var/log/nginx/access.log
build: FORCE
	cd go && make
rotate: FORCE
	ssh 10.161.72.102 sudo logrotate -f /etc/logrotate.d/mysql-slow
	ssh 10.161.72.103 sudo logrotate -f /etc/logrotate.d/mysql-slow
	sudo logrotate -f /etc/logrotate.d/nginx
restart: FORCE
	ssh 10.161.72.102 sudo systemctl restart mysql
	ssh 10.161.72.103 sudo systemctl restart mysql
	sudo systemctl restart isuumo.go.service
	sudo systemctl restart nginx
pt: FORCE
	ssh 10.161.72.102 sudo pt-query-digest /var/log/mysql/slow.log
	ssh 10.161.72.103 sudo pt-query-digest /var/log/mysql/slow.log
alp: FORCE
	sudo alp ltsv -c alp.yml
out: FORCE
	./out.sh

FORCE:
.PHONY: FORCE
