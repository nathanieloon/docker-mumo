FROM phusion/baseimage:0.9.11
ENV pword defaultpass
ENV youtube_key defaultkey

RUN apt-get update
RUN apt-get install -y python git python-zeroc-ice wget python-beautifulsoup
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python
RUN easy_install isodate requests

ADD start.sh /tmp/start.sh
RUN chmod 755 /tmp/start.sh

VOLUME ["/data"]

RUN git clone https://github.com/mumble-voip/mumo.git

WORKDIR /mumo
RUN git clone https://github.com/nathanieloon/mumo-modules.git
RUN rm modules -r
RUN mv mumo-modules modules && mkdir modules-enabled 
RUN cd modules-available && ln -s ../modules/*.ini .
RUN cd modules-enabled && ln -s ../modules/*.ini .
RUN rm modules-enabled/dbintegrate.ini
ADD key.py /mumo/modules/key.py
RUN chmod 755 /mumo/modules/key.py
CMD ["/tmp/start.sh"]