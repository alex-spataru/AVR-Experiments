# AVR Experiments

Repository with some AVR example projects that I am developing to familiarize myself with AVRs.
Feel free to use and modify these programs in your own quest to learn AVR programming.

## MCU Notes

To test these projects, I am using a custom board based on the AtMega328P and an USBAsp v2.0 programmer, you may need to change the `MCU-Setup.pri` file in order to suit your hardware.

You can see some photos and EAGLE files for my custom board in the 'MCU' folder (which is under construction).

![Board running Fading LED example](https://raw.githubusercontent.com/alex-spataru/AVR-Experiments/master/MCU/MCU_Small.jpg)

**Photo Description:** *Custom board running the Fading LED example*

## Compiling

These projects are designed to be compiled and uploaded with [Qt Creator](http://doc.qt.io/qtcreator/). Once you have Qt Creator installed, open the `*.pro` files withing Qt Creator and hit the run button to test the projects. You can change the MCU, programmer, serial port and other options in the `MCU-Setup.pri` file that is loaded with each project.

## License

These projects are released under the DBAD license, for more information, click [here](LICENSE.md).
