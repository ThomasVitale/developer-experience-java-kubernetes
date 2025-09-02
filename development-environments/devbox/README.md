# Development Environment: Devbox

With [Devbox](https://www.jetify.com/devbox) you can create "isolated, reproducible development environments that run anywhere.".

## Install Devbox

Follow the [instructions](https://www.jetify.com/docs/devbox/installing_devbox/) to install Devbox on your machine.

## Activate Environment

Navigate to this folder and activate the development environment with Devbox:

```shell
devbox shell
```

You're now working inside your brand new development environment!

## Use Environment

The development environment for this project installs and configures Java 24, the Arconia CLI, and httpie. All those packages are dedicated to this environment.

For example, you can verify that the Arconia CLI is part of the environment and not installed globally:

```shell
which arconia
```

Go ahead and run the Spring Boot application in development mode:

```shell
arconia dev
```

When you're done working with this environment, you can exit by running this command:

```shell
exit
```

## Visual Studio Code

After activating the environment with Flox, you can open the project with Visual Studio Code, which will run in the context of your environment:

```shell
code .
```
