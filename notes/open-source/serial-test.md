# SerialTest
[wh201906/SerialTest - GitHub](https://github.com/wh201906/SerialTest)

## Build
```bash
sudo apt update && sudo apt install qtbase5-dev qt5-qmake libqt5serialport5-dev qtconnectivity5-dev

git clone https://github.com/wh201906/SerialTest.git --depth=1
cd SerialTest
mkdir build && cd build

wget https://www.qcustomplot.com/release/2.1.1/QCustomPlot-source.tar.gz
tar -xzf QCustomPlot-source.tar.gz
cp qcustomplot-source/qcustomplot.* ../src

export QT_SELECT=qt5
qmake ../src
make -j4 && make clean
./SerialTest # Test

sudo apt remove --purge qtbase5-dev qt5-qmake && sudo apt autoremove --purge
```

## Desktop
```bash
sudo mkdir /opt/SerialTest
sudo cp ./SerialTest /opt/SerialTest
sudo curl -L -o /opt/SerialTest/wh201906.png "https://github.com/wh201906.png"

sudo vim /usr/share/applications/serialtest.desktop
```

```ini
[Desktop Entry]
Type=Application
Name=SerialTest
Exec=/bin/sh -c "/opt/SerialTest/SerialTest --config-path=$HOME/.config/SerialTest/preference.ini"
Icon=/opt/SerialTest/wh201906.png
Categories=Development;
```
