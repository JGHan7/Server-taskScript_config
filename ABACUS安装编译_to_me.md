<center><font size=10>软件安装文档</font></center>
用于各类软件安装更新的具体步骤和所需要的环境，及环境变量的添加和设置

 <center><font size=5>ABACUS安装前需要的编译器以及依赖库：</font></center>
# 编译器

## C++编译器

选择以下其中一种C++编译器

### GCC C++ 编译器

由 git://gcc.gnu.org/git/gcc.git 或 http://mirror.linux-ia64.org/gnu/gcc/releases/gcc-10.3.0/gcc-10.3.0.tar.gz 下载GCC源代码。

```shell
tar -xzvf gcc-10.3.0.tar.gz
```

可以运行GCC自带脚本，自动下载依赖库gmp、mpfr、mpc、isl。

```shell
cd gcc-10.3.0
./contrib/download_prerequisites
cd ../
```

安装GCC

```
mkdir gcc-10.3.0-build
cd gcc-10.3.0-build
../gcc-10.3.0/configure --prefix=目标绝对路径
(对于只需要64位编译器的用户，加上--disable-multilib选项)
make
make install
```

GCC C++编译器为 `目标路径/bin/g++`。

版本需高于4.8.？【也许可更低，需测试】

### Intel C++ 编译器

由 https://software.intel.com/content/www/us/en/develop/tools/oneapi/components/dpc-compiler.html 下载 Intel C++ 编译器安装包。

```shell
bash 安装包.sh
# 根据提示，选择安装模块与安装路径
```

安装结束后，可执行以下语句，设置环境变量。也可以将该语句加入 `~/.bashrc` 文件中使其每次登录时自动加载。

```shell
source 安装路径/setvars.sh
```

Intel C++ 编译器为 `目标路径/oneapi/compiler/latest/linux/intel64/icpc`。

版本需高于？

注意：因 Intel C++ 编译器不提供 C++ 头文件，系统中需要安装 GCC C++ 编译器，并设为系统默认环境【似乎可在icpc时指定】，GCC版本需高于4.9.2【也许可更低，需测试】

## MPI 编译器

选择以下其中一种MPI编译器

### Intel MPI 编译器

由 https://software.intel.com/content/www/us/en/develop/tools/oneapi/components/mpi-library.html 下载 Intel MPI 编译器安装包。

安装过程同 1.1.2 Intel C++ 编译器。

Intel MPI 编译器为 `目标路径/oneapi/mpi/latest/bin/mpiicpc`。

### Open MPI 编译器

由 https://download.open-mpi.org/release/open-mpi/v4.1/openmpi-4.1.0.tar.gz 下载 Open MPI 源代码。
```shell
tar -xzvf openmpi-4.1.0.tar.gz
mkdir openmpi-4.1.0-build
cd openmpi-4.1.0-build/
../openmpi-4.1.0/configure --prefix=目标绝对路径
make
make install
```

OpenMPI MPI 编译器为 `目标路径/bin/mpicxx`。

### MPICH

由 http://www.mpich.org/static/downloads/4.0a1/mpich-4.0a1.tar.gz 下载 MPICH 源代码。

# 依赖库

## MKL

由 https://software.intel.com/content/www/us/en/develop/tools/oneapi/components/onemkl.html 下载 MKL 安装包。

安装过程同 1.1.2 Intel C++ 编译器。

MKL库位于 `目标路径/oneapi/mkl/latest`

## FFTW

由 http://fftw.org/fftw-3.3.9.tar.gz 下载 FFTW 源代码。

```shell
tar -xzvf fftw-3.3.9.tar.gz
mkdir fftw-3.3.9-build
cd fftw-3.3.9-build/
../fftw-3.3.9/configure --prefix=目标绝对路径
make
make install
```


## ELPA

由 https://gitlab.mpcdf.mpg.de/elpa/elpa.git 下载 ELPA 源代码。需要先运行一个.sh文件，才会生成configure文件

``` shell
tar -xzvf elpa-master.tar.gz
mkdir elpa-master-build
cd elpa-master-build
../elpa-master/configure \
	--prefix=目标绝对路径 \
	FC="mpiifort" FCFLAGS="-O2" CC="mpiicc" CFLAGS="-O2" --enable-avx512 --enable-openmp \
	SCALAPACK_LDFLAGS="-I$(MKL_ROOT)/include/intel64/lp64 -L$(MKL_ROOT)/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -Wl,-rpath,$(MKL_ROOT)/lib/intel64" \
	SCALAPACK_FCFLAGS="-I$(MKL_ROOT)/include/intel64/lp64 -L$(MKL_ROOT)/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -Wl,-rpath,$(MKL_ROOT)/lib/intel64"
make
make install
```

安装完毕后，打开安装后的 `目标绝对路径/include`，记录该目录下的文件名（如 `elpa_openmp-2021.05.002`），用于后文修改ABACUS的 Makefile.system 文件。（需要module load mkl/lib/intel64所在的环境）

