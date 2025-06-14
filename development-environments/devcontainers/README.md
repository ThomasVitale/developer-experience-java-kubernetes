# Development Environment: Devcontainers

With [Devcontainers](https://flox.dev) you can "use a container as a full-featured development environment".

## Install Devcontainer CLI (Optional)

Follow the [instructions](https://code.visualstudio.com/docs/devcontainers/devcontainer-cli) to install the Devcontainer CLI on your machine. On macOS, you can install it from [Homebrew](https://brew.sh):

```shell
brew install devcontainer
```

## Activate Environment (CLI)

Navigate to this folder and activate the development environment using the Devcontainer CLI:

```shell
devcontainer up --workspace-folder . --docker-path /opt/podman/bin/podman
```

You can now run commands inside the development environment.

```shell
devcontainer exec --workspace-folder . java -version
```

## Activate Environment (VS Code)

Navigate to this folder and open the project in Visual Studio Code:

```shell
code .
```

Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac).

Type and select: "Dev Containers: Reopen in Container"

You're now working inside your brand new development environment!

## Use Environment

The development environment for this project installs and configures Java 24 and httpie. All those packages are dedicated to this environment.

Go ahead and run the Spring Boot application in development mode:

```shell
./gradlew bootRun
```

When you're done working with this environment, you can exit by running this command:

```shell
exit
```
