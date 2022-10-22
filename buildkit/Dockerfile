FROM golang:1.7.3 as builder
WORKDIR /root/
COPY main.go ./
RUN CGO_ENABLED=0 go build -a -installsuffix cgo -o app .

FROM alpine:3.16.2

ADD file file
ADD file2 file2
WORKDIR /root/
COPY --from=builder /root/app ./
