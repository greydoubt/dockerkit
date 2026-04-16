FROM golang:1.12.5 as builder

# NOT in $GOPATH (or explicitly set GO111MODULES=on)
WORKDIR /usr/src/test-ldap/

COPY go.mod .
RUN go mod download  # alternatively: "go mod vendor" to build a vendor/ dir instead

COPY main.go .
# ...
