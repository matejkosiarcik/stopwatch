from __future__ import absolute_import, division, print_function, unicode_literals
import argparse
import datetime
import sys
import termios
import threading
import time


class Timer:
    @property
    def is_running(self):
        return self._is_running

    def __init__(self, callback):
        self._accumulated_absolute = datetime.timedelta()
        self._accumulated_relative = datetime.timedelta()
        self._callback = callback
        self._is_running = False
        self._lap = 1
        self._last_now = datetime.datetime.utcfromtimestamp(0)
        self._last_start = datetime.datetime.utcfromtimestamp(0)
        self._thread = threading.Thread()

    def start(self):
        assert not self._is_running
        self._is_running = True
        self._last_start = datetime.datetime.utcnow()
        self._thread = threading.Thread(target=self._loop)
        self._thread.start()

    def stop(self):
        assert self._is_running
        self._is_running = False
        self._thread.join()
        self._accumulated_relative += (self._last_now - self._last_start)
        self._accumulated_absolute += (self._last_now - self._last_start)

    def toggle(self):
        if self._is_running:
            self.stop()
        else:
            self.start()

    def lap(self):
        # technically we could update even when running
        # but it is safer/easier not to
        # mainly regarding printing (newlines would mangle)
        assert not self._is_running
        self._lap += 1
        self._accumulated_relative = datetime.timedelta()
        self._callback(self._lap, self._accumulated_relative,
                       self._accumulated_absolute)

    def _loop(self):
        while self.is_running:
            self._last_now = datetime.datetime.utcnow()
            self._callback(self._lap, self._accumulated_relative +
                           (self._last_now - self._last_start),
                           self._accumulated_absolute +
                           (self._last_now - self._last_start))
            time.sleep(0.001)


def main(argv = None):
    """Main script function"""

    # get arguments when not available
    if argv is None:
        argv = sys.argv

    # parse arguments
    parser = argparse.ArgumentParser()
    parser.parse_args(argv[1:])

    # print usage
    print("Controls:\n"
          "  <Enter>      - new lap\n"
          "  <Space>      - pause/continue\n"
          "  <ESC> or <Q> - quit\n")
    print("        split-time     total-time")
    print("       ------------   ------------")

    # well, get to work
    program()


def program():
    # setup
    attributes = termios.tcgetattr(sys.stdin.fileno())
    attributes[3] = attributes[3] & ~termios.ECHO
    attributes[3] = attributes[3] & ~termios.ICANON
    termios.tcsetattr(sys.stdin.fileno(), termios.TCSANOW, attributes)

    # function to print values for user
    def print_update(lap, relative_delta, absolute_delta):
        sys.stdout.write("\rlap " + str(lap) + ": " +
                         delta_formatted(relative_delta) + " - " +
                         delta_formatted(absolute_delta))
        sys.stdout.flush()

    timer = Timer(print_update)
    timer.start()

    while True:
        command = sys.stdin.read(1).lower()
        if command == "q" or command == chr(27):
            if timer.is_running:
                timer.stop()
            break
        elif command == " ":
            timer.toggle()
        elif command == "\r" or command == "\n":
            should_restart = timer.is_running
            if should_restart:
                timer.stop()
            sys.stdout.write("\n")
            timer.lap()
            if should_restart:
                timer.start()
    sys.stdout.write("\n")


def delta_formatted(delta):
    milliseconds = str(delta.microseconds // 1000).rjust(3, str("0"))
    seconds = str(delta.seconds % 60).rjust(2, str("0"))
    minutes = str((delta.seconds // 60) % 60).rjust(2, str("0"))
    hours = str(delta.seconds // 3600 + delta.days * 24).rjust(2, str("0"))
    return hours + ":" + minutes + ":" + seconds + "." + milliseconds


if __name__ == "__main__":
    main(sys.argv)
