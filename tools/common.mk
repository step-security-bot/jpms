#
# JPMS Attic: Makefile Commons
#

MAVEN_CMD ?= mvn
GRADLE_CMD ?= ./gradlew
BAZEL_CMD ?= bazel

REPOSITORY ?= file://$(PROJECT)/repository
M2_LOCAL ?= $(PROJECT)/.m2/repository
_LOCAL_REPO_ARG ?= -Dmaven.repo.local=$(M2_LOCAL) -Djpms.repository=$(REPOSITORY) -Dprotoc.bin=$(DEV_BIN)/protoc

ENV_PREFIX ?= PATH="$(PROJECT_PATH)" PROTOC="$(DEV_BIN)/protoc"

MAVEN_ARGS ?= $(_LOCAL_REPO_ARG)
GRADLE_ARGS ?= --no-daemon -Pjpms.repository=$(REPOSITORY) $(_LOCAL_REPO_ARG)
BAZEL_ARGS ?=
MAVEN_GOAL ?= install
GRADLE_TASK ?= install
BAZEL_TARGET ?=

ifeq ($(TESTS),yes)
GRADLE_ARGS += check
else
MAVEN_ARGS += -DskipTests
GRADLE_ARGS += -x test
endif

ifeq ($(JAVADOC),yes)
else
MAVEN_ARGS += -Dmaven.javadoc.skip=true
GRADLE_ARGS += -x javadoc
endif

ifeq ($(SIGNING),no)
MAVEN_ARGS += -Dgpg.skip=true
endif

## Command Macros

GIT ?= $(shell which git)
MAVEN ?= $(ENV_PREFIX) $(MAVEN_CMD) $(MAVEN_ARGS)
GRADLE ?= $(ENV_PREFIX) $(GRADLE_CMD) $(GRADLE_ARGS)
BAZEL ?= $(ENV_PREFIX) $(BAZEL_CMD) $(BAZEL_ARGS)
RM ?= rm -f$(POSIX_FLAGS)
RMDIR ?= rm -fr$(POSIX_FLAGS)
MKDIR ?= mkdir -p
CP ?= cp -fr$(POSIX_FLAGS)
