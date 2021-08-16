FROM gitlab-container-registry.minerva.loc/plattform/koin/container-registry/postgres:12-alpine
#FROM postgres:12-alpine
ENV PYTHONUNBUFFERED=1
RUN apk add --update --no-cache gcc musl-dev
RUN apk add --update --no-cache python3-dev && ln -sf python3 /usr/bin/python
RUN python3 -m ensurepip
RUN pip3 install --no-cache --upgrade pip setuptools
RUN pip3 install psycopg2
COPY kickstart.sh ./
COPY postgres.conf /etc/netdata/python.d/postgres.conf
RUN bash ./kickstart.sh --disable-telemetry --dont-wait --stable-channel