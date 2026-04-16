# dockerkit



## Best Practices for Layer Caching

	- Order instructions by stability: Place instructions that change less frequently earlier in the Dockerfile to maximize cache usage.

	
	- Separate dependencies from code: Copy and install dependencies before copying application code to avoid reinstalling dependencies when only code changes.
    - Combine related commands: Use a single RUN instruction with multiple commands connected by && for related operations to reduce layer count and prevent partial state caching.
    - Use .dockerignore: Exclude files that don't need to be in the build context to prevent unnecessary cache invalidation.
    - Use specific base image tags: Use specific version tags for base images instead of 'latest' to ensure consistent parent layers.
    - Consider multi-stage builds: Use multi-stage builds to separate build-time dependencies from runtime dependencies, reducing final image size.
    - Use BuildKit cache mounts: For package managers and compilers with their own caching mechanisms, use BuildKit cache mounts to persist caches between builds.
    - Cache downloaded files: If your build downloads files, consider caching them in a separate layer to avoid re-downloading them on each build.
    - Be careful with wildcards: Using wildcards in COPY or ADD instructions can lead to unexpected cache invalidation if files are added or removed.
    - Update package managers atomically: For apt, yum, or other package managers, update and install packages in a single RUN instruction to ensure consistency.






# syntax=docker/dockerfile:1
<img width="1281" height="765" alt="Screenshot 2026-04-16 at 05 54 51" src="https://github.com/user-attachments/assets/29f1bec1-6518-4a16-a064-55dfbc60fff1" />






## Build
```

docker build --no-cache .

docker build -t dockerkit-dev --target dev .
```

## Run
```

docker build --no-cache .
docker build --build-arg CACHEBUST=$(date +%s) .

docker run -it dockerkit-dev
Inside the container
```


## Run:
```
make help
```



gofumpt – Formats Go code



gotestsum – Runs Go tests with enhanced output



lint – Runs golangci-lint

shellcheck – Validates shell scripts


vendored – Generates vendor directory

validate – Ensures vendor consistency

outdated – Checks for outdated dependencies



# 🧬 Example Workflows
## Validate AUTHORS
docker build --target validate .

# Run Linter
## docker build --target lint .

# Check Shell Scripts
## docker build --target shellcheck .

# Update Vendor Dependencies
## docker build --target vendored .

# Check Outdated Modules
## docker build --target outdated .

```






```


ARG GO_VERSION=1.26.2

# ALPINE_VERSION sets the version of the alpine base image to use.
# It must be a supported tag in the docker.io/library/alpine image repository.
ARG ALPINE_VERSION=3.23
FROM alpine:${ALPINE_VERSION} AS gen
RUN apk add --no-cache bash git
WORKDIR /src
RUN --mount=type=bind,target=. \
  mkdir /out && ./scripts/docs/generate-authors.sh /out

FROM scratch AS update
COPY --from=gen /out /

