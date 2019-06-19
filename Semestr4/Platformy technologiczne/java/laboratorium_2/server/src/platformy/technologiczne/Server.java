package platformy.technologiczne;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Server {

    private static int port = 1500;

    public static void downloadFile(Socket client) throws IOException{
        String fileName;
        long fileSize;

        try(DataInputStream dataInputStream = new DataInputStream(client.getInputStream())){
            try{
                fileName = dataInputStream.readUTF();
                fileSize = dataInputStream.readLong();
            } catch(IOException e){
                System.out.println("Problem with reading file, client will shut down.");
                client.close();
                return;
            }

            File file = new File(".", fileName);
            System.out.println("Downloading file: "+ fileName + " from " + client.getInetAddress().toString());

            file.createNewFile();
            FileOutputStream fileOutputStream = new FileOutputStream(file);
            try {
                int downloaded = 0, tmp = 0;
                byte[] buffer = new byte[512];

                while(downloaded < fileSize){
                    tmp = dataInputStream.read(buffer);
                    if(tmp != -1) downloaded += tmp;
                    else throw new IOException("Problem with downloading file!");

                    fileOutputStream.write(buffer, 0, tmp);
                }

                System.out.println("Download of " + fileName + " finished successfully!");
                fileOutputStream.close();
            } catch(IOException e){
                System.out.println("Error caught while reading " + fileName + ": " + e.getMessage());

                file.delete();
            } finally{
                client.close();
            }
        }
    }

    public static void main(String[] args) {
        Integer nThreads;
        if (args.length > 0){
            nThreads = Integer.parseInt(args[0]);
        }
        else{
            nThreads = 8;
        }

        System.out.println("Server is running on port " + port + " and able to manage " + nThreads + " clients");
        ExecutorService executorService = Executors.newFixedThreadPool(nThreads);

        try(ServerSocket serverSocket = new ServerSocket(port)){
            while(true){
                try{
                    final Socket socket = serverSocket.accept();
                    executorService.submit(() -> {
                        try{
                            Server.downloadFile(socket);
                        } catch (IOException e){
                           System.out.println("Problem with downloading: " + e.getMessage());
                        }
                    });
                } catch(IOException e){
                    System.out.println("Problem with accepting client. Shutting down.");
                    System.exit(1);
                }

            }
        } catch(IOException e){
            System.out.println("Problem happend!");
            System.exit(1);
        }

    }
}
