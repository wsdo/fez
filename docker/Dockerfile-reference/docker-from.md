<!--
 * @Author: starkwang
 * @Contact me: https://shudong.wang/about
 * @Date: 2019-11-18 17:06:14
 * @LastEditors: starkwang
 * @LastEditTime: 2019-11-18 17:08:44
 * @Description: file content
 -->
## FROM

    FROM <image> [AS <name>]

Or

    FROM <image>[:<tag>] [AS <name>]

Or

    FROM <image>[@<digest>] [AS <name>]

The `FROM` instruction initializes a new build stage and sets the
[*Base Image*](glossary.md#base-image) for subsequent instructions. As such, a
valid `Dockerfile` must start with a `FROM` instruction. The image can be
any valid image – it is especially easy to start by **pulling an image** from
the [*Public Repositories*](https://docs.docker.com/engine/tutorials/dockerrepos/).

- `ARG` is the only instruction that may precede `FROM` in the `Dockerfile`.
  See [Understand how ARG and FROM interact](#understand-how-arg-and-from-interact).

- `FROM` can appear multiple times within a single `Dockerfile` to
  create multiple images or use one build stage as a dependency for another.
  Simply make a note of the last image ID output by the commit before each new
  `FROM` instruction. Each `FROM` instruction clears any state created by previous
  instructions.

- Optionally a name can be given to a new build stage by adding `AS name` to the
  `FROM` instruction. The name can be used in subsequent `FROM` and
  `COPY --from=<name|index>` instructions to refer to the image built in this stage.

- The `tag` or `digest` values are optional. If you omit either of them, the
  builder assumes a `latest` tag by default. The builder returns an error if it
  cannot find the `tag` value.

### Understand how ARG and FROM interact

`FROM` instructions support variables that are declared by any `ARG`
instructions that occur before the first `FROM`.

```Dockerfile
ARG  CODE_VERSION=latest
FROM base:${CODE_VERSION}
CMD  /code/run-app

FROM extras:${CODE_VERSION}
CMD  /code/run-extras
```

An `ARG` declared before a `FROM` is outside of a build stage, so it
can't be used in any instruction after a `FROM`. To use the default value of
an `ARG` declared before the first `FROM` use an `ARG` instruction without
a value inside of a build stage:

```Dockerfile
ARG VERSION=latest
FROM busybox:$VERSION
ARG VERSION
RUN echo $VERSION > image_version
```