## Libxc

由 http://www.tddft.org/programs/libxc/down.php?file=5.0.0/libxc-5.0.0.tar.gz 下载 Libxc 源代码。(若要使用cmake安装libxc，则使用第二种cmake方法安装libxc)

```shell
tar -xzvf libxc-5.0.0.tar.gz
mkdir libxc-5.0.0-build
cd libxc-5.0.0-build/
../libxc-5.0.0/configure --prefix=目标绝对路径
make
make install
```

下述安装中，-DCMAKE_INSTALL_PREFIX是选择安装路径，可删，-j X中X可选8or12

```shell
tar -xzvf libxc-5.0.0.tar.gz
mkdir libxc
cd libxc-5.0.0
cmake -B build -DCMAKE_INSTALL_PREFIX=/home/jghan/resource/libxc
cmake --build build -j X
cmake --install build
```

## cereal

由 https://github.com/USCiLab/cereal/archive/v1.3.0.tar.gz 下载 cereal 源代码。

```shell
tar -xzvf cereal-1.3.0.tar.gz -C 目标路径
```

# ABACUS

由 https://github.com/abacusmodeling/abacus-develop.git 下载 ABACUS 源代码。

修改 `abacus-develop/source/Makefile.vars` 中各路径名。（注意：每一行路径后不允许有空格或制表符）

打开 `abacus-develop/source/Makefile.system`，在第23行中的 `ELPA_INCLUDE_DIR = ${ELPA_DIR}/include/` 后加入 2.3 中记录的elpa头文件夹名字。如改为 `ELPA_INCLUDE_DIR = ${ELPA_DIR}/include/elpa_openmp-2021.05.002`。

```shell
cd abacus-develop/ABACUS.develop/source
make
```

ABACUS可执行文件为 `abacus-develop/bin/ABACUS.mpi`

示例：`Makefile.vars`文件的具体设置（以lizc_xdb服务器为例）
```shell
FORTRAN       = ifort
CPLUSPLUS     = icpc
CPLUSPLUS_MPI = mpiicpc

LAPACK_DIR    = /public/software/compiler/intel/oneapi/mkl/latest

FFTW_DIR      = /public/home/lizc_xdb/ABACUS/fftw-3.3.9/fftw-3.3.9-build

ELPA_DIR      = /public/home/lizc_xdb/ABACUS/ELPa/elpa-master-build
ELPA_INCLUDE_DIR = ${ELPA_DIR}/include/elpa_openmp-2021.11.001

CEREAL_DIR    = /public/home/lizc_xdb/ABACUS/cereal/cereal-1.3.0

BOOST_DIR      =/public/home/lizc_xdb/ABACUS/boost-1.76.0
# LIBXC_DIR     = /public/software/libxc-5.0.0

# LIBTORCH_DIR  = /public/software/libtorch
# LIBNPY_DIR    = /public/software/libnpy

OBJ_DIR = obj
OBJ_DIR_serial = obj_serial
NP = 14

```

在这里使用的是  Open MPI编译器 ，在`Makefile.system`文件中需要打开22行注释`ELPA_LIB     = -L${ELPA_LIB_DIR} -lelpa_openmp -Wl,-rpath=${ELPA_LIB_DIR}`并注释掉23行。
`LIBS`可以根据`Makefile.vars`文件中具体设置进行添加。
例如：`LIBS = -lifcore -lm -lpthread ${LAPACK_LIB} ${FFTW_LIB} ${ELPA_LIB} ${BOOST_LIB}`


# 使用CMake安装

也需要准备好前面的库文件（LAPACK、ELPA>=2017、CEREAL等），且CMake>=3.16[[CMake 安装]]

