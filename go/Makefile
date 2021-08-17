all: isuumo

isuumo: FORCE
	GOOS=linux GOARCH=amd64 go build -o isuumo
	scp isuumo isucon1:~/

FORCE:
.PHONY: FORCE
