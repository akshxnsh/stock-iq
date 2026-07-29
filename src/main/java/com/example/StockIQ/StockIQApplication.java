package com.example.StockIQ;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication(scanBasePackages = {"com.example.StockIQ", "com.stockiq"})
public class StockIQApplication {

	public static void main(String[] args) {
		SpringApplication.run(StockIQApplication.class, args);
	}

}
