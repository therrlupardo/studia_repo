cd src/sample
del "*.class"
javac *.java
move *.class ../../out/production/client/sample
copy *.fxml ..\..\out\production\client\sample
cd ../..
cd out/production/client
cls
java sample.Main