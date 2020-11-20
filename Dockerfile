FROM python:3.6.8-slim

RUN apt-get -y update  && apt-get install -y \
  python3-dev \
  apt-utils \
  python-dev \
  build-essential \
&& rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install --upgrade setuptools
RUN pip install cython
RUN pip install numpy
RUN pip install matplotlib
RUN pip install pystan
RUN pip install fbprophet
RUN pip install pandas
RUN pip install gunicorn

RUN pip install -r requirements.txt
RUN pip freeze

COPY app.py helper_v4.py boot.sh ./

COPY static static
COPY templates templates

RUN chmod +x boot.sh

ENV FLASK_APP app.py

EXPOSE 5000

ENTRYPOINT ["./boot.sh"]
