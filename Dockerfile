FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y && apt-get install -y wget git build-essential dos2unix

RUN wget http://cz.archive.ubuntu.com/ubuntu/pool/universe/c/cramfs/cramfsprogs_1.1-6ubuntu1_amd64.deb && dpkg -i ./cramfsprogs_1.1-6ubuntu1_amd64.deb

RUN apt-get install -y python-lzma python-crypto libqt4-opengl python-opengl python-qt4 python-qt4-gl python-numpy python-scipy python-pip
RUN apt-get install -y mtd-utils gzip bzip2 tar arj lhasa p7zip p7zip-full cabextract cramfsprogs cramfsswap squashfs-tools sleuthkit default-jdk lzop srecord

RUN pip install nose coverage pyqtgraph capstone

# Install sasquatch to extract non-standard SquashFS images
RUN apt-get install -y zlib1g-dev liblzma-dev liblzo2-dev \
&& git clone https://github.com/devttys0/sasquatch.git && cd sasquatch \
&& wget https://downloads.sourceforge.net/project/squashfs/squashfs/squashfs4.3/squashfs4.3.tar.gz \
&& tar -zxvf squashfs4.3.tar.gz && cd squashfs4.3 && patch -p0 < ../patches/patch0.txt \
&& cd squashfs-tools && make && make install

# Install jefferson to extract JFFS2 file systems
RUN pip install cstruct \
&& git clone https://github.com/sviehb/jefferson \
&& (cd jefferson && python setup.py install)

# Install ubi_reader to extract UBIFS file systems
RUN apt-get install -y liblzo2-dev python-lzo \
&& git clone https://github.com/jrspruitt/ubi_reader \
&& (cd ubi_reader && python setup.py install)

# Install yaffshiv to extract YAFFS file systems
RUN git clone https://github.com/devttys0/yaffshiv \
&& (cd yaffshiv && python setup.py install)

# Install unstuff (closed source) to extract StuffIt archive files
RUN wget -O - http://downloads.tuxfamily.org/sdtraces/stuffit520.611linux-i386.tar.gz | tar -zxv \
&& cp bin/unstuff /usr/local/bin/

COPY . hack
WORKDIR hack
RUN python setup.py install
RUN cd /usr/local/bin && dos2unix ./binwalk