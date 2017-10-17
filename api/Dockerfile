FROM python:3.6.2-stretch

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app/

ADD . /usr/src/app/

# Install dependencies
RUN pip install -r requirements.txt

CMD [ "apistar", "run" ]
