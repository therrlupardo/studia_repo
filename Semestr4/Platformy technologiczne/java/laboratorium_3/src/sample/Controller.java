package sample;

import java.io.File;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.TimeUnit;

import javafx.application.Platform;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.Button;
import javafx.scene.control.ChoiceBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.cell.ProgressBarTableCell;
import javafx.scene.layout.VBox;
import javafx.stage.DirectoryChooser;
import javafx.stage.FileChooser;
import javafx.stage.Window;
import javafx.geometry.Insets;
import javafx.scene.Node;
import javafx.scene.control.Label;
import javafx.scene.control.TableView;

public class Controller implements Initializable {

    @FXML
    Button threadsButton;
    @FXML
    Button selectFilesButton;
    @FXML
    Button selectDirectoryButton;

    @FXML
    Label statusLabel;
    @FXML
    TableView<ImageProcessingJob> imagesTableView;
    @FXML
    TableColumn<ImageProcessingJob, String> imageNameColumn;
    @FXML
    TableColumn<ImageProcessingJob, Double> progressColumn;
    @FXML
    TableColumn<ImageProcessingJob, String> statusColumn;

    private File chosenDir = null;
    private ObservableList<ImageProcessingJob> jobs;
    private int selectedThreadingModel = 0;
    private ExecutorService executorService = Executors.newSingleThreadExecutor();

    @Override
    public void initialize(URL url, ResourceBundle rb) {
        imageNameColumn.setCellValueFactory(p -> new SimpleStringProperty(p.getValue().getFile().getName()));
        statusColumn.setCellValueFactory(p -> p.getValue().messageProperty());
        progressColumn.setCellFactory(ProgressBarTableCell.forTableColumn());
        progressColumn.setCellValueFactory(p -> p.getValue().progressProperty().asObject()); // */

        jobs = FXCollections.observableList(new ArrayList<>());
        imagesTableView.setItems(jobs);
    }

    @FXML
    private void toggleThreads(ActionEvent event) {
        selectedThreadingModel = 0;
        ChoiceBox<String> threadingModel = new ChoiceBox<>(
                FXCollections.observableArrayList(
                        "1 thread",
                        "2 threads",
                        "4 threads",
                        "8 threads",
                        "Common thread pool"
                )
        );

        threadingModel.getSelectionModel().selectFirst();
        threadingModel.setPrefWidth(300);
        threadingModel.setMinWidth(300);

        VBox box = new VBox();
        box.getChildren().add(threadingModel);
        box.setPrefWidth(320);
        box.setMinWidth(320);
        box.setPadding(new Insets(10, 10, 10, 10));

        Alert alert = new Alert(AlertType.CONFIRMATION);
        alert.setHeaderText("Pick the threading model below.");
        alert.getDialogPane().setContent(box);
        alert.showAndWait();

        selectedThreadingModel = threadingModel.getSelectionModel().getSelectedIndex();
        reloadExecutor();
    }

    @FXML
    private void selectSourceFiles(ActionEvent event) {
        Window stage = ((Node) event.getSource()).getScene().getWindow();
        FileChooser fileChooser = new FileChooser();
        fileChooser.getExtensionFilters().add(
                new FileChooser.ExtensionFilter("JPG images", "*.jpg")
        );

        List<File> selectedFiles = fileChooser.showOpenMultipleDialog(stage);

        if (selectedFiles == null) return;
        else if (selectedFiles.isEmpty()) return;

        jobs.clear();
        selectedFiles.forEach(file -> jobs.add(new ImageProcessingJob(file)));
    }

    @FXML
    private void selectTargetDirectory(ActionEvent event) {
        if (jobs.isEmpty()) {
            Alert alert = new Alert(AlertType.ERROR);
            alert.setHeaderText("Warning!");
            alert.setContentText("You have to choose files first!");
            alert.showAndWait();
            return;
        }

        Window stage = ((Node) event.getSource()).getScene().getWindow();
        chosenDir = new DirectoryChooser().showDialog(stage);
        if (!(chosenDir == null)) {
            new Thread(this::processImages).start();
        }
    }

    private void processImages() {
        long startTime = System.currentTimeMillis();
        Platform.runLater(() -> {
            disableButtons(true);
            statusLabel.setText("Converting...");
        });


        jobs.forEach(job -> {
            job.setTargetDirectory(chosenDir);
            executorService.submit(job);
        });

        try {
            executorService.shutdown();
            executorService.awaitTermination(1, TimeUnit.MINUTES);

            long duration = System.currentTimeMillis() - startTime;
            Platform.runLater(() -> {
                statusLabel.setText("Conversion time: " + duration + " ms");
                disableButtons(false);
                reloadExecutor();
            });


        } catch (InterruptedException e) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setHeaderText("Warning!");
            alert.setContentText("Time out! Choose less files!");
            alert.showAndWait();

            Platform.runLater(() -> statusLabel.setText("ERROR!"));
        }
    }

    private void disableButtons(boolean toggle) {
        threadsButton.setDisable(toggle);
        selectFilesButton.setDisable(toggle);
        selectDirectoryButton.setDisable(toggle);
    }

    private void reloadExecutor() {
        switch (selectedThreadingModel) {
            case 0:
                threadsButton.setText("Threads: 1");
                executorService = Executors.newSingleThreadExecutor();
                break;
            case 1:
                threadsButton.setText("Threads: 2");
                executorService = Executors.newFixedThreadPool(2);
                break;
            case 2:
                threadsButton.setText("Threads: 4");
                executorService = Executors.newFixedThreadPool(4);
                break;
            case 3:
                threadsButton.setText("Threads: 8");
                executorService = Executors.newFixedThreadPool(8);
                break;
            case 4:
                threadsButton.setText("Threads: Common Pool");
                executorService = new ForkJoinPool();
                break;
        }
    }
}
