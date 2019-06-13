# nginx-gunicorn-flask with python3

FROM python
LABEL author="oyjx"


RUN apt update
RUN apt install -y nginx supervisor
RUN pip3 install gunicorn
RUN pip3 install setuptools

ENV PYTHONIOENCODING=utf-8

# Build folder
RUN mkdir -p /app
WORKDIR /app
#only copy requirements.txt.  othors will be mounted by -v
COPY ./requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

# Setup nginx
RUN rm /etc/nginx/sites-enabled/default
COPY nginx_sanic.conf /etc/nginx/sites-available/
RUN ln -s /etc/nginx/sites-available/nginx_sanic.conf /etc/nginx/sites-enabled/nginx_sanic.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Setup supervisord
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY gunicorn.conf /etc/supervisor/conf.d/gunicorn.conf

# run sh. Start processes in docker-compose.yml
#CMD ["/usr/bin/supervisord"]
CMD ["/bin/bash"]