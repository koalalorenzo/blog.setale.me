FROM jekyll/jekyll:latest

# Install bower
RUN npm install -g bower http-server

WORKDIR /srv/jekyll
# RUN git clone https://github.com/koalalorenzo/blog.setale.me.git .
ADD . /srv/jekyll
RUN bower i --allow-root
RUN jekyll build --destination /srv/jekyll/_site

EXPOSE 80
CMD bower i --allow-root; http-server /srv/jekyll/_site -p 80 -d false