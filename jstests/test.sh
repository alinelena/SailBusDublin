cp ../qml/*.js .
tail -$(($(wc -l state.js | grep -P -o "\d+") - 1)) state.js > temp
echo -e "/*global api: false*/\nvar DublinBus = {api: api};" > state.js
cat temp >> state.js
sed 's/apiBase \= "";/apiBase \= "http:\/\/localhost:4567";/' dublin-bus-api.js  > temp
mv temp dublin-bus-api.js
JSLINTFAILED=$(java -jar jslint4java-2.0.5/jslint4java-2.0.5.jar dublin-bus-api.js state.js tests.js)
if [ -n "$JSLINTFAILED" ]; then
	echo "$JSLINTFAILED"
	echo "JSLint found issues fix before running unit tests"
	exit
fi
ruby ../sinatra-bus.rb -o 0.0.0.0 &
sleep 3
firefox test.html
sleep 10
kill $(ps aux | grep sinatra | grep -P -o "\d+" | head -1)
