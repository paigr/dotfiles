install: $(shell find src -type f)

src/%:
	mkdir -p $(HOME)/$(*:%$(@F)=%)
	ln -sf $(shell pwd)/$@ $(HOME)/$*
