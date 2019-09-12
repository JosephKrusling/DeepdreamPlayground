FROM bvlc/caffe:gpu
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
ADD . /mycaffe
WORKDIR /mycaffe
VOLUME ["/mycaffe/models", "/mycaffe/data", "/mycaffe/notebooks"]
EXPOSE 8888
CMD jupyter notebook --no-browser --ip=0.0.0.0 --allow-root --NotebookApp.token='demo'
