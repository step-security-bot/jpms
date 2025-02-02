
# JPMS Attic

- [GitHub Repo](https://github.com/javamodules/attic)
- [Docs](https://jpms.pkg.st)

This repository provides sub-module library overrides for popular Java libraries which don't yet provide JPMS support (at least until some PRs are merged!). There is a Maven repository which contains these artifacts, too, so you can safely use them in your projects.

> [!TIP]
> **These libraries should be treated like `SNAPSHOT` versions until a release is issued. If you see hash failures with Gradle, make sure to pass `--refresh-dependencies --write-verification-metadata ...`. With Maven, pass `-U`.**

#### Pending PRs

Tracking issue [here][6] provides the best tracker. Once these PRs are merged and changes are released, this repo becomes obsolete.

- google/j2objc#2302 feat: support jpms in annotations module
- google/error-prone#4311 feat: add jpms definition for annotations
- typetools/checker-framework#6326 Add module-info.java to checker-qual

### What's in the box?

- **[`com.google.errorprone`][2]:** **Error Prone Compiler** "is a static analysis tool for Java that catches common programming mistakes at compile time," built by Google. Error Prone's annotations module is JPMS-enabled at the embedded sub-module, and is used by Guava. The [PR enabling JPMS support in Error Prone Annotations][3] has been filed, merged, and released, as [`2.26.1`](https://github.com/google/error-prone/releases/tag/v2.26.1).

- **[`com.google.guava`][11]:** **Google Guava** is Google's core Java commons, used throughout Google's code and the wider JVM ecosystem. Guava is an immensely popular artifact, with tons of fantastic utilities. JPMS support is [in draft][12].

- **[`com.google.j2objc`][4]:** **J2ObjC** is a Java to Objective-C cross-compiling layer used by Google to effectively share Java logic on iOS and macOS platforms. J2ObjC itself is very complex and powerful, but here we have just JPMS-enabled the `annotations` module, which is used by Guava. The [PR enabling JPMS support for J2ObjC annotations][5] has been filed, merged, and released as [`3.0.0`](https://github.com/google/j2objc/commit/a883dd3f90d51d5ccad4aa3af8feaaeed6560109).


- **[`com.google.protobuf`][4]:** **Protocol Buffers** (a.k.a., protobuf) are Google's language-neutral, platform-neutral, extensible mechanism for serializing structured data. = JPMS support is [in draft][17].

- **[`org.checkerframework`][0]:** **Checker Framework** is a type-checking framework for Java. The `checker-qual` package is used by Guava, so it is included here transitively. Checker Framework added a JPMS module definition in a [recent PR][1], so this is sub-moduled at `master`. At the time of this writing no release has taken place.

- **[`org.reactivestreams`][16]:** **Reactive Streams** is a universal JVM API for building reactive software in an implementation-agnostic manner.

### How do I use it?

Add this domain as a repository within any JVM build tool: [Maven][7], [Gradle][8], [Bazel][9], [sbt][10]. For example:

> [!NOTE]
> **Filing issues:** Please file issues for this repo on [`elide-dev/jpms`](https://github.com/elide-dev/jpms/issues).

#### Maven

```xml
  <repositories>
    <repository>
      <id>jpms-attic</id>
      <name>JPMS Attic</name>
      <url>https://jpms.pkg.st/repository</url>
    </repository>
  </repositories>
```

#### Gradle

##### Groovy

```groovy
repositories {
    maven {
        url "https://jpms.pkg.st/repository"
    }
}
```

##### Kotlin

```kotlin
repositories {
    maven {
        url = uri("https://jpms.pkg.st/repository")
    }
}
```

### Libraries

You should use a JPMS-enabled library version which has no conflict with Maven Central. Reference the table below to pick a library.

**Libraries with a check-mark have seen releases in Maven Central,** and so are no longer needed through this repository.


| Coordinate                                      | Version                 | Released |
| ----------------------------------------------- | ----------------------- | -------- |
| `com.google.errorprone:error_prone_annotations` | `2.26.1`                | ✅       |
| `com.google.guava:guava`                        | `33.0.0-jre-jpms`       | 🔄       |
| `com.google.j2objc:j2objc-annotations`          | `3.0.0`                 | ✅       |
| `com.google.protobuf:protobuf-java`             | `4.26.0-jpms`           | 🔄       |
| `com.google.protobuf:protobuf-javalite`         | `4.26.0-jpms`           | 🔄       |
| `com.google.protobuf:protobuf-util`             | `4.26.0-jpms`           | 🔄       |
| `com.google.protobuf:protobuf-kotlin`           | `4.26.0-jpms`           | 🔄       |
| `com.google.protobuf:protobuf-kotlin-lite`      | `4.26.0-jpms`           | 🔄       |
| `org.checkerframework:checker-qual`             | `3.43.0-SNAPSHOT`       | 🔄       |
| `org.reactivestreams:reactive-streams`          | `1.0.5-jpms`            | ✅       |

### Using the modules

Use the modules in your `module-info.java`:

| Coordinate                                      | Module                              |
| ----------------------------------------------- | ----------------------------------- |
| `com.google.errorprone:error_prone_annotations` | `com.google.errorprone.annotations` |
| `com.google.guava:guava`                        | `com.google.common`                 |
| `com.google.j2objc:j2objc-annotations`          | `com.google.j2objc.annotations`     |
| `com.google.protobuf:protobuf-java`             | `com.google.protobuf`               |
| `com.google.protobuf:protobuf-javalite`         | `com.google.protobuf`               |
| `com.google.protobuf:protobuf-util`             | `com.google.protobuf.util`          |
| `com.google.protobuf:protobuf-kotlin`           | `com.google.protobuf.kotlin`        |
| `com.google.protobuf:protobuf-kotlin-lite`      | `com.google.protobuf.kotlin`        |
| `org.checkerframework:checker-qual`             | `org.checkerframework.checker.qual` |
| `org.reactivestreams:reactive-streams`          | `org.reactivestreams`               |

### BOMs & Catalogs

This repository additionally provides [Maven BOM][13], [Gradle Version Catalog][14], and [Gradle Platform][15] artifacts. These simplify and enforce the use of the right library versions. See below for use.

| Type                  | Coordinate                      | Version  |
| --------------------- | ------------------------------- | -------- |
| [Maven BOM][13]       | `dev.javamodules:jpms-bom`      | `1.0.0`  |
| [Gradle Catalog][14]  | `dev.javamodules:jpms-catalog`  | `1.0.0`  |
| [Gradle Platform][15] | `dev.javamodules:jpms-platform` | `1.0.0`  |

#### Using the Version Catalog

To use the version catalog from Gradle, follow the setup steps below. These code samples are provided in Kotlin:

**`settings.gradle.kts`**:

```kotlin
dependencyResolutionManagement {
  repositories {
    mavenCentral()

    maven {
      name = "jpms-attic"
      url = uri("https://jpms.pkg.st/repository")
    }
  }

  versionCatalogs {
    create("attic") {
      from("dev.javamodules:jpms-catalog:1.0.0")
    }
  }
}
```

**`build.gradle.kts`**:

```kotlin
dependencies {
  api(attic.guava)
}
```

#### Using the Gradle Platform

To use the Gradle Platform to constrain your versions, map the repository as usual, then:

```kotlin
dependencies {
  api(platform("dev.javamodules:jpms-platform:1.0.0"))
}
```

The Version Catalog also provides a mapping:

```kotlin
dependencies {
  api(platform(attic.javamodules.platform))
}
```

### Limitations

This repo does not currently publish source or javadoc JARs. It's not that it couldn't, it's just that mounting classifier-equipped JARs in local repositories is annoying.

### Sample Projects

Sample projects are provided in the [samples](./samples) directory, which show how to hook up the repository and override libraries.

### Licensing

This repo is open source, licensed under [Apache 2.0](./LICENSE.txt). The libraries listed in this repo may have their own licenses; it is up to you to comply with these. These libraries are only published here for the purpose of early testing and development against new code; no warranty is provided of any kind.

[0]: https://github.com/typetools/checker-framework
[1]: https://github.com/typetools/checker-framework/pull/6326
[2]: https://github.com/sgammon/error-prone
[3]: https://github.com/google/error-prone/pull/4311
[4]: https://github.com/google/j2objc
[5]: https://github.com/google/j2objc/pull/2302
[6]: https://github.com/elide-dev/jpms/issues/1
[7]: https://maven.apache.org/guides/mini/guide-multiple-repositories.html
[8]: https://docs.gradle.org/current/userguide/declaring_repositories.html
[9]: https://github.com/bazelbuild/rules_jvm_external/blob/master/docs/api.md#maven_install-repositories
[10]: https://www.scala-sbt.org/1.x/docs/Resolvers.html
[11]: https://github.com/google/guava
[12]: https://github.com/sgammon/guava/pull/14
[13]: https://maven.apache.org/guides/introduction/introduction-to-dependency-mechanism.html#bill-of-materials-bom-poms
[14]: https://docs.gradle.org/current/userguide/platforms.html
[15]: https://docs.gradle.org/current/userguide/dependency_version_alignment.html
[16]: https://github.com/reactive-streams/reactive-streams-jvm
[17]: https://github.com/protocolbuffers/protobuf/pull/16178
