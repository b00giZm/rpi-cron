# rpi-cron

Images for running cron jobs inside Docker on your RaspberryPi. These come in two flavors: `raspbian` ([Raspbian](https://www.raspbian.org/) based) and `alpine` ([Alpine Linux](http://www.alpinelinux.org/) based).

```bash
docker pull b00gizm/rpi-cron:raspbian
docker pull b00gizm/rpi-cron:alpine
```

(Pulling `b00gizm/rpi-cron` without a tag defaults to `b00gizm/rpi-cron:raspbian`.)

## Usage

### rpi-cron:raspbian

For simply running some cron jobs, just call:

```bash
docker run -it --rm -v /path/to/jobs:/crons b00gizm/rpi-cron
```

Or create your own image with `b00gizm/rpi-cron:raspbian` as your base:

```Docker
FROM b00gizm/rpi-cron:raspbian

COPY jobs /etc/cron.d
```

You might ask, why not just use `/etc/cron.d` as a volume? Well, you'll run [into some weird issues](https://www.google.com/search?q=docker+cron+hard+links) with that. So I used `/crons`, which is just a directory from where cron scripts will be copied to `/etc/cron.d`, as a kind of work around.

#### ENV Variables

Since cron always runs with a mostly empty environment, all environment variables will be stored inside `/env.sh` during `docker run`. You can then easily `source` them inside your shell scripts, if you need them:

```
docker run -it --rm \
    -e MYVAR=foo \
    -v /path/to/jobs:/crons \
  b00gizm/rpi-cron:raspbian
```

Cron script
```
* * * * * root /my_script >> /var/log/cron.log 2>&1
```

The actual shell script to run

```bash
#!/bin/bash

source /env.sh

echo $MYVAR; # prints 'foo'
```

### rpi-cron:alpine

Running jobs periodically inside the `alpine` flavored `rpi-cron` is much simpler, but also less flexible. You can choose between running jobs every 15 minutes, hourly, daily, weekly, or monthly by putting them into their appropriate directories inside the container `/etc/periodic/{15min,hourly,daily,weekly,monthly}`

```bash
docker run -it --rm -v /path/to/jobs:/etc/periodic b00gizm/rpi-cron
```

Or create your own image with `b00gizm/rpi-cron:alpine` as your base:

```Docker
FROM b00gizm/rpi-cron:alpine

COPY jobs /etc/periodic
```

#### ENV Variables

Since cron always runs with a mostly empty environment, all environment variables will be stored inside `/env.sh` during `docker run`. You can then easily `source` them inside your jobs, if you need them:

```
docker run -it --rm \
    -e MYVAR=foo \
    -v /path/to/jobs:/etc/periodic \
  b00gizm/rpi-cron:alpine
```

The actual job to run

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
