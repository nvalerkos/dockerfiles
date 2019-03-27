# ubuntu-lnp

Out-of-the-box LNP image (Linux Nginx with PHP Fpm)

Pull with php 5.6.x
---------------------

	docker pull justckr/ubuntu-nginx-php:latest

Pull with php 7.0.x
---------------------

	docker pull justckr/ubuntu-nginx-php:php7
	
Pull with php 7.2.x
---------------------

	docker pull justckr/ubuntu-nginx-php:php7.2

Building it your own
-----------------------

To build your own image download the source  and execute the following command within the root of the source:

	docker build -t ubuntu-nginx .


Running
---------------------------------------

Start your image binding the external ports 80 and 443 in all interfaces to your container:

	docker run -d -P --name myapp -v /path/to/cloned/project:/app justckr/ubuntu-nginx-php


Test your deployment:

Run docker ps to see which port your image has been assiged, then use your docker host ip with that port number.

Please note that nginx points to /app/src/public this is the default configuration for drive application that are based on zend.

That's it!
