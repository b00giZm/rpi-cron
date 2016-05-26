# rpi-cron

A minimal RaspberryPi Docker image for running cron jobs.

## Usage

For simply running some cron jobs, just call:

```bash
docker run -it --rm -v /path/to/jobs:/etc/periodic b00gizm/rpi-cron
```

Or create your own image with `b00gizm/rpi-cron` as your base:

```Docker
FROM b00gizm/rpi-cron

COPY jobs /etc/periodic
```

## ENV Variables

Since cron always runs with a mostly empty environment, all environment variables will be stored inside `/env.sh` during `docker run`. You can then easily `source` them inside your jobs, if you need them:

```
docker run -it --rm \
    -e MYVAR=foo \
    -v /path/to/jobs:/etc/periodic \
  b00gizm/rpi-cron
```

Inside your job:

```bash
#!/bin/bash

source /env.sh

echo $MYVAR; # prints 'foo'
```

## Maintainer

Pascal Cremer

* Email: <hello@codenugget.co>
* Twitter: [@b00gizm](https://twitter.com/b00gizm)
* Web: [http://codenugget.co](http://codenugget.co)

## License

>The MIT License (MIT)
>
>Copyright (c) 2016 Pascal Cremer
>
>Permission is hereby granted, free of charge, to any person obtaining a copy
>of this software and associated documentation files (the "Software"), to deal
>in the Software without restriction, including without limitation the rights
>to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
>copies of the Software, and to permit persons to whom the Software is
>furnished to do so, subject to the following conditions:
>
>The above copyright notice and this permission notice shall be included in all
>copies or substantial portions of the Software.
>
>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
