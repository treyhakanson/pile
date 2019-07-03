# Apache vs Nginx

## Overview

Both are open-source web servers. Apache is older, and the most popular. It is very well documented due to widespread support, and is highly flexible and power. Capable of extension through a robust module loading system, which can process a large number of interpreted languages without additional software.

Nginx was created to manage the "C10K" problem, which pertains to having a large amount of concurrent requests hitting a web server, as occurs in modern day applications. Scales easily on minimal hardware. It accels at serving static content quickly and is designed to pass of dynamic requests off to other software better designed for that purpose.

## Connection Handling

One of the biggest difference between Apache and Nginx is the way they actually handle connections and traffic, which dictates how the respond to different loads and stresses.

### Apache

Apache provides a variety of multi-processing modules (MPMs) that dictate how client requests are handled. This allows for the administrator to swap out connection handling architecture quickly, as needed.

MPMs are:

1. mpm_prefork: spawns processes with a single thread for each request. Does not scale particularly well as performance takes a serious hit once all processes are in use.
2. mpm_worker: spawns process that can manage multiple threads. Threads are much more resource efficient than processes. There are more threads than processes, so new connections can immediately take a free thread instead of having to wait for a free process.
3. mpm_event: similar to mpm_worker, but optimized for keep alive situations.

### Nginx

Designed from the ground up to use to use an asynchronous, non-blocking, event-driven connection algorithm. Nginx's worker processes can handle thousands of connections. Scales incredibly well because the threads don't handle actual work, but only connections; the actual work is passed off elsewhere.

## Static vs Dynamic Content

### Apache

Static content is served using conventional file based methods

Dynamic content is handled by impeding a language interpreter in each of the threads spun up so that the thread processing the connection can also handle the work needed to process the request. Handling dynamic content internally like this typically makes it easier to handle, since coordination with external software is not needed.

### Nginx

Does not process dynamic content internally. Handles request, sends off information to a external process, which then returns the results to Nginx so they can be relayed to the client.

This means that communication between Nginx and the process must be defined. This can be slightly more complicated, but since the dynamic content isn't interpreted internally it leads to significantly less overhead. Apache can also function in this manner, but it loses some of its other benefits (ease of use, etc.)

## Sources

- [Digital Ocean](https://www.digitalocean.com/community/tutorials/apache-vs-nginx-practical-considerations)
