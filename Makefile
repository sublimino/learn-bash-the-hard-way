CHAPTERS:=$(shell ls -d asciidoc/[1-9]*)
OUTPUT_DIR:=$(shell pwd)/output
DEPLOY_DIR:=/var/www/html/learnbashthehardway
BOOK_NAME:=learnbashthehardway

include makefiles/Makefile.constants

.PHONY: chapters $(CHAPTERS) deploy docker

chapters: $(CHAPTERS) 

$(CHAPTERS):
	$(MAKE) -C $@

all: clean chapters deploy

ifeq ($(shell hostname),rothko)

deploy: chapters $(DEPLOY_DIR)

$(DEPLOY_DIR): FORCE
	cp -R output/9999.learnbashthehardway.pdf output/learnbashthehardway.pdf
	cp -R output/learnbashthehardway.pdf learnbashthehardway.pdf
	cp -R output/* $(DEPLOY_DIR)

FORCE:

else
deploy:
	$(error not on rothko)
endif

docker: clean
	docker build --no-cache .

clean:
	rm -rf $(OUTPUT_DIR)/* $(DEPLOY_DIR)/*
