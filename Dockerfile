FROM jekyll/jekyll:latest as builder

WORKDIR /srv/jekyll
RUN gem install jekyll-sitemap jekyll-paginate

COPY . /srv/jekyll
RUN jekyll build 
RUN ls /srv/jekyll/

FROM nginx:alpine as server
COPY --from=builder /srv/jekyll/_site/ /usr/share/nginx/html
EXPOSE 80
