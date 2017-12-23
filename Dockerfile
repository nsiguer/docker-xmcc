FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
	unzip git libboost-system-dev libboost-filesystem-dev libboost-chrono-dev \
	libboost-program-options-dev libboost-test-dev libboost-thread-dev \
	libboost-all-dev unzip libminiupnpc-dev python-virtualenv build-essential \
	libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils \
	software-properties-common wget

RUN add-apt-repository ppa:bitcoin/bitcoin
RUN apt-get update && apt-get install -y software-properties-common libdb4.8-dev libdb4.8++-dev libzmq5

EXPOSE 24157
VOLUME ["/root/.monoeciCore"]


WORKDIR "/root"

RUN cd /root && wget https://github.com/monacocoin-net/monoeci-core/releases/download/0.12.2/monoeciCore-0.12.2-linux64-cli.Ubuntu16.04.tar.gz && \
	 tar xzvf monoeciCore-0.12.2-linux64-cli.Ubuntu16.04.tar.gz && \
	 chmod +x monoecid monoeci-cli monoeci-tx

COPY src/sentinel.conf /root/sentinel/sentinel.conf

RUN echo '* * * * * cd /home/YOURUSERNAME/sentinel && ./venv/bin/python bin/sentinel.py >/dev/null 2>&1' >> /etc/cron.d/sentinel


ENTRYPOINT ["/root/monoecid"]
