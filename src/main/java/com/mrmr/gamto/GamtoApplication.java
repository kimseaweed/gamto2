package com.mrmr.gamto;

import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@Slf4j
public class GamtoApplication {

	public static void main(String[] args) {
		SpringApplication.run(GamtoApplication.class, args);
		log.info("http://localhost:8089");
	}
}
