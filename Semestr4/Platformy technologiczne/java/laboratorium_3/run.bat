cd src/sample
javac *.java
move *.class "../../out/production/MultipleGraphicEditor/sample"
copy *.fxml "..\..\out\production\MultipleGraphicEditor\sample"
cd ../../out/production/MultipleGraphicEditor
java sample.Main