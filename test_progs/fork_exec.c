#include <stdio.h>
#include <unistd.h>

int main() {
	pid_t pid = fork();
	if (pid > 0) {
		puts("Hello from the parent process!");
		return 0;
	} else if (pid == 0) {
		char *argv[] = { "/bin/echo", "Hello from echo!", NULL };
		execv(argv[0], argv);
	} else {
		perror("Fork failed!");
		return 1;
	}

	return 0;
}
