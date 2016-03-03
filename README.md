# ubuntu-lnp
=================

Out-of-the-box LNP image (Linux Nginx with PHP Fpm)

Usage
-----

To build your own image download the source  and execute the following command within the root of the source:

	docker build -t ubuntu-nginx .


Running your LAMP docker image
------------------------------

Start your image binding the external ports 80 and 443 in all interfaces to your container:

	docker run -d -P --name myapp -v /path/to/cloned/project:/app ubuntu-nginx

Test your deployment:

Run docker ps to see which port your image has been assiged, then use your docker host ip with that port number.

Please note that nginx points to /app/src/public this is the default configuration for drive application that are based on zend.

That's it!
