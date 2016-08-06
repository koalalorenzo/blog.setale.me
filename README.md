# blog.setale.me
My own personal blog

To build my blog you just need Docker. Then you can run:

    docker build . -t 'blog'
    docker run -v $PWD/_site:/output blog

And you will find the source code available in the `_site` directory.
If you want to `serve` the blog with jekyll use the following:

    docker run -p 4000:4000 blog jekyll serve --source /app --destination /output
