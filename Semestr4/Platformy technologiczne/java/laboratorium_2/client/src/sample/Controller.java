package sample;

import java.io.File;
import java.io.Serializable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import javafx.concurrent.Task;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.ProgressBar;
import javafx.stage.FileChooser;
import javafx.stage.Window;

public class Controller implements Serializable {
    @FXML
    private Label statusLabel;
    @FXML
    private ProgressBar progressBar;
    private ExecutorService executorService = Executors.newSingleThreadExecutor();

    public Controller() {
    }

    @FXML
    private void handleButtonAction(ActionEvent event) {
        File file = (new FileChooser()).showOpenDialog((Window)null);
        if (file != null) {
            Task<Void> sendFileTask = new SendFileTask(file);
            this.statusLabel.textProperty().bind(sendFileTask.messageProperty());
            this.progressBar.progressProperty().bind(sendFileTask.progressProperty());
            this.executorService.submit(sendFileTask);
        }
    }
}
