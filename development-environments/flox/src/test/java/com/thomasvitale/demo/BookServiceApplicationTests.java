package com.thomasvitale.demo;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.test.web.reactive.server.WebTestClient;

@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class DemoApplicationTests {

	@Autowired
	WebTestClient webTestClient;

	@Test
	void whenRootThenWelcomeMessage() {
		webTestClient
			.get()
			.uri("/")
			.exchange()
			.expectStatus().isOk()
			.expectBody(String.class).isEqualTo("Welcome to the BookService!");
	}

	@Test
	void whenGetBooksThenReturnList() {
		webTestClient
			.get()
			.uri("/books")
			.exchange()
			.expectStatus().isOk()
			.expectBodyList(Book.class).hasSize(3);
	}

}