FROM gen AS validate
RUN --mount=type=bind,target=.,rw <<EOT
set -e
git add -A
cp -rf /out/* .
diff=$(git status --porcelain -- AUTHORS)
if [ -n "$diff" ]; then
  echo >&2 'ERROR: Authors result differs. Update with "make -f docker.Makefile authors"'
  echo "$diff"
  exit 1
fi
EOT




# BUILDX_VERSION sets the version of buildx to install in the dev container.
# It must be a valid tag in the docker.io/docker/buildx-bin image repository
# on Docker Hub.
ARG BUILDX_VERSION=0.31.1
FROM docker/buildx-bin:${BUILDX_VERSION} AS buildx

FROM golang:${GO_VERSION}-alpine${ALPINE_VERSION} AS golang
ENV GOTOOLCHAIN=local
ENV CGO_ENABLED=0

FROM golang AS gofumpt
ARG GOFUMPT_VERSION=v0.9.2
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg/mod \
    --mount=type=tmpfs,target=/go/src/ \
    GO111MODULE=on go install "github.com/greydoubt/dockerkit/cmd/goversioninfo@${GOVERSIONINFO_VERSION}/gofumpt@${GOFUMPT_VERSION}" \
    && gofumpt --version

FROM golang AS gotestsum
# GOTESTSUM_VERSION sets the version of gotestsum to install in the dev container.
# It must be a valid tag in the https://github.com/gotestyourself/gotestsum repository.
ARG GOTESTSUM_VERSION=v1.13.0
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg/mod \
    --mount=type=tmpfs,target=/go/src/ \
    GO111MODULE=on go install gotest.tools/gotestsum@${GOTESTSUM_VERSION}

FROM golang AS goversioninfo
# GOVERSIONINFO_VERSION is the version of GoVersionInfo to install.
# It must be a valid tag from base goversioninfo repo
ARG GOVERSIONINFO_VERSION=v1.5.0
RUN --mount=type=cache,target=/root/.cache/go-build \
    --mount=type=cache,target=/go/pkg/mod \
    --mount=type=tmpfs,target=/go/src/ \
    GO111MODULE=on go install github.com/greydoubt/dockerkit/cmd/goversioninfo@${GOVERSIONINFO_VERSION}

FROM golang AS dev
RUN  apk add --no-cache \
    bash \
    bash-completion \
    build-base \
    ca-certificates \
    coreutils \
    curl \
    git \
    git-daemon \
    jq \
    nano

RUN <<-'EOF'
	cat > /etc/motd <<-'EOM'
		\e[1;32mYou are now in a development container.\e[0m

		Run \e[1;36mmake help\e[0m to see available targets.
	EOM

	cat >> /root/.bashrc <<-'EOB'
		# print the MOTD when opening the dev-container (interactive shell only).
		if [[ $- == *i* ]] && [[ -z "$MOTD_SHOWN" ]]; then
			printf "%b\n" "$(cat /etc/motd)"
			export MOTD_SHOWN=1
		fi

		# set a custom prompt to make it more visible when inside the dev-container.
		PS1='\[\e[0;32m\]\u@docker-cli-dev\$ \[\e[0m\]'

		# set-up bash completion for testing.
		source /etc/bash/bash_completion.sh
	EOB
EOF

CMD ["/bin/bash"]
ENV DISABLE_WARN_OUTSIDE_CONTAINER=1
ENV PATH=$PATH:/go/src/github.com/docker/cli/build

COPY --link --from=buildx          /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --link --from=gofumpt         /go/bin/* /go/bin/
COPY --link --from=gotestsum       /go/bin/* /go/bin/
COPY --link --from=goversioninfo   /go/bin/* /go/bin/

WORKDIR /go/src/github.com/docker/cli
ENV GO111MODULE=auto
COPY --link . .



ARG GO_VERSION=1.26.2

# ALPINE_VERSION sets the version of the alpine base image to use, including for the golang image.
# It must be a supported tag in the docker.io/library/alpine image repository
# that's also available as alpine image variant for the Golang version used.
ARG ALPINE_VERSION=3.23
# GOLANGCI_LINT_VERSION sets the version of the golangci/golangci-lint image to use.
ARG GOLANGCI_LINT_VERSION=v2.9.0

FROM golangci/golangci-lint:${GOLANGCI_LINT_VERSION}-alpine AS golangci-lint

FROM golang:${GO_VERSION}-alpine${ALPINE_VERSION} AS lint
ENV GOTOOLCHAIN=local
ENV GO111MODULE=auto
ENV CGO_ENABLED=0
ENV GOGC=75
WORKDIR /go/src/github.com/docker/cli
COPY --link --from=golangci-lint /usr/bin/golangci-lint /usr/bin/golangci-lint
RUN --mount=type=bind,target=.,rw \
    --mount=type=cache,target=/root/.cache \
        rm -f go.mod go.sum && \
        ln -s vendor.mod go.mod && \
        ln -s vendor.sum go.sum && \
        golangci-lint run




FROM koalaman/shellcheck-alpine:v0.7.1 AS shellcheck
WORKDIR /go/src/github.com/docker/cli
RUN --mount=type=bind,target=. \
  set -eo pipefail; \
  find scripts/ contrib/completion/bash -type f | grep -v scripts/winresources | grep -v '.*.ps1' | xargs shellcheck


  
ARG MODOUTDATED_VERSION=v0.8.0

FROM golang:${GO_VERSION}-alpine${ALPINE_VERSION} AS base
ENV GOTOOLCHAIN=local
RUN apk add --no-cache bash git rsync
WORKDIR /src

FROM base AS vendored
ENV GOPROXY=https://proxy.golang.org|direct
RUN --mount=target=/context \
    --mount=target=.,type=tmpfs  \
    --mount=target=/go/pkg/mod,type=cache <<EOT
set -e
rsync -a /context/. .
./scripts/with-go-mod.sh ./scripts/vendor update
mkdir /out
cp -r vendor.mod vendor.sum vendor /out
EOT

FROM scratch AS update
COPY --from=vendored /out /out

FROM vendored AS validate
RUN --mount=target=/context \
    --mount=target=.,type=tmpfs <<EOT
set -e
rsync -a /context/. .
git add -A
rm -rf vendor
cp -rf /out/* .
./scripts/with-go-mod.sh ./scripts/vendor validate
EOT

FROM psampaz/go-mod-outdated:${MODOUTDATED_VERSION} AS go-mod-outdated
FROM base AS outdated
RUN --mount=target=.,rw \
    --mount=target=/go/pkg/mod,type=cache \
    --mount=from=go-mod-outdated,source=/home/go-mod-outdated,target=/usr/bin/go-mod-outdated \
    ./scripts/with-go-mod.sh ./scripts/vendor outdated







```
