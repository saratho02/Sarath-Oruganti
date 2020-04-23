FROM python:2.7-slim


WORKDIR /opt/microservices
COPY app.py /opt/microservices/

COPY requirements.txt /opt/microservices/

RUN pip install --trusted-host pypi.python.org -r requirements.txt

EXPOSE 5000

ARG service_version
ENV SERVICE_VERSION ${service_version:-v1}

WORKDIR /opt/microservices
CMD ["python", "app.py"]
