package sample;

import java.awt.Color;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;

import javafx.application.Platform;
import javafx.concurrent.Task;

import javax.imageio.ImageIO;

public class ImageProcessingJob extends Task<Void> {
    private File sourceFile;
    private File targetDirectory;

    ImageProcessingJob(File file) {
        sourceFile = file;
        targetDirectory = null;

        updateMessage("Waiting");
    }

    File getFile() {
        return sourceFile;
    }

    void setTargetDirectory(File targetDirectory) {
        this.targetDirectory = targetDirectory;
    }

    @Override
    protected Void call() {
        if (targetDirectory == null) {
            updateMessage("Please specify target directory!");
            return null;
        } else if (sourceFile == null) {
            updateMessage("Please choose files to convert!");
            return null;
        }

        updateMessage("Working...");
        updateProgress(0, 1);

        try {
            BufferedImage original = ImageIO.read(sourceFile);
            BufferedImage greyscale = new BufferedImage(
                    original.getWidth(),
                    original.getHeight(),
                    original.getType()
            );

            convertToGreyscale(original, greyscale);

            Path outputPath = Paths.get(
                    targetDirectory.getAbsolutePath(),
                    sourceFile.getName()
            );

            ImageIO.write(greyscale, "jpg", outputPath.toFile());
        } catch (IOException ex) {
            updateMessage("Error!");
            throw new RuntimeException(ex);
        }

        updateMessage("Converted");
        return null;
    }

    private void convertToGreyscale(BufferedImage original, BufferedImage greyscale) {
        for (int i = 0; i < original.getWidth(); i++) {
            for (int j = 0; j < original.getHeight(); j++) {
                int red = new Color(original.getRGB(i, j)).getRed();
                int green = new Color(original.getRGB(i, j)).getGreen();
                int blue = new Color(original.getRGB(i, j)).getBlue();

                int luminosity = (int) (0.21 * red + 0.72 * green + 0.07 * blue);

                int newPixel = new Color(luminosity, luminosity, luminosity).getRGB();

                greyscale.setRGB(i, j, newPixel);
            }

            double curProgress = (1.0 + i) / original.getWidth();
            Platform.runLater(() -> updateProgress(curProgress, 1));
        }
    }
}
