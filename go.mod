// Source - https://stackoverflow.com/a/57102862
// Posted by helmbert, modified by community. See post 'Timeline' for change history
// Retrieved 2026-04-16, License - CC BY-SA 4.0

FROM golang:1.12.5 as builder

# NOT in $GOPATH (or explicitly set GO111MODULES=on)
WORKDIR /usr/src/test-ldap/

COPY go.mod .
RUN go mod download  # alternatively: "go mod vendor" to build a vendor/ dir instead

COPY main.go .
# ...
