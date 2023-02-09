build: supercollider
	mkdir -p build
	cd build && cmake -DCMAKE_BUILD_TYPE=Release .. 
	cd build && make

install: build
	mkdir -p ~/.local/share/SuperCollider/Extensions/norns-ugens/
	cp build/SoftCutHead.so ~/.local/share/SuperCollider/Extensions/norns-ugens/
	cp SoftCutHead.sc ~/.local/share/SuperCollider/Extensions/norns-ugens/


supercollider:
	git clone --recursive https://github.com/supercollider/supercollider.git


clean:
	rm -rf build