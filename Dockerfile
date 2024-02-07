FROM ros:noetic-ros-core

WORKDIR /
RUN mkdir -p /catkin_ws/src
WORKDIR /catkin_ws/src

RUN apt-get update && \
    apt-get install -y git python3 python3-pip ros-noetic-rosbridge-server ros-noetic-tf2-web-republisher && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y ros-noetic-compressed-image-transport ros-noetic-camera-info-manager
RUN apt-get update && apt-get install -y ros-noetic-joy ros-noetic-teleop-twist-joy ros-noetic-teleop-twist-keyboard ros-noetic-amcl ros-noetic-map-server ros-noetic-move-base ros-noetic-urdf ros-noetic-xacro ros-noetic-rqt-image-view ros-noetic-gmapping ros-noetic-navigation ros-noetic-joint-state-publisher ros-noetic-robot-state-publisher ros-noetic-diagnostic-updater ros-noetic-slam-gmapping ros-noetic-dwa-local-planner ros-noetic-joint-state-publisher-gui ros-noetic-gazebo-ros-pkgs ros-noetic-gazebo-ros-control
RUN git clone -b noetic https://github.com/rigbetellabs/tortoisebot.git



COPY ./tortoisebot_waypoints /catkin_ws/src/tortoisebot_waypoints

WORKDIR /catkin_ws

RUN /bin/bash -c "source /opt/ros/noetic/setup.bash; cd /catkin_ws; catkin_make"

RUN echo source /catkin_ws/devel/setup.bash >> ~/.bashrc

CMD /bin/bash -c "source /catkin_ws/devel/setup.bash; rostest tortoisebot_waypoints waypoints_test.test"