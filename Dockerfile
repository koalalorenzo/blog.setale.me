FROM jekyll/jekyll:latest

# Install bower 
RUN npm install -g bower

WORKDIR /app
# RUN git clone https://github.com/koalalorenzo/blog.setale.me.git .
ADD . /app
RUN bower i --allow-root
RUN mkdir /output; chmod 777 /output
RUN jekyll build --destination /output/

# EXPOSE 4000
CMD bower i --allow-root; jekyll build --destination /output/