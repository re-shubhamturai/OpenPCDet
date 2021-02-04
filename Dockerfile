# set base image (host OS)
FROM scrin/dev-spconv:latest AS base
# FROM nvidia/cuda:11.1-cudnn8-devel-ubuntu18.04
# FROM ubuntu:18.04
LABEL maintainer="Shubham Turai <shubham.turai@robotic-eyes.com>"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DE19EB17684BA42D
RUN apt-get update
RUN apt-get install -y libsm6 libxext6 libxrender-dev libgl1-mesa-dev
# RUN apt install -y libgl1-mesa-dev python3-pip git
RUN pip3 install --upgrade pip
# RUN apt-get install libX11-6*
# RUN apt-get install libgl1-mesa-dev libX11-6:amd64 libXext
RUN pip3 install mayavi
# RUN git clone https://github.com/enthought/mayavi.git

# RUN pip3 install apptools
# RUN pip3 install envisage
# RUN pip3 install numpy
# RUN pip3 install pyface>=6.0.0
# RUN pip3 install pygments
# RUN pip3 install Sphinx
# RUN pip3 install traits>=4.6.0
# RUN pip3 install traitsui>=6.0.0
# RUN pip3 install vtk
# RUN pip3 install six
# # RUN pip3 install -r requirements.txt
# RUN pip3 install PyQt5
# RUN pwd
# WORKDIR /root/mayavi
# # RUN apt-get install -y libgl1-mesa-dev
# # RUN apt install -y libx11-dev
# RUN python3 setup.py install

# WORKDIR /root
# RUN rm -r mayavi

COPY requirements.txt /home/requirements.txt
# COPY setup.py /home/setup.py
# COPY pcdet /home/pcdet
# RUN pip3 install numpy
# RUN pip3 install torch>=1.1
# RUN pip3 install numba
# RUN pip3 install tensorboardX
# RUN pip3 install easydict
# RUN pip3 install pyyaml
# RUN pip3 install scikit-image
# RUN pip3 install tqdm
WORKDIR /home
RUN pip3 install -U -r requirements.txt
RUN pip3 install PyQt5
RUN apt-get install -y qt5-default libxcb* libxkbcommon-x11-dev

FROM base as debug
RUN pip3 install debugpy
# WORKDIR /root
# COPY pcdet /home/pcdet
# COPY setup.py /home/setup.py
# WORKDIR /home
# RUN python3 setup.py develop
# WORKDIR /home/tools/
# CMD python3 -m debugpy --listen 0.0.0.0:5678 --wait-for-client demo.py --cfg_file cfgs/kitti_models/pointpillar.yaml --ckpt ckpts/pointpillar_7728.pth --data_path /home/data/kitti/training/velodyne/000000.bin

CMD ["./start.sh"]

FROM base as prod
CMD ["./start.sh"]