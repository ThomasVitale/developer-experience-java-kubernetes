package com.thomasvitale.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.servlet.function.RouterFunction;
import org.springframework.web.servlet.function.RouterFunctions;
import org.springframework.web.servlet.function.ServerResponse;

import java.util.List;

@SpringBootApplication
public class DemoApplication {

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	@Bean
	RouterFunction<ServerResponse> routerFunction() {
		return RouterFunctions.route()
			.GET("/", _ -> ServerResponse.ok().body("Welcome to the BookService!"))
			.GET("/books", _ -> ServerResponse.ok().body(List.of(
				new Book("The Hobbit"),
				new Book("The Lord of the Rings"),
				new Book("His Dark Materials")
			)))
			.build();
	}

}

record Book(String title){}
