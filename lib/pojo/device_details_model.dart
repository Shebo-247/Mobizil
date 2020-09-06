class DeviceDetails {
  String os, chipset, internalMemory, camera, display, battery, price;

  DeviceDetails({
    this.os,
    this.internalMemory,
    this.chipset,
    this.camera,
    this.display,
    this.battery,
    this.price,
  });

  String get getOS => os;
  String get getInternalMemory => internalMemory;
  String get getChipset => chipset;
  String get getCamera => camera;
  String get getDisplay => display;
  String get getBattery => battery;
  String get getPrice => price;
}
