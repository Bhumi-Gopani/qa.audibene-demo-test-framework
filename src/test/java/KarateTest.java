import static org.junit.jupiter.api.Assertions.*;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import java.io.File;
import java.util.*;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.junit.jupiter.api.Test;

class KarateTest {

  @Test
  void runKarateTests() {
    Results results =
        Runner.path("classpath:tests/sample.feature")
            .outputCucumberJson(true)
            .reportDir("target/karate-reports/api")
            .parallel(1);

    System.out.println("✅ API Test Report Dir: " + results.getReportDir());
    listOutputFiles(results.getReportDir());

    generateReport(results.getReportDir(), "Karate API Tests", "target/cucumber-reports/api");
    assertEquals(0, results.getFailCount(), results.getErrorMessages());
  }

  @Test
  void runKarateUITests() {
    Results results =
        Runner.path("classpath:ui/google.feature")
            .outputCucumberJson(true)
            .reportDir("target/karate-reports/ui")
            .parallel(1);

    System.out.println("✅ UI Test Report Dir: " + results.getReportDir());
    listOutputFiles(results.getReportDir());

    generateReport(results.getReportDir(), "Karate UI Tests", "target/cucumber-reports/ui");
    assertEquals(0, results.getFailCount(), results.getErrorMessages());
  }

  private void listOutputFiles(String dirPath) {
    File[] allFiles = new File(dirPath).listFiles();
    System.out.println("📂 Files in output dir:");
    if (allFiles != null) {
      for (File f : allFiles) {
        System.out.println(" -> " + f.getName());
      }
    }
  }

  private void generateReport(String karateOutputPath, String projectName, String htmlOutputPath) {
    File reportOutputDirectory = new File(htmlOutputPath);
    Collection<File> jsonFiles =
        org.apache.commons.io.FileUtils.listFiles(
            new File(karateOutputPath), new String[] {"json"}, true);

    if (jsonFiles.isEmpty()) {
      throw new RuntimeException("❌ No JSON files found at: " + karateOutputPath);
    }

    List<String> jsonPaths = new ArrayList<>();
    for (File file : jsonFiles) {
      jsonPaths.add(file.getAbsolutePath());
    }

    Configuration config = new Configuration(reportOutputDirectory, projectName);
    ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
    reportBuilder.generateReports();

    System.out.println("✅ HTML Report generated at: " + htmlOutputPath + "/feature-overview.html");
  }
}
