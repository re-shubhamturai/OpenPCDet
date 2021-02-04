all: prod-build

prod-build:
	docker build --tag openpcdet:latest --target prod -f Dockerfile .

debug-build:
	docker build --tag openpcdet:latest --target debug -f Dockerfile .

prod-run:
	docker stop $(docker ps --filter="name=mfund-openpcdet" --format '{{.Names}}') || true
	# docker rm mfund-openpcdet || true
	# docker run --name unsa-edge-detector -v ${PWD}:/home -v /home/shubhamturai/Downloads/stolperfalleData:/home/stolperfalleData edge-detector:latest
	docker run --rm --runtime=nvidia --name mfund-openpcdet --net=host -e DISPLAY=${DISPLAY} --volume="${HOME}/.Xauthority:/root/.Xauthority:rw" -v ${PWD}:/home -v /disk/mfund/kitti/training:/home/data/kitti/training:ro -v /disk/mfund/kitti/testing:/home/data/kitti/testing:ro openpcdet:latest

debug-run:
	docker stop $(docker ps --filter="name=mfund-openpcdet" --format '{{.Names}}') || true
	# docker rm mfund-openpcdet || true
	# docker run --name unsa-edge-detector -v ${PWD}:/home -v /home/shubhamturai/Downloads/stolperfalleData:/home/stolperfalleData edge-detector:latest
	docker run -it --rm --runtime=nvidia --name mfund-openpcdet --net=host -p 5678:5678 -e DISPLAY=${DISPLAY} --volume="${HOME}/.Xauthority:/root/.Xauthority:rw" -v ${PWD}:/home -v /disk/mfund/kitti/training:/home/data/kitti/training:ro -v /disk/mfund/kitti/testing:/home/data/kitti/testing:ro openpcdet:latest
	# docker run --rm -it --runtime=nvidia --name mfund-openpcdet --net=host -p 5678:5678 -e DISPLAY=${DISPLAY} --volume="${HOME}/.Xauthority:/root/.Xauthority:rw" -v ${PWD}:/home -v /home/shubhamturai/Downloads/kitti/training:/home/data/kitti/training:ro -v /home/shubhamturai/Downloads/kitti/testing:/home/data/kitti/testing:ro openpcdet:latest
	# docker run --rm -it --runtime=nvidia --name mfund-openpcdet -v ${PWD}:/home -v /disk/mfund/kitti/training:/home/data/kitti/training:ro -v /disk/mfund/kitti/testing:/home/data/kitti/testing:ro openpcdet:latest