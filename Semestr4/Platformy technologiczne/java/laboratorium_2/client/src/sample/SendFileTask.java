
package sample;

import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.Socket;
import javafx.concurrent.Task;

public class SendFileTask extends Task<Void> {
    private File file;

    public SendFileTask(File file) {
        this.file = file;
    }

    protected Void call() throws Exception {
        this.updateMessage("Initiating...");
        this.updateProgress(0L, 100L);

        try {
//            Socket socket = new Socket("172.20.16.121", 5001);
            Socket socket = new Socket("localhost", 1500);
            if (!socket.isConnected()) {
                this.updateMessage("Failed to connect!");
                this.updateProgress(100L, 100L);
                return null;
            }

            DataOutputStream dataOutputStream = new DataOutputStream(socket.getOutputStream());
            Throwable var3 = null;

            try {
                dataOutputStream.writeUTF(this.file.getName());
                dataOutputStream.writeLong(this.file.length());
                long bytesToUpload = this.file.length();
                long bytesRead = 0L;
                this.updateMessage("Uploading ...");
                this.updateProgress(0L, bytesToUpload);
                FileInputStream fileInputStream = new FileInputStream(this.file);
                byte[] buffer = new byte[512];

                while(bytesRead != bytesToUpload) {
                    int read = fileInputStream.read(buffer);
                    dataOutputStream.write(buffer, 0, read);
                    bytesRead += (long)read;
                    this.updateProgress(bytesRead, bytesToUpload);
                }
            } catch (Throwable var19) {
                var3 = var19;
                throw var19;
            } finally {
                if (dataOutputStream != null) {
                    if (var3 != null) {
                        try {
                            dataOutputStream.close();
                        } catch (Throwable var18) {
                            var3.addSuppressed(var18);
                        }
                    } else {
                        dataOutputStream.close();
                    }
                }

            }
        } catch (IOException var21) {
            this.updateMessage("Upload failed!" + var21.getMessage());
        }

        this.updateMessage("File uploaded!");
        this.updateProgress(100L, 100L);
        return null;
    }
}