```shell
cmake -B build -DCMAKE_CXX_COMPILER=mpiicpc -DELPA_DIR=/elpa安装目录/ -DCMAKE_INSTALL_PREFIX=/ABACUS安装目录/ -DENABLE_DEEPKS=1 -DTorch_DIR=/Torch目录/ -Dlibnpy_INCLUDE_DIR=/libnpy目录/ -DLibxc_DIR=/libxc目录/ -DCEREAL_INCLUDE_DIR=$Path to the parent folder of `cereal/cereal.hpp`
cmake --build build -j X
cmake --install build
```
CEREAL需要写到include目录。
使用cmake安装，需要现在/cmake/FingELPA.cmake 文件中写入安装好的带有ELPA版本名称的文件名。
需要注意icc版本（icc -v ）和gcc（g++ -v）的兼容性问题，否则会在build时出现“gmake error”
[ABACUS 3.0 安装笔记 - 知乎 (zhihu.com)](https://zhuanlan.zhihu.com/p/574031713)




# install for JG in 怀柔Dell服务器

首先找到elpa安装绝对路径，找到例如elpa-2021.11/include/elpa_openmp-2021.11.001
然后找到abacus目录下的cmake/FindElpa.cmake文件，修改find_path中的PATH_SUFFIXES那一行，在最后添加一个"include/elpa_openmp-2021.11.001"

```shell
../elpa-new_release_2021.11.001/configure \
	--prefix=/home/jghan/resource/elpa-2021.11 \
	FC="mpiifort" FCFLAGS="-O2" CC="mpiicc" CFLAGS="-O2" --enable-avx512 --enable-openmp \
	SCALAPACK_LDFLAGS="-I/home/app/intel2020u4/mkl/include/intel64/lp64 -L/home/app/intel2020u4/mkl/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -Wl,-rpath,/home/app/intel2020u4/mkl/lib/intel64" \
	SCALAPACK_FCFLAGS="-I/home/app/intel2020u4/mkl/include/intel64/lp64 -L/home/app/intel2020u4/mkl/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -Wl,-rpath,/home/app/intel2020u4/mkl/lib/intel64"
```

```shell
cmake -B build -DCMAKE_INSTALL_PREFIX=/home/jghan/software/abacus/ -DCMAKE_CXX_COMPILER=mpiicpc -DELPA_DIR=/home/jghan/resource/elpa-2021.11/ -DCMAKE_INSTALL_PREFIX=/home/jghan/software/abacus-develop/ -DLibxc_DIR=/home/jghan/resource/libxc-6.2.2/ -DLIBRI_DIR=/home/jghan/resource/LibRI -DLIBCOMM_DIR=/home/jghan/resource/LibComm -DCEREAL_INCLUDE_DIR=/home/jghan/resource/cereal/cereal-1.3.2/include

cmake --build build -j X

cmake --install build
```

注：第一步"cmake -B build ..."只需要在首次配置或在修改了CMake配置文件（如CMakeLists.txt）时执行。如果只修改了源代码而没有修改配置，通常不需要再运行这一步。

# 软件及各种依赖的安装目录 in Dell:

```shell
ABACUS:		/home/jghan/software/abacus-develop

cmake:		/home/jghan/resource/cmake-3.27.8-linux-x86_64

cereal:		/home/jghan/resource/cereal

elpa:		/home/jghan/resource/elpa-2021.11

fftw:		/home/jghan/resource/fftw-3.3.9

openmpi:	/home/jghan/resource/openmpi-4.1.0

libxc:		/home/jghan/resource/libxc-6.2.2

libRI:		/home/jghan/resource/LibRI

libComm:	/home/jghan/resource/LibComm


gcc:		/home/app/gcc10.2

mkl: 		/home/app/intel2020u4/mkl/
```


# install for JG in Delta服务器(未完成)

```shell
../elpa-new_release_2021.11.001/configure \
	--prefix=/home/jghan/resource/elpa-2021.11 \
	FC="mpiifort" FCFLAGS="-O2" CC="mpiicc" CFLAGS="-O2" --enable-avx512 --enable-openmp \
	SCALAPACK_LDFLAGS="-I/home/app/intel2020u4/mkl/include/intel64/lp64 -L/home/app/intel2020u4/mkl/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -Wl,-rpath,/home/app/intel2020u4/mkl/lib/intel64" \
	SCALAPACK_FCFLAGS="-I/home/app/intel2020u4/mkl/include/intel64/lp64 -L/home/app/intel2020u4/mkl/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -Wl,-rpath,/home/app/intel2020u4/mkl/lib/intel64"
```

```shell
cmake -B build -DCMAKE_INSTALL_PREFIX=/home/jghan/software/abacus/ -DCMAKE_CXX_COMPILER=mpiicpc -DELPA_DIR=/home/jghan/resource/elpa-2021.11/ -DCMAKE_INSTALL_PREFIX=/home/jghan/software/abacus-develop/ -DLibxc_DIR=/home/jghan/resource/libxc-6.2.2/ -DLIBRI_DIR=/home/jghan/resource/LibRI -DLIBCOMM_DIR=/home/jghan/resource/LibComm -DCEREAL_INCLUDE_DIR=/home/jghan/resource/cereal/cereal-1.3.2/include

cmake --build build -j X

cmake --install build
```

# 软件及各种依赖的安装目录 in Delta:（未完成）

```shell
gcc:		/home/app/gcc10.2

ABACUS:		/home/jghan/software/abacus-develop

cmake:		/home/jghan/resource/cmake-3.27.8-linux-x86_64

cereal:		/home/jghan/resource/cereal

elpa:		/home/jghan/resource/elpa-2021.11

fftw:		/home/jghan/resource/fftw-3.3.9

openmpi:	/home/jghan/resource/openmpi-4.1.0

libxc:		/home/jghan/resource/libxc-6.2.2

libRI:		/home/jghan/resource/LibRI

libComm:	/home/jghan/resource/LibComm


mkl: 		/home/soft/intel_oneapi/mkl/2021.3.0  ## ${MKLROOT}
```

