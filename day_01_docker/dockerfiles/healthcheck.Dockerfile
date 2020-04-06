FROM nginx:1.13
HEALTHCHECK --interval=5s --timeout=3s CMD curl --fail http://localhost:80/hello.html || exit 1
EXPOSE 80

