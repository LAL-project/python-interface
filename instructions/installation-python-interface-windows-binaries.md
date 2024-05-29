# Installation of LAL's python interface from binaries (Windows)

**NOTE** *Binaries for Windows are usually provided with an installer to install LAL in Anaconda 3. We suggest you visit [LAL's official webpage](https://cqllab.upc.edu/lal/) for further information.*

These instructions are for those people who

- don't want to use an installer, or
- don't want to use LAL in Anaconda 3, or
- the installer one provided doesn't work on their system, or
- there is no installer for the release they would like to use,

Be aware that the steps below do not actually install LAL in your computer; you will be able to use LAL but Windows will not be aware that you "installed" it, that is, you will not be able to remove LAL via the "Remove programs" utility in Windows. Nevertheless, you will be able to remove the files by hand if you remember where you put them.

Head over to [LAL's official webpage](https://cqllab.upc.edu/lal). Then, download the C++17 core. The file should be named `windows10-c++-libs-msys64.zip`.

Then download the python interface.

- If you want to use LAL in Anaconda, make sure to download the interface *for Anaconda 3*. The download file should be named `windows10-python3.9-libs-anaconda.zip`.
- If you don't want to use it in Anaconda, make sure that the download file is named `windows10-python3.9-libs-msys64.zip`.

## The python interface for Anaconda 3

Open a file browser and navigate to Anaconda 3 installation directory in your computer. It is usually

	C:/Users/%username%/anaconda3/

From there, navigate to `Lib` and then `site-packages`.

The `windows10-python3.9-libs-anaconda.zip` python interface file that you downloaded should have two folders inside, named `lal` and `laldebug` respectively. Uncompress these two folders in the directory above. **NOTE** These two folders contain the `libstdc++-6.dll` copied from the `MSYS2` installation on a Windows 10 (i5-CPU) -- this might be a source of errors.

Now, navigate to the `bin` folder in `windows10-c++-libs-msys64.zip` and copy

- the file `liblal.dll` into the `lal` directory just created,
- the file `liblaldebug.dll` into the `laldebug` directory just created.

You should be ready to use Python LAL with Anaconda 3.

## The python interface for MSYS2

In a file browser, navigate to your `msys64` installation directory. It is usually

	C:/msys64
	
We compiled LAL to be used with `mingw64`. Now,

- uncompress the files inside `bin` in `windows10-c++-libs-msys64.zip` into `mingw64/bin`. You can further uncompress the files inside `lib`, this time into `mingw64/lib`, should you want to use static libraries,
- uncompress the folders `lal` and `laldebug` within `windows10-python3.9-libs-msys64.zip` into `mingw64/lib/python3.9`.

You should be ready to use Python LAL with `mingw64`.
