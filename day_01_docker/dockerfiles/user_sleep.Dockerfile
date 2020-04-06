FROM alpine:3.8
RUN adduser -D myuser
USER myuser
ENTRYPOINT ["sleep"]
CMD ["1000"]
