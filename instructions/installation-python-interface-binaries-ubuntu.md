# Installation of LAL's python interface from binaries (Ubuntu)

Be aware that the steps below do not actually install LAL in your computer; you will be able to use LAL but Windows will not be aware that you "installed" it, that is, you will not be able to remove LAL via the useful

	$ sudo apt remove ...

Nevertheless, you will be able to remove the files by hand if you remember where you put them. Alternatively, you can make a `.deb` package and install it, but its best to keep things simple.

Head over to [LAL's official webpage](https://cqllab.upc.edu/lal) and download the C++17 core. The file should be named `ubuntu20-c++-libs.zip`. Then download the python interface. The file should be named `ubuntu20-python3.8-libs.zip`.

## The LAL Python interface for Anaconda 3

For the sake of simplicity, navigate to your Anaconda 3 installation directory. This is usually

	/home/%username%/anaconda3

Extract the files inside the `lib` folder of `ubuntu20-c++-libs.zip` into `anaconda3/lib`. Next, extract the `python3.8` folder of `ubuntu20-python3.8-libs.zip` and merge it with `anaconda3/lib/python3.8`. Finally, open a command line terminal and run the following commands

	$ cd ~/anaconda3/lib/python3.8
	$ cp /lib/x86_64-linux-gnu/libstdc++.so.6 .

In case the second command fails, repeat it after installing [GNU's `g++-11` compiler](https://www.gnu.org/software/gcc/)

	$ sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
	$ sudo apt install g++-11

These two commands are a summary of [this guide](https://lindevs.com/install-g-on-ubuntu/).

## The LAL Python interface (not for Anaconda 3)

### With `sudo` permissions

#### Install LAL C++

With `sudo` permissions, the easiest procedure to installing the library may be to move the `include` and `lib` folders into the `/usr` directory. For this, execute the commands

	$ sudo cp -r include/* /usr/include/
	$ sudo cp lib/* /usr/lib

#### Install LAL Python

Uncompress the `.zip` file in a directory of your choice and navigate with your terminal to that directory. You should see a folder called `lib`. Run the following command to move LAL's python interface into your system directory.

	$ sudo cp -r lib/python3.8/* /usr/lib/python3.8

### Without `sudo` permissions

#### Install LAL C++

If you do not have `sudo` permissions, an alternative way of installing LAL is to place the `include` and `lib` folders inside a directory of your choice, say, `/path/to/LAL` and then updating the necessary environment variables. To do so, get the full path of these directories. The path can be easily found by opening a terminal in said directories (navigate into them with a file browser, right-click on them and select `Open Terminal here` or similar) and running

	$ echo $PWD

Finally, update the environment variables by running the following commands:

	$ export CPLUS_INCLUDE_PATH=/path/to/LAL/include:$CPLUS_INCLUDE_PATH
	$ export LD_LIBRARY_PATH=/path/to/LAL/lib:$LD_LIBRARY_PATH

We recommend to add these two commands in your `.bashrc` file, or equivalent, so that they are run automatically every time a new terminal is opened.

#### Install LAL Python

We suggest you uncompress the `lib` folder within the `ubuntu20-python3.8-libs.zip` file into the same directory you saved the `lib` directory within `ubuntu20-c++-libs.zip` when installing LAL C++. Now, update the appropriate environment path

	$ export PYTHONPATH=/path/to/LAL/lib/python3.8:$PYTHONPATH
	
We recommend to add this command in your `.bashrc` file, or equivalent, so that it is run automatically every time a new terminal is opened.
