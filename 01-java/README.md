# 01 - Java

Let's start by defining a baseline for our development experience. We'll use test-driven development and run the application locally on the JVM.

## Basic

Navigate to the `basic` folder.

```shell
cd basic/book-service
```

Implement a new feature using test-driven development. You can run tests with the following command.

```shell
./gradlew test
```

You can run the application on the local JVM as follows.

```shell
./gradlew bootRun
```

## Live Reload

The [Spring Boot Developer Tools](https://docs.spring.io/spring-boot/docs/current/reference/html/using.html#using.devtools) library provides live-reload capabilities when working on the application locally.

Navigate to the `live-reload` folder.

```shell
cd live-reload/book-service
```

Run the application on the local JVM as follows.

```shell
./gradlew bootRun
```

Now, try making some changes to the application (for example, updating the REST API) and save.
Spring Boot Developer Tools will automatically reload the application with the new classes.

If you use Visual Studio Code, the live reload functionality works without any additional configuration. 

If you use IntelliJ IDEA, refer to the [official documentation](https://www.jetbrains.com/help/idea/spring-boot.html#application-update-policies) to enable support for Spring Boot DevTools in the IDE.
