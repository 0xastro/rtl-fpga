# FPGA_Playground
As mentioned, It's a playground :!

> The development was based on a container with Ubuntu 14.04 base image. 
> The Native OS: OS X

#### TOOLS 
- Xilinx: Vivado HL WebPACK
- Intel: Modelsim

#### Requirements to remotely execute the development tools from docker:
> To forward display X11 Window, Its a must to install the following tools:
- socat
- XQuartz
Execute:
```
brew install socat
socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```
and
```
brew install xquartz
open -a Xquartz 
```
> configure XQuartz to "Allow connections from network clients" from settings, and reboot 

#### Running the docker Image:

```
xhost + 127.0.0.1
docker run -it -e DISPLAY=host.docker.internal:0 hdl_fpga
```


### Experiment1 Results Qam Mapper > wireless communication
<p align="center">
  <img src="https://github.com/astro7x/FPGA_Playground/blob/master/qam.png"/>
</p>

- compile and simulate the design with GHDL
```sh
ghdl -a some_design.vhd testbench.vhd
```
- build an executable for the testbench.
```sh
ghdl -e testbench_entity_name
```
- sink the waveform to a file.
```sh
ghdl -r testbench_entity_name --vcd=file_name.vcd 
```

- simulate the waveforms using GTKWave
```sh
 gtkwave file_name.vcd
```
