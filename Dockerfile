FROM python:3.9

COPY app /app
WORKDIR /app

RUN apt update
# RUN apt install -y 

# add mac USER (501)
# RUN useradd -ms /bin/bash mac
# RUN usermod -u 501 mac
# RUN mkdir -p /home/mac/

RUN pip install --no-cache-dir -r requirements.txt


CMD ["python","/app/main.py"]
