# Development Environment: Flox

With [Flox](https://flox.dev) you can "create development environments with all the dependencies you need and easily share them with colleagues".

## Install Flox

Follow the [instructions](https://flox.dev/docs/install-flox/) to install Flox on your machine. On macOS, you can install it from [Homebrew](https://brew.sh):

```shell
brew install flox
```

## Activate Environment

Navigate to this folder and activate the development environment with Flox:

```shell
flox activate
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

If you want to control your Flox environments from Visual Studio Code, try out the dedicated [extension](https://marketplace.visualstudio.com/items?itemName=flox.flox).
