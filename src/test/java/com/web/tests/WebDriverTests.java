package com.web.tests;

import java.util.concurrent.TimeUnit;

import org.junit.jupiter.api.AfterAll;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.chrome.ChromeDriver;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.github.bonigarcia.wdm.WebDriverManager;

public class WebDriverTests {
	
	public final Logger log = LoggerFactory.getLogger(WebDriverTests.class);

	static WebDriver driver;
	
	static String url="http://localhost:2000/capstone";
	
    @BeforeAll
	public static void openBrowser() {  
    	//System.setProperty("webdriver.ie.driver", "C:\\ws\\drivers\\IEDriverServer.exe");
        //driver=new InternetExplorerDriver();    	
		WebDriverManager.chromedriver().setup();
    	//System.setProperty("webdriver.chrome.driver", "C:\\ws\\drivers\\chromedriver.exe");        
		driver = new ChromeDriver();		 
        driver.manage().window().maximize();
        driver.manage().timeouts().implicitlyWait(30, TimeUnit.SECONDS);
        
    }
    
    @BeforeEach
    void init() {
        log.info("@BeforeEach - executes before each test method in this class");
    }
	
	@Test
	@Disabled("for demonstration purposes")
	public void login() throws InterruptedException {
		driver.get(url+"/login");
		driver.findElement(By.id("user")).sendKeys("kenn.juma@yahoo.com");
		//Thread.sleep(3000);
		driver.findElement(By.id("pwd")).sendKeys("password");
	    //Thread.sleep(3000);
	    driver.findElement(By.id("submiter")).click(); 
	    Thread.sleep(3000);
	    driver.getPageSource().contains("Profile");
	    driver.findElement(By.id("logout_link")).click();
	    driver.getPageSource().contains("You have been logged out");
	    Thread.sleep(3000);
	}
	
	@Test
	@DisplayName("Test google search")
	//@Disabled("for demonstration purposes")
	public void google() throws InterruptedException {
		driver.get("https://www.google.com/");
		Thread.sleep(300);
	}
	
	@Test
	@Disabled("for demonstration purposes")
	public void testheader() throws InterruptedException {
		testlink("index");
		
		Thread.sleep(30);
		testlink("about");
		Thread.sleep(30);
		testlink("services");
		Thread.sleep(30);		
		testlink("contact");
		Thread.sleep(30);
		testlink("login");
		Thread.sleep(30);
		testlink("register");
		Thread.sleep(30);
	}
		
	public synchronized void testlink(String page) throws InterruptedException {		
		driver.get("http://localhost:2000/capstone/"+page+"");
		driver.findElement(By.id("_index")).click();
		driver.findElement(By.id("_about")).click();
		driver.findElement(By.id("_services")).click();
		driver.findElement(By.id("_contact")).click();
		driver.findElement(By.id("_login")).click();
		driver.findElement(By.id("_register")).click();
		
		Thread.sleep(300);
		
	}
	
	@Test
	@Disabled("for demonstration purposes")
	public void testEmail() {
		driver.get(url+"/contact");
		driver.findElement(By.id("name")).sendKeys("George Omollo");
		driver.findElement(By.id("email")).sendKeys("xxxxx@gmail.com");
		driver.findElement(By.id("subject")).sendKeys("WebDriver Test Email");
		driver.findElement(By.id("msg")).sendKeys("This is atest for Web Driver");		
		driver.findElement(By.id("send")).click(); 
		
	}
	
	@AfterAll
	public static void closeBrowser() {		
		driver.quit();
	}
	
	
	
}
