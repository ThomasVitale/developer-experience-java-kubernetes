package com.thomasvitale.musicservice;

import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest.WebEnvironment;
import org.springframework.test.web.reactive.server.WebTestClient;

@SpringBootTest(webEnvironment = WebEnvironment.RANDOM_PORT)
class MusicServiceApplicationTests {

	@Autowired
	WebTestClient webTestClient;

	@Test
	void whenGetThenReturnList() {
		webTestClient
			.get()
			.uri("/")
			.exchange()
			.expectStatus().isOk()
			.expectBodyList(Music.class);
	}

}
