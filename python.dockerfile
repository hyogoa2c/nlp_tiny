# temp stage
FROM python:3.9 as builder

COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /wheels -r requirements.txt

# final stage
FROM python:3.9-slim

COPY --from=builder /wheels /wheels
COPY --from=builder /requirements.txt .

RUN pip install --no-cache /wheels/*

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    mecab mecab-ipadic-utf8 libmecab-dev && \
    apt-get autoremove -y &&\
    apt clean &&\
    cp /etc/mecabrc /usr/local/etc/
