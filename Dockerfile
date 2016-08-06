FROM jekyll/jekyll:latest

# Install bower 
RUN npm install -g bower

WORKDIR /app
RUN git clone https://github.com/koalalorenzo/blog.setale.me.git .
RUN bower i --allow-root
RUN mkdir /output
RUN jekyll build --destination /output/

EXPOSE 4000
CMD jekyll serve --destination /output/