setup:
	curl -Lk http://b.globe.com/graphic-template > temp.zip
	unzip -q temp.zip
	mv globe-graphic-template-master/* .
	rm -rf temp.zip globe-graphic-template-master LICENSE README.md
	@echo "\n-- HARD CODE, HARD NEWS! --\n"

setup-awesome:
	@echo "\n-- THIS WILL TAKE A MOMENT... --\n"
	curl -Lk https://github.com/russellgoldenberg/globe-graphic-tasks/archive/master.zip > temp.zip
	unzip -q temp.zip
	rm -rf globe-graphic-tasks-master/README.md
	mv globe-graphic-tasks-master/copy.json src/data
	mv globe-graphic-tasks-master/* .
	mv globe-graphic-tasks-master/.jshintrc .
	mv globe-graphic-tasks-master/.gitignore .
	mv css/* src/css
	unzip -q node_modules.zip
	rm -rf temp.zip globe-graphic-tasks-master css node_modules.zip
	
setup-app:
	curl -Lk https://github.com/russellgoldenberg/globe-graphic-app/archive/master.zip > temp.zip
	unzip -q temp.zip
	mv globe-graphic-app-master/html src/html
	mv globe-graphic-app-master/gulp-tasks/* gulp-tasks
	mv globe-graphic-app-master/util src/js/util
	mv globe-graphic-app-master/README.md .
	rm -rf temp.zip globe-graphic-app-master
	rm -rf embed-test.html embed.jpt src/index.html

done:
	@echo "\n-- GET TO WORK. RUN "gulp". --\n"

awesome: setup-awesome done

app: setup-awesome setup-app done