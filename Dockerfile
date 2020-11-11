FROM python:2.7-alpine

RUN apk update && apk upgrade && \
    apk add \
        gcc python python-dev py-pip \
        musl-dev \
        bsd-compat-headers \
        libevent-dev

COPY requirements.txt /temp/requirements.txt
RUN pip install -r /temp/requirements.txt

WORKDIR /requestbin
COPY requestbin/  requestbin/.
EXPOSE 8000

CMD exec gunicorn -b 0.0.0.0:8000 --worker-class gevent --workers 2 --max-requests 1000 requestbin:app


