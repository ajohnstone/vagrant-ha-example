# Vagrant High Availability Example

* Website: [http://www.ajohnstone.com](http://www.ajohnstone.com)
* Source: [https://github.com/ajohnstone/vagrant-ha-example](https://github.com/ajohnstone/vagrant-ha-example)

## Installation

Please refer to the vagrant installation instructions [here](http://vagrantup.com/docs/getting-started/index.html).

## Components

This will setup the following components

* [HAProxy](http://haproxy.1wt.eu/) HAProxy is a free, very fast and reliable solution offering high availability, load balancing, and proxying for TCP and HTTP-based applications. 
* [Keepalived](http://www.keepalived.org/)
* [Apache 2](http://httpd.apache.org/)
* [GlusterFS](http://www.gluster.org/) GlusterFS is a software-only, highly available, scalable, centrally managed storage pool for public and private cloud environments.

## Testing

Randomly generate points of failure within the application.
