KERNEL_BUILD_PATH ?= "~/kindle/linux-2.6.22"
CROSS_COMPILE ?= "~/kindle/arm-2010.09/bin/arm-none-eabi-"

XVM = sub-projects/allocators/xvmalloc-kmod
LZO = sub-projects/compression/lzo-kmod
EXTRA_CFLAGS	:=	-DCONFIG_BLK_DEV_RAMZSWAP_STATS	\
			-I$(PWD)/$(XVM)			\
			-I$(PWD)/$(LZO)			\
			-g -Wall

obj-m	+=	$(XVM)/xvmalloc.o \
		$(LZO)/lzo1x_compress.o \
		$(LZO)/lzo1x_decompress.o \
		ramzswap.o

all:
	make -C $(KERNEL_BUILD_PATH) M=$(PWD)/$(XVM) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) modules
	make -C $(KERNEL_BUILD_PATH) M=$(PWD)/$(LZO) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) modules
	make -C $(KERNEL_BUILD_PATH) M=$(PWD) ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) modules
	@ln -sf $(XVM)/xvmalloc.ko

clean:
	make -C $(KERNEL_BUILD_PATH) M=$(PWD) clean
	make -C $(KERNEL_BUILD_PATH) M=$(PWD)/$(XVM) clean
	make -C $(KERNEL_BUILD_PATH) M=$(PWD)/$(LZO) clean
	@rm -rf *.ko
